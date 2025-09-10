using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

namespace TajnoorPortfolio
{
    public partial class SaveMessage : System.Web.UI.Page
    {
        [WebMethod]
        public static object SaveMessageData(string name, string email, string subject, string message)
        {
            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PortfolioDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "INSERT INTO Messages (Name, Email, Subject, MessageText) VALUES (@Name, @Email, @Subject, @Message)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Subject", subject);
                        cmd.Parameters.AddWithValue("@Message", message);
                        cmd.ExecuteNonQuery();
                    }
                }

                return new { success = true };
            }
            catch (Exception ex)
            {
                return new { success = false, error = ex.Message };
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST")
            {
                string name = Request.Form["name"];
                string email = Request.Form["email"];
                string subject = Request.Form["subject"];
                string message = Request.Form["message"];

                Response.Clear();
                Response.ContentType = "application/json";

                try
                {
                    string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PortfolioDB"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        string query = "INSERT INTO Messages (Name, Email, Subject, MessageText) VALUES (@Name, @Email, @Subject, @Message)";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Name", name);
                            cmd.Parameters.AddWithValue("@Email", email);
                            cmd.Parameters.AddWithValue("@Subject", subject);
                            cmd.Parameters.AddWithValue("@Message", message);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    Response.Write("{\"success\": true}");
                }
                catch (Exception ex)
                {
                    Response.Write("{\"success\": false, \"error\": \"" + ex.Message + "\"}");
                }

                Response.End();
            }
        }
    }
}