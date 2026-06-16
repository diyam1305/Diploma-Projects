using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;

namespace Quiz_Management_System
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["mycon"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlEmail.Visible = true;
                pnlOTP.Visible = false;
                pnlReset.Visible = false;
            }
        }

        protected void btnSendOTP_Click(object sender, EventArgs e)
        {
            if (txtEmail.Text.Trim() == "")
            {
                ShowMsg("Please enter email", true);
                return;
            }

            SqlCommand cmd = new SqlCommand("P_UserAdmin", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@USER_EMAILID", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@Event", "SelectByEmail");

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                ShowMsg("Email not found", true);
                return;
            }

            Random r = new Random();
            int otp = r.Next(100000, 999999);

            Session["OTP"] = otp;
            Session["User_ID"] = dt.Rows[0]["USER_ID"].ToString();

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("quiz1324@gmail.com");
            mail.To.Add(txtEmail.Text.Trim());
            mail.Subject = "OTP Verification";
            mail.Body = "Your OTP is: " + otp;

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.EnableSsl = true;
            smtp.Credentials =
                new System.Net.NetworkCredential("quiz1324@gmail.com", "lvzkrnwnyucpxcvg");
            smtp.Send(mail);

            ShowMsg("OTP sent successfully", false);
            pnlEmail.Visible = false;
            pnlOTP.Visible = true;
        }

        protected void btnVerifyOTP_Click(object sender, EventArgs e)
        {
            if (Session["OTP"] != null &&
                txtOTP.Text.Trim() == Session["OTP"].ToString())
            {
                pnlOTP.Visible = false;
                pnlReset.Visible = true;
            }
            else
            {
                ShowMsg("Invalid OTP", true);
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                ShowMsg("Passwords do not match", true);
                return;
            }

            SqlCommand cmd = new SqlCommand("P_UserAdmin", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@USER_ID", Session["User_ID"]);
            cmd.Parameters.AddWithValue("@USER_PASSWORD", txtNewPassword.Text);
            cmd.Parameters.AddWithValue("@Event", "UpdatePassword");

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            Session["ResetCompleted"] = true;

            ShowMsg("Password reset successful. Redirecting...", false);

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "redirect",
                "setTimeout(function(){window.location='LoginPage.aspx';},2000);",
                true);
        }

        void ShowMsg(string msg, bool error)
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = error ? "message-box error" : "message-box success";
            lblMsg.Text = msg;
        }
    }
}
