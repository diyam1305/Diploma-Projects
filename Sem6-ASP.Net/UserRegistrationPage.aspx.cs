using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;

namespace Quiz_Management_System
{
    public partial class UserRegistrationPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["RegSuccess"] != null)
            {
                lblMessage.Text = Session["RegSuccess"].ToString();
                lblMessage.CssClass = "message-label show";
                lblMessage.Visible = true;
                Session.Remove("RegSuccess");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string firstName = txtfirstname.Text.Trim();
            string lastName = txtlastname.Text.Trim();
            string email = txtemailid.Text.Trim();
            string password = txtpassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(firstName) || string.IsNullOrWhiteSpace(lastName) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            {
                ShowError("Please fill all fields.");
                return;
            }

            string emailPattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
            if (!Regex.IsMatch(email, emailPattern))
            {
                ShowError("Please enter a valid email address, example user@gmail.com");
                return;
            }

            string passwordPattern = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
            if (!Regex.IsMatch(password, passwordPattern))
            {
                ShowError("Password must be at least 8 characters and include uppercase, lowercase, number, and special character.");
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["mycon"].ConnectionString))
                {
                    con.Open();
                    using (SqlCommand checkCmd = new SqlCommand("P_UserAdmin", con))
                    {
                        checkCmd.CommandType = CommandType.StoredProcedure;
                        checkCmd.Parameters.AddWithValue("@USER_EMAILID", email);
                        checkCmd.Parameters.AddWithValue("@Event", "SelectByEmail");

                        using (SqlDataReader reader = checkCmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                ShowError("This email is already registered.");
                                return;
                            }
                        }
                    }

                    using (SqlCommand cmd = new SqlCommand("P_UserAdmin", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@USER_FIRSTNAME", firstName);
                        cmd.Parameters.AddWithValue("@USER_LASTNAME", lastName);
                        cmd.Parameters.AddWithValue("@USER_EMAILID", email);
                        cmd.Parameters.AddWithValue("@USER_PASSWORD", password);
                        cmd.Parameters.AddWithValue("@ISACTIVE", 1);
                        cmd.Parameters.AddWithValue("@ISADMIN", 0);
                        cmd.Parameters.AddWithValue("@Event", "Add");
                        cmd.ExecuteNonQuery();
                    }
                }

                SendWelcomeEmail(email, firstName + " " + lastName);
                Session["RegSuccess"] = "Registration successful. Please login.";
                Response.Redirect("LoginPage.aspx");
            }
            catch (Exception ex)
            {
                ShowError("Error: " + ex.Message);
            }
        }
        protected void lnkBackToLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginPage.aspx");
        }
        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "message-label show";
            lblMessage.Style["display"] = "block"; 
        }
        private void SendWelcomeEmail(string email, string fullName)
        {
            try
            {
                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress("quiz1324@gmail.com");
                    mail.To.Add(email);
                    mail.Subject = "Welcome to Quiz Management System 🎉";
                    mail.Body = $"Hello {fullName},\n\nWelcome to Quiz Management System!";

                    using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
                    {
                        smtp.EnableSsl = true;
                        smtp.Credentials = new NetworkCredential(
                            "quiz1324@gmail.com",
                            "lvzkrnwnyucpxcvg");
                        smtp.Send(mail);
                    }
                }
            }
            catch { }
        }
    }
}