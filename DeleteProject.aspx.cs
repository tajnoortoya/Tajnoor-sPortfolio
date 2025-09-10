using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

namespace TajnoorPortfolio
{
    public partial class DeleteProject : System.Web.UI.Page
    {
        [WebMethod]
        public static object DeleteProjectData(int id)
        {
            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PortfolioDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "DELETE FROM Projects WHERE Id=@Id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
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