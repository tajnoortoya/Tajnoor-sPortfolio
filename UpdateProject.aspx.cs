using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

namespace TajnoorPortfolio
{
    public partial class UpdateProject : System.Web.UI.Page
    {
        [WebMethod]
        public static object UpdateProjectData(int id, string title, string description, string imageUrl, string githubUrl, string detailsUrl)
        {
            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PortfolioDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "UPDATE Projects SET Title=@Title, Description=@Description, ImageUrl=@ImageUrl, GithubUrl=@GithubUrl, DetailsUrl=@DetailsUrl, UpdatedAt=GETDATE() WHERE Id=@Id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@ImageUrl", imageUrl ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@GithubUrl", githubUrl ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@DetailsUrl", detailsUrl ?? (object)DBNull.Value);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        return new { success = rowsAffected > 0 };
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