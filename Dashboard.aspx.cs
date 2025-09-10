using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Serialization;

namespace TajnoorPortfolio
{
    public partial class Dashboard : System.Web.UI.Page
    {

        private static readonly string connectionString =
            System.Configuration.ConfigurationManager.ConnectionStrings["PortfolioDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                // Not logged in, redirect to login page
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                BindRecentMessages();
                BindAllMessages();
                BindProjects();
                BindStats();
            }
        }
        private void BindStats()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // 🔹 Total Messages
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Messages", conn);
                totalMessages.InnerText = cmd.ExecuteScalar().ToString();

                // 🔹 Total Projects
                cmd = new SqlCommand("SELECT COUNT(*) FROM Projects", conn);
                totalProjects.InnerText = cmd.ExecuteScalar().ToString();

                // 🔹 Unread Messages
                cmd = new SqlCommand("SELECT COUNT(*) FROM Messages WHERE IsRead = 0", conn);
                unreadMessages.InnerText = cmd.ExecuteScalar().ToString();
            }
        }


        // =========================
        //  BIND DATA TO GRIDVIEWS
        // =========================
        private void BindRecentMessages()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT TOP 5 * FROM Messages ORDER BY CreatedAt DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvRecentMessages.DataSource = dt;
                gvRecentMessages.DataBind();
            }
        }

        private void BindAllMessages()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Messages ORDER BY CreatedAt DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvAllMessages.DataSource = dt;
                gvAllMessages.DataBind();
            }
        }

        private void BindProjects()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Projects ORDER BY CreatedAt DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvProjects.DataSource = dt;
                gvProjects.DataBind();
            }
        }

        // =========================
        //  PAGEMETHODS (called by JS)
        // =========================
        [WebMethod]
        public static string GetMessageDetails(int id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT Id, Name, Email, Subject, MessageText, AdminReply FROM Messages WHERE Id=@Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    var data = new
                    {
                        Id = reader["Id"],
                        Name = reader["Name"].ToString(),
                        Email = reader["Email"].ToString(),
                        Subject = reader["Subject"].ToString(),
                        MessageText = reader["MessageText"].ToString(),
                        AdminReply = reader["AdminReply"].ToString()
                    };
                    return new JavaScriptSerializer().Serialize(data);
                }
            }
            return "{}";
        }

        [WebMethod]
        public static bool SendReply(int id, string reply)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "UPDATE Messages SET AdminReply=@Reply, IsRead=1 WHERE Id=@Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Reply", reply);
                cmd.Parameters.AddWithValue("@Id", id);
                return cmd.ExecuteNonQuery() > 0;
            }
        }

        [WebMethod]
        public static bool DeleteMessage(int id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "DELETE FROM Messages WHERE Id=@Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);
                return cmd.ExecuteNonQuery() > 0;
            }
        }

        [WebMethod]
        public static string GetProjectDetails(int id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT Id, Title, Description, ImageUrl, GithubUrl, DetailsUrl FROM Projects WHERE Id=@Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    var data = new
                    {
                        Id = reader["Id"],
                        Title = reader["Title"].ToString(),
                        Description = reader["Description"].ToString(),
                        ImageUrl = reader["ImageUrl"].ToString(),
                        GithubUrl = reader["GithubUrl"].ToString(),
                        DetailsUrl = reader["DetailsUrl"].ToString()
                    };
                    return new JavaScriptSerializer().Serialize(data);
                }
            }
            return "{}";
        }

        [WebMethod]
        public static bool DeleteProject(int id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "DELETE FROM Projects WHERE Id=@Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);
                return cmd.ExecuteNonQuery() > 0;
            }
        }

        // =========================
        //  SAVE PROJECT (ADD/EDIT)
        // =========================
        protected void btnSaveProject_Click(object sender, EventArgs e)
        {
            int projectId = string.IsNullOrEmpty(hdnCurrentProjectId.Value) ? 0 : int.Parse(hdnCurrentProjectId.Value);
            string title = projectTitle.Value.Trim();
            string description = projectDescription.Value.Trim();
            string imageUrl = projectImageUrl.Value.Trim();
            string githubUrl = projectGithubUrl.Value.Trim();
            string detailsUrl = projectDetailsUrl.Value.Trim();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query;

                if (projectId == 0)
                {
                    query = @"INSERT INTO Projects (Title, Description, ImageUrl, GithubUrl, DetailsUrl, CreatedAt) 
                              VALUES (@Title, @Description, @ImageUrl, @GithubUrl, @DetailsUrl, GETDATE())";
                }
                else
                {
                    query = @"UPDATE Projects 
                              SET Title=@Title, Description=@Description, ImageUrl=@ImageUrl, GithubUrl=@GithubUrl, DetailsUrl=@DetailsUrl 
                              WHERE Id=@Id";
                }

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@ImageUrl", imageUrl);
                cmd.Parameters.AddWithValue("@GithubUrl", githubUrl);
                cmd.Parameters.AddWithValue("@DetailsUrl", detailsUrl);
                if (projectId != 0)
                    cmd.Parameters.AddWithValue("@Id", projectId);

                cmd.ExecuteNonQuery();
            }

            // Refresh
            BindProjects();
            notification.InnerText = "Project saved successfully!";
            notification.Style["display"] = "block";
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear session
            Session.Clear();
            Session.Abandon();

            // Optional: clear authentication cookie
            if (Request.Cookies[".ASPXAUTH"] != null)
            {
                Response.Cookies[".ASPXAUTH"].Expires = DateTime.Now.AddDays(-1);
            }

            // Redirect back to login or index.html
            Response.Redirect("index.html");
        }

    }
}
