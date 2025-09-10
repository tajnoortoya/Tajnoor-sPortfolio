using System;
using System.Web;
using System.Web.UI;

namespace TajnoorPortfolio
{
    public partial class Login : System.Web.UI.Page
    {
        // Fixed credentials (in plain text)
        private const string FixedUsername = "admin";
        private const string FixedPassword = "admin123";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                Response.Redirect("Dashboard.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (AuthenticateUser(username, password))
            {
                Session["Admin"] = username;
                if (chkRemember.Checked)
                {
                    HttpCookie cookie = new HttpCookie("AdminAuth");
                    cookie.Value = username;
                    cookie.Expires = DateTime.Now.AddDays(7);
                    Response.Cookies.Add(cookie);
                }
                Response.Redirect("Dashboard.aspx");
            }
            else
            {
                lblError.Text = "Invalid username or password. Try: admin/admin123";
                lblError.Visible = true;
            }
        }

        private bool AuthenticateUser(string username, string password)
        {
            // Simple comparison (case-sensitive)
            return (username == FixedUsername && password == FixedPassword);
        }

        // To change credentials, simply update the constants above
        // private const string FixedUsername = "your_username";
        // private const string FixedPassword = "your_password";
    }
}