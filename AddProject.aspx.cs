using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

namespace TajnoorPortfolio
{
    public partial class AddProject : System.Web.UI.Page
    {
        [WebMethod]
        public static object AddProjectData(string title, string description, string imageUrl, string githubUrl, string detailsUrl)
        {
            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PortfolioDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "INSERT INTO Projects (Title, Description, ImageUrl, GithubUrl, DetailsUrl) OUTPUT INSERTED.Id VALUES (@Title, @Description, @ImageUrl, @GithubUrl, @DetailsUrl)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@ImageUrl", imageUrl ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@GithubUrl", githubUrl ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@DetailsUrl", detailsUrl ?? (object)DBNull.Value);

                        int newId = (int)cmd.ExecuteScalar();
                        return new { success = true, id = newId };
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }
    }
}