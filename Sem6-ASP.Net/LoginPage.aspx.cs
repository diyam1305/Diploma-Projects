//using System;
//using System.Configuration;
//using System.Data;
//using System.Data.SqlClient;
//using System.Text.RegularExpressions;
//using System.Web.UI;

//namespace Quiz_Management_System
//{
//    public partial class LoginPage : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                rbUser.Checked = true;
//                rbAdmin.Checked = false;

//                // Initialize error message display
//                lblErrorMessage.Attributes["class"] = "error-message";
//                lblErrorMessage.Style["display"] = "none";
//            }
//        }

//        protected void btnLogin_Click(object sender, EventArgs e)
//        {
//            string email = txtEmail.Text.Trim();
//            string password = txtPassword.Text.Trim();

//            // Hide previous error messages
//            lblErrorMessage.Style["display"] = "none";
//            lblErrorMessage.Attributes["class"] = "error-message";

//            // SERVER-SIDE EMAIL VALIDATION
//            if (!IsValidEmail(email))
//            {
//                ShowErrorMessage("Please enter a valid email address.");
//                return;
//            }

//            if (string.IsNullOrEmpty(password))
//            {
//                ShowErrorMessage("Please enter your password.");
//                return;
//            }

//            bool adminSelected = rbAdmin.Checked;

//            try
//            {
//                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["mycon"].ConnectionString))
//                {
//                    using (SqlCommand cmd = new SqlCommand("P_UserAdmin", con))
//                    {
//                        cmd.CommandType = CommandType.StoredProcedure;
//                        cmd.Parameters.AddWithValue("@USER_EMAILID", email);
//                        cmd.Parameters.AddWithValue("@USER_PASSWORD", password);
//                        cmd.Parameters.AddWithValue("@Event", "Login");

//                        con.Open();
//                        SqlDataReader dr = cmd.ExecuteReader();

//                        if (dr.Read())
//                        {
//                            bool isActive = Convert.ToBoolean(dr["ISACTIVE"]);
//                            bool isAdmin = Convert.ToBoolean(dr["ISADMIN"]);

//                            // Check if account is active
//                            if (!isActive)
//                            {
//                                ShowErrorMessage("⚠️ Your account is inactive. Please contact the administrator.");
//                                return;
//                            }

//                            // Check if login type matches account type
//                            if (adminSelected && !isAdmin)
//                            {
//                                ShowErrorMessage("❌ This is a User account. Please select 'User' login type instead.");
//                                return;
//                            }

//                            if (!adminSelected && isAdmin)
//                            {
//                                ShowErrorMessage("❌ This is an Admin account. Please select 'Admin' login type instead.");
//                                return;
//                            }

//                            // Successful login - Set session variables
//                            Session["USER_ID"] = Convert.ToInt32(dr["USER_ID"]);
//                            Session["USERNAME"] = dr["USER_FIRSTNAME"] + " " + dr["USER_LASTNAME"];
//                            Session["ISADMIN"] = isAdmin;

//                            // Redirect based on user type
//                            if (isAdmin)
//                                Response.Redirect("~/Content.aspx", false);
//                            else
//                                Response.Redirect("~/UserContentPage.aspx", false);

//                            Context.ApplicationInstance.CompleteRequest();
//                        }
//                        else
//                        {
//                            ShowErrorMessage("❌ Invalid email or password. Please check your credentials and try again.");
//                        }
//                    }
//                }
//            }
//            catch (SqlException sqlEx)
//            {
//                ShowErrorMessage("⚠️ Database error occurred. Please try again later.");
//                System.Diagnostics.Debug.WriteLine("SQL Error: " + sqlEx.Message);
//            }
//            catch (Exception ex)
//            {
//                ShowErrorMessage("⚠️ An unexpected error occurred. Please try again later.");
//                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
//            }
//        }

//        private bool IsValidEmail(string email)
//        {
//            if (string.IsNullOrWhiteSpace(email))
//                return false;

//            string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
//            return Regex.IsMatch(email, pattern);
//        }

//        protected void lnkRegister_Click(object sender, EventArgs e)
//        {
//            Response.Redirect("UserRegistrationPage.aspx", false);
//            Context.ApplicationInstance.CompleteRequest();
//        }

//        private void ShowErrorMessage(string message)
//        {
//            lblErrorMessage.InnerHtml = message;
//            lblErrorMessage.Attributes["class"] = "error-message show";
//            lblErrorMessage.Style["display"] = "block";
//        }

//        protected void btnLogout_Click(object sender, EventArgs e)
//        {
//            Session.Clear();
//            Session.Abandon();

//            if (Request.Cookies["ASP.NET_SessionId"] != null)
//            {
//                Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
//                Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddDays(-1);
//            }

//            Response.Redirect("~/LoginPage.aspx", false);
//            Context.ApplicationInstance.CompleteRequest();
//        }
//    }
//}





using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace Quiz_Management_System
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rbUser.Checked = true;
                rbAdmin.Checked = false;

                // Initialize error message display
                lblErrorMessage.Attributes["class"] = "error-message";
                lblErrorMessage.Style["display"] = "none";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Hide previous error messages
            lblErrorMessage.Style["display"] = "none";
            lblErrorMessage.Attributes["class"] = "error-message";

            // SERVER-SIDE EMAIL VALIDATION
            if (!IsValidEmail(email))
            {
                ShowErrorMessage("Please enter a valid email address.");
                return;
            }

            if (string.IsNullOrEmpty(password))
            {
                ShowErrorMessage("Please enter your password.");
                return;
            }

            bool adminSelected = rbAdmin.Checked;

            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["mycon"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("P_UserAdmin", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@USER_EMAILID", email);
                        cmd.Parameters.AddWithValue("@USER_PASSWORD", password);
                        cmd.Parameters.AddWithValue("@Event", "Login");

                        con.Open();
                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.Read())
                        {
                            bool isActive = Convert.ToBoolean(dr["ISACTIVE"]);
                            bool isAdmin = Convert.ToBoolean(dr["ISADMIN"]);

                            // Check if account is active
                            if (!isActive)
                            {
                                ShowErrorMessage("⚠️ Your account is inactive. Please contact the administrator.");
                                return;
                            }

                            // Check if login type matches account type
                            if (adminSelected && !isAdmin)
                            {
                                ShowErrorMessage("❌ This is a User account. Please select 'User' login type instead.");
                                return;
                            }

                            if (!adminSelected && isAdmin)
                            {
                                ShowErrorMessage("❌ This is an Admin account. Please select 'Admin' login type instead.");
                                return;
                            }

                            // Successful login - Set session variables
                            Session["USER_ID"] = Convert.ToInt32(dr["USER_ID"]);
                            Session["USERNAME"] = dr["USER_FIRSTNAME"] + " " + dr["USER_LASTNAME"];
                            Session["ISADMIN"] = isAdmin;

                            // Redirect based on user type
                            if (isAdmin)
                                Response.Redirect("~/Content.aspx", false);
                            else
                                Response.Redirect("~/UserContentPage.aspx", false);

                            Context.ApplicationInstance.CompleteRequest();
                        }
                        else
                        {
                            ShowErrorMessage("❌ Invalid email or password. Please check your credentials and try again.");
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                ShowErrorMessage("⚠️ Database error occurred. Please try again later.");
                System.Diagnostics.Debug.WriteLine("SQL Error: " + sqlEx.Message);
            }
            catch (Exception ex)
            {
                ShowErrorMessage("⚠️ An unexpected error occurred. Please try again later.");
                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
            }
        }

        private bool IsValidEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email))
                return false;

            string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
            return Regex.IsMatch(email, pattern);
        }

        protected void lnkRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserRegistrationPage.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void ShowErrorMessage(string message)
        {
            lblErrorMessage.InnerHtml = message;
            lblErrorMessage.Attributes["class"] = "error-message show";
            lblErrorMessage.Style["display"] = "block";
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            if (Request.Cookies["ASP.NET_SessionId"] != null)
            {
                Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
                Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddDays(-1);
            }

            Response.Redirect("~/LoginPage.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}