using System;
using System.Web;
using System.Web.UI;

namespace Quiz_Management_System.User
{
    public partial class UserDashboard : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER_ID"] == null)
            {
                Response.Redirect("~/LoginPage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Session["USERNAME"] != null)
                {
                    string username = Session["USERNAME"].ToString();
                    lblUser.Text = username;
                    if (!string.IsNullOrEmpty(username))
                    {
                        lblInitial.Text = username.Substring(0, 1).ToUpper();
                    }
                }
            }
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear session
            Session.Clear();
            Session.Abandon();

            // Remove session cookie
            if (Request.Cookies["ASP.NET_SessionId"] != null)
            {
                Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
                Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddDays(-1);
            }

            // Redirect to login page
            Response.Redirect("~/LoginPage.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}