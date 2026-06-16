using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quiz_Management_System
{
    public partial class Dashboard : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] != null)
                {
                    lblUser.Text = Session["username"].ToString();
                    string username = Session["username"].ToString();
                    if (!string.IsNullOrEmpty(username))
                    {
                        lblInitial.Text = username.Substring(0, 1).ToUpper();
                    }
                }
            }
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/LoginPage.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}