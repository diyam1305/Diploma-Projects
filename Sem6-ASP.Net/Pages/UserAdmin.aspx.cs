using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quiz_Management_System.Pages
{
    public partial class UserAdmin : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUserData();
            }
        }

        void BindUserData()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            using (SqlCommand cmd = new SqlCommand("P_UserAdmin", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Event", "SelectAll");

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                grdData.DataSource = dt;
                grdData.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Trim input values
            string firstName = txtF_Name.Text.Trim();
            string lastName = txtL_Name.Text.Trim();
            string email = txtEmail_ID.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Validate required fields
            if (string.IsNullOrEmpty(firstName))
            {
                ShowSweetAlert("error", "Validation Error", "First name is required.");
                return;
            }

            if (string.IsNullOrEmpty(lastName))
            {
                ShowSweetAlert("error", "Validation Error", "Last name is required.");
                return;
            }

            if (string.IsNullOrEmpty(email))
            {
                ShowSweetAlert("error", "Validation Error", "Email is required.");
                return;
            }

            // Validate email format
            if (!IsValidEmail(email))
            {
                ShowSweetAlert("error", "Invalid Email", "Please enter a valid email address.");
                return;
            }

            // Password validation
            bool isUpdate = !string.IsNullOrEmpty(hdnUserID.Value);

            // For new users, password is required
            // For updates, only validate if password field is not empty
            if (!isUpdate || !string.IsNullOrEmpty(password))
            {
                if (string.IsNullOrEmpty(password))
                {
                    ShowSweetAlert("error", "Password Required", "Please enter a password.");
                    return;
                }

                var passwordValidation = ValidatePassword(password);
                if (!passwordValidation.IsValid)
                {
                    ShowSweetAlert("error", "Password Requirements Not Met", passwordValidation.ErrorMessage);
                    return;
                }
            }

            // All validations passed, proceed with database operation
            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                using (SqlCommand cmd = new SqlCommand("P_UserAdmin", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (isUpdate)
                    {
                        cmd.Parameters.AddWithValue("@Event", "Update");
                        cmd.Parameters.AddWithValue("@USER_ID", Convert.ToInt32(hdnUserID.Value));
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@Event", "Add");
                    }

                    cmd.Parameters.AddWithValue("@USER_FIRSTNAME", firstName);
                    cmd.Parameters.AddWithValue("@USER_LASTNAME", lastName);
                    cmd.Parameters.AddWithValue("@USER_EMAILID", email);

                    // Only update password if it's provided
                    if (!string.IsNullOrEmpty(password))
                    {
                        cmd.Parameters.AddWithValue("@USER_PASSWORD", password);
                    }

                    cmd.Parameters.AddWithValue("@ISACTIVE", rblIsActive.SelectedValue);
                    cmd.Parameters.AddWithValue("@ISADMIN", rblIsAdmin.SelectedValue);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                ClearControls();
                BindUserData();

                // Show success message
                string successMessage = isUpdate ? "User updated successfully!" : "User added successfully!";
                ShowSweetAlert("success", "Success!", successMessage);
            }
            catch (Exception ex)
            {
                ShowSweetAlert("error", "Database Error", "An error occurred while saving the user. Please try again.");
            }
        }

        // Validates email format using regex pattern
        private bool IsValidEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email))
                return false;

            string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
            return Regex.IsMatch(email, pattern);
        }

        // Password Requirements:
        // - Minimum 8 characters
        // - Maximum 50 characters
        // - At least one uppercase letter (A-Z)
        // - At least one lowercase letter (a-z)
        // - At least one digit (0-9)
        // - At least one special character
        // - No whitespace allowed
        private PasswordValidationResult ValidatePassword(string password)
        {
            // Check if password is empty or null
            if (string.IsNullOrEmpty(password))
            {
                return new PasswordValidationResult
                {
                    IsValid = false,
                    ErrorMessage = "Password is required."
                };
            }

            // Check minimum length
            if (password.Length < 8)
            {
                return new PasswordValidationResult
                {
                    IsValid = false,
                    ErrorMessage = "Password must be at least 8 characters long."
                };
            }

            // Check maximum length
            if (password.Length > 50)
            {
                return new PasswordValidationResult
                {
                    IsValid = false,
                    ErrorMessage = "Password must not exceed 50 characters."
                };
            }

            // Check for whitespace
            if (password.Contains(" "))
            {
                return new PasswordValidationResult
                {
                    IsValid = false,
                    ErrorMessage = "Password cannot contain spaces."
                };
            }

            // Check for at least one uppercase letter
            if (!Regex.IsMatch(password, @"[A-Z]"))
            {
                return new PasswordValidationResult
                {
                    IsValid = false,
                    ErrorMessage = "Password must contain at least one uppercase letter (A-Z)."
                };
            }

            // Check for at least one lowercase letter
            if (!Regex.IsMatch(password, @"[a-z]"))
            {
                return new PasswordValidationResult
                {
                    IsValid = false,
                    ErrorMessage = "Password must contain at least one lowercase letter (a-z)."
                };
            }

            // Check for at least one digit
            if (!Regex.IsMatch(password, @"[0-9]"))
            {
                return new PasswordValidationResult
                {
                    IsValid = false,
                    ErrorMessage = "Password must contain at least one number (0-9)."
                };
            }

            // Check for at least one special character
            if (!Regex.IsMatch(password, @"[@$!%*?&#^()_+=\-\[\]{};:'"",.<>\/\\|`~]"))
            {
                return new PasswordValidationResult
                {
                    IsValid = false,
                    ErrorMessage = "Password must contain at least one special character (@, $, !, %, *, ?, &, #, etc.)."
                };
            }

            // All validations passed
            return new PasswordValidationResult
            {
                IsValid = true,
                ErrorMessage = string.Empty
            };
        }

        // Display SweetAlert message
        private void ShowSweetAlert(string icon, string title, string message)
        {
            message = message.Replace("'", "\\'");
            title = title.Replace("'", "\\'");

            string script = $@"
                Swal.fire({{
                    icon: '{icon}',
                    title: '{title}',
                    text: '{message}',
                    confirmButtonColor: '{(icon == "success" ? "#10b981" : "#ef4444")}',
                    confirmButtonText: 'OK'{(icon == "success" ? ",timer: 2000,timerProgressBar: true" : "")}
                }});
            ";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "SweetAlert", script, true);
        }

        protected void grdData_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int userID = Convert.ToInt32(grdData.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(conStr))
            using (SqlCommand cmd = new SqlCommand("P_UserAdmin", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Event", "Delete");
                cmd.Parameters.AddWithValue("@USER_ID", userID);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindUserData();
            ShowSweetAlert("success", "Deleted!", "User has been deleted successfully.");
        }

        protected void grdData_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditUser")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = grdData.Rows[index];

                hdnUserID.Value = grdData.DataKeys[index].Value.ToString();
                txtF_Name.Text = (row.FindControl("lblFirstName") as Label).Text;
                txtL_Name.Text = (row.FindControl("lblLastName") as Label).Text;
                txtEmail_ID.Text = (row.FindControl("lblEmail") as Label).Text;

                // Clear password field for security when editing
                txtPassword.Text = "";

                // Fix for Active/Inactive
                string isActiveText = (row.FindControl("lblIsActive") as Label).Text;
                rblIsActive.SelectedValue = isActiveText == "Active" ? "1" : "0";

                // Fix for Admin/User
                string isAdminText = (row.FindControl("lblIsAdmin") as Label).Text;
                rblIsAdmin.SelectedValue = isAdminText == "Admin" ? "1" : "0";

                btnAdd.Text = "Update User";
            }
        }

        void ClearControls()
        {
            txtF_Name.Text = "";
            txtL_Name.Text = "";
            txtEmail_ID.Text = "";
            txtPassword.Text = "";
            rblIsActive.SelectedValue = "1";
            rblIsAdmin.SelectedValue = "0";
            hdnUserID.Value = "";
            btnAdd.Text = "Add User";
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearControls();
        }

        protected void grdData_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdData.PageIndex = e.NewPageIndex;
            BindUserData();
        }
    }

    //Helper class to return password validation results
    public class PasswordValidationResult
    {
        public bool IsValid { get; set; }
        public string ErrorMessage { get; set; }
    }
}