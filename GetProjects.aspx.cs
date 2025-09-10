using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

namespace TajnoorPortfolio
{
    public partial class GetProjects : System.Web.UI.Page
    {
        [WebMethod]
        public static string GetProjectsData()
        {
            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PortfolioDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT Id, Title, Description, ImageUrl, GithubUrl, DetailsUrl, CreatedAt FROM Projects ORDER BY CreatedAt DESC";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        return Newtonsoft.Json.JsonConvert.SerializeObject(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                return "[]";
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Clear();
            Response.ContentType = "application/json";
            Response.Write(GetProjectsData());
            Response.End();
        }
    }
}