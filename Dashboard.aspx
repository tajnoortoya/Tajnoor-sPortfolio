<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TajnoorPortfolio.Dashboard" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #ff004f;
            --dark: #0a0a0a;
            --light-dark: #1a1a1a;
            --text: #fff;
            --text-secondary: #ababab;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: var(--dark);
            color: var(--text);
            overflow-x: hidden;
        }

        .admin-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background: var(--light-dark);
            padding: 20px 0;
            position: fixed;
            height: 100%;
            overflow-y: auto;
            transition: all 0.3s;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

            .sidebar-header h2 {
                color: var(--primary);
                font-size: 24px;
            }

        .sidebar-menu {
            list-style: none;
            padding: 20px 0;
        }

            .sidebar-menu li {
                margin-bottom: 5px;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                padding: 12px 20px;
                color: var(--text-secondary);
                text-decoration: none;
                transition: all 0.3s;
            }

                .sidebar-menu a:hover,
                .sidebar-menu a.active {
                    background: rgba(255, 0, 79, 0.1);
                    color: var(--primary);
                    border-left: 4px solid var(--primary);
                }

                .sidebar-menu a i {
                    margin-right: 10px;
                    font-size: 18px;
                }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 250px;
            padding: 20px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background: var(--light-dark);
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .welcome h1 {
            font-size: 24px;
        }

            .welcome h1 span {
                color: var(--primary);
            }

        .welcome p {
            color: var(--text-secondary);
        }

        .logout-btn {
            background: var(--primary);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
        }

            .logout-btn:hover {
                background: #ff3366;
            }

        /* Dashboard Cards */
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--light-dark);
            padding: 20px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            background: rgba(255, 0, 79, 0.1);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }

            .stat-icon i {
                font-size: 24px;
                color: var(--primary);
            }

        .stat-info h3 {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .stat-info p {
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Content Sections */
        .content-section {
            background: var(--light-dark);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

            .section-header h2 {
                font-size: 20px;
            }

        .add-btn {
            background: var(--primary);
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

            .add-btn:hover {
                background: #ff3366;
            }

        /* Tables */
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

            .data-table th,
            .data-table td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid rgba(255,255,255,0.1);
            }

            .data-table th {
                background: rgba(255, 0, 79, 0.1);
                color: var(--primary);
                font-weight: 500;
            }

            .data-table tr:hover {
                background: rgba(255,255,255,0.03);
            }

        .action-btn {
            background: none;
            border: none;
            color: var(--text-secondary);
            cursor: pointer;
            margin-right: 10px;
            font-size: 16px;
            transition: all 0.3s;
        }

            .action-btn.edit:hover {
                color: #4CAF50;
            }

            .action-btn.delete:hover {
                color: var(--primary);
            }

            .action-btn.view:hover {
                color: #2196F3;
            }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            z-index: 2000;
            overflow-y: auto;
        }

        .modal-content {
            background: var(--light-dark);
            margin: 50px auto;
            padding: 30px;
            border-radius: 10px;
            width: 90%;
            max-width: 600px;
            position: relative;
        }

        .close-modal {
            position: absolute;
            top: 15px;
            right: 15px;
            background: none;
            border: none;
            color: var(--text-secondary);
            font-size: 24px;
            cursor: pointer;
        }

        .modal-header {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: var(--text-secondary);
            }

            .form-group input,
            .form-group textarea,
            .form-group select {
                width: 100%;
                padding: 12px 15px;
                background: rgba(255, 255, 255, 0.08);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 5px;
                color: var(--text);
                font-size: 16px;
            }

                .form-group input:focus,
                .form-group textarea:focus,
                .form-group select:focus {
                    outline: none;
                    border-color: var(--primary);
                }

            .form-group textarea {
                min-height: 120px;
                resize: vertical;
            }

        .submit-btn {
            background: var(--primary);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s;
        }

            .submit-btn:hover {
                background: #ff3366;
            }

        .unread {
            font-weight: bold;
            color: var(--primary);
        }

        /* Error message styling */
        .error-message {
            color: var(--primary);
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }

        /* Success notification */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 5px;
            color: white;
            background: #2ecc71;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            display: none;
            z-index: 1000;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
            }

                .sidebar .menu-text {
                    display: none;
                }

            .main-content {
                margin-left: 70px;
            }

            .stats-cards {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    
        <div class="admin-container">
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="sidebar-header">
                    <h2>Admin Panel</h2>
                </div>
                <ul class="sidebar-menu">
                    <li><a href="Dashboard.aspx" class="active"><i class="fas fa-tachometer-alt"></i> <span class="menu-text">Dashboard</span></a></li>
                    <li><a href="#messages" onclick="showSection('messages')"><i class="fas fa-envelope"></i> <span class="menu-text">Messages</span></a></li>
                    <li><a href="#projects" onclick="showSection('projects')"><i class="fas fa-project-diagram"></i> <span class="menu-text">Projects</span></a></li>
                    <li><a href="#settings" onclick="showSection('settings')"><i class="fas fa-cog"></i> <span class="menu-text">Settings</span></a></li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <div class="header">
                    <div class="welcome">
                        <h1>Welcome, <span><%= Session["Admin"] %></span></h1>
                        <p>Manage your portfolio content and messages</p>
                    </div>
                    <asp:Button ID="btnLogout" runat="server" 
                                Text="Logout" 
                                CssClass="logout-btn" 
                                OnClick="btnLogout_Click" />
                </div>

                <!-- Dashboard Stats -->
                <div id="dashboard-section">
                    <div class="stats-cards">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-envelope"></i>
                            </div>
                            <div class="stat-info">
                                <h3 id="totalMessages" runat="server">0</h3>
                                <p>Total Messages</p>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-project-diagram"></i>
                            </div>
                            <div class="stat-info">
                                <h3 id="totalProjects" runat="server">0</h3>
                                <p>Total Projects</p>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-eye"></i>
                            </div>
                            <div class="stat-info">
                                <h3 id="unreadMessages" runat="server">0</h3>
                                <p>Unread Messages</p>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Messages -->
                    <div class="content-section">
                        <div class="section-header">
                            <h2>Recent Messages</h2>
                        </div>
                        <div class="table-responsive">
                            <asp:GridView ID="gvRecentMessages" runat="server" AutoGenerateColumns="False" CssClass="data-table">
                                <Columns>
                                    <asp:BoundField DataField="Name" HeaderText="Name" />
                                    <asp:BoundField DataField="Email" HeaderText="Email" />
                                    <asp:BoundField DataField="Subject" HeaderText="Subject" />
                                    <asp:BoundField DataField="CreatedAt" HeaderText="Date" DataFormatString="{0:MMM dd, yyyy}" />
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <button class="action-btn view" onclick="viewMessage(<%# Eval("Id") %>)"><i class="fas fa-eye"></i></button>
                                            <button class="action-btn delete" onclick="deleteMessage(<%# Eval("Id") %>)"><i class="fas fa-trash"></i></button>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>

                <!-- Messages Section -->
                <div id="messages-section" style="display: none;">  
                    <div class="content-section">
                        <div class="section-header">
                            <h2>All Messages</h2>
                        </div>
                        <div class="table-responsive">
                            <asp:GridView ID="gvAllMessages" runat="server" AutoGenerateColumns="False" CssClass="data-table">
                                <Columns>
                                    <asp:TemplateField HeaderText="Read">
                                        <ItemTemplate>
                                            <%# (bool)Eval("IsRead") ? "<i class='fas fa-check-circle' style='color: #4CAF50;'></i>" : "<i class='fas fa-circle unread'></i>" %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Name" HeaderText="Name" />
                                    <asp:BoundField DataField="Email" HeaderText="Email" />
                                    <asp:BoundField DataField="Subject" HeaderText="Subject" />
                                    <asp:BoundField DataField="CreatedAt" HeaderText="Date" DataFormatString="{0:MMM dd, yyyy}" />
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <button class="action-btn view" onclick="viewMessage(<%# Eval("Id") %>)"><i class="fas fa-eye"></i></button>
                                            <button class="action-btn delete" onclick="deleteMessage(<%# Eval("Id") %>)"><i class="fas fa-trash"></i></button>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>

                <!-- Projects Section -->
                <div id="projects-section" style="display: none;">
                    <div class="content-section">
                        <div class="section-header">
                            <h2>Projects</h2>
                            <button class="add-btn" onclick="showAddProjectModal()"><i class="fas fa-plus"></i> Add Project</button>
                        </div>
                        <div class="table-responsive">
                            <asp:GridView ID="gvProjects" runat="server" AutoGenerateColumns="False" CssClass="data-table">
                                <Columns>
                                    <asp:BoundField DataField="Title" HeaderText="Title" />
                                    <asp:BoundField DataField="Description" HeaderText="Description" HtmlEncode="false" />
                                    <asp:BoundField DataField="CreatedAt" HeaderText="Date" DataFormatString="{0:MMM dd, yyyy}" />
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <button class="action-btn edit" onclick="editProject(<%# Eval("Id") %>)"><i class="fas fa-edit"></i></button>
                                            <button class="action-btn delete" onclick="deleteProject(<%# Eval("Id") %>)"><i class="fas fa-trash"></i></button>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- View Message Modal -->
        <div id="viewMessageModal" class="modal">
            <div class="modal-content">
                <button class="close-modal" onclick="closeModal('viewMessageModal')">&times;</button>
                <div class="modal-header">
                    <h2>Message Details</h2>
                </div>
                <div class="form-group">
                    <label>From:</label>
                    <p id="messageFrom"></p>
                </div>
                <div class="form-group">
                    <label>Email:</label>
                    <p id="messageEmail"></p>
                </div>
                <div class="form-group">
                    <label>Subject:</label>
                    <p id="messageSubject"></p>
                </div>
                <div class="form-group">
                    <label>Message:</label>
                    <p id="messageContent"></p>
                </div>
                <div class="form-group">
                    <label>Reply:</label>
                    <textarea id="adminReply" rows="5" placeholder="Type your reply here..."></textarea>
                </div>
                <button type="button" class="submit-btn" onclick="sendReply()">Send Reply</button>
            </div>
        </div>

        <!-- Add/Edit Project Modal -->
        <div id="projectModal" class="modal">
            <div class="modal-content">
                <button class="close-modal" onclick="closeModal('projectModal')">&times;</button>
                <div class="modal-header">
                    <h2 id="modalProjectTitle">Add Project</h2>
                </div>
                <input type="hidden" id="projectId" value="0">
                <div class="form-group">
                    <label for="projectTitle">Title *</label>
                    <input type="text" id="projectTitle" runat="server" required>
                    <div class="error-message" id="titleError">Please enter a project title</div>
                </div>
                <div class="form-group">
                    <label for="projectDescription">Description *</label>
                    <textarea id="projectDescription" runat="server" required></textarea>
                    <div class="error-message" id="descriptionError">Please fill out this field.</div>
                </div>
                <div class="form-group">
                    <label for="projectImageUrl">Image URL</label>
                    <input type="text" id="projectImageUrl" runat="server">
                    <div class="error-message" id="imageUrlError">Please enter a valid URL</div>
                </div>
                <div class="form-group">
                    <label for="projectGithubUrl">GitHub URL</label>
                    <input type="text" id="projectGithubUrl" runat="server">
                </div>
                <div class="form-group">
                    <label for="projectDetailsUrl">Details URL</label>
                    <input type="text" id="projectDetailsUrl" runat="server">
                </div>
                <asp:Button ID="btnSaveProject" runat="server" Text="Save Project" CssClass="submit-btn" OnClick="btnSaveProject_Click" />
            </div>
        </div>

        <!-- Success Notification -->
        <div class="notification" id="notification" runat="server">
            Project saved successfully!
        </div>

        <asp:HiddenField ID="hdnCurrentProjectId" runat="server" Value="0" />
    </form>

    <script>
        // Show/hide sections
        function showSection(section) {
            document.getElementById('dashboard-section').style.display = 'none';
            document.getElementById('messages-section').style.display = 'none';
            document.getElementById('projects-section').style.display = 'none';

            document.getElementById(section + '-section').style.display = 'block';

            // Update menu active state
            const menuItems = document.querySelectorAll('.sidebar-menu a');
            menuItems.forEach(item => item.classList.remove('active'));
            event.currentTarget.classList.add('active');
        }

        // Modal functions
        function viewMessage(id) {
            // Use PageMethods to fetch message details
            PageMethods.GetMessageDetails(id, onSuccessGetMessage, onError);

            function onSuccessGetMessage(result) {
                const data = JSON.parse(result);
                document.getElementById('messageFrom').textContent = data.Name;
                document.getElementById('messageEmail').textContent = data.Email;
                document.getElementById('messageSubject').textContent = data.Subject;
                document.getElementById('messageContent').textContent = data.MessageText;
                document.getElementById('adminReply').value = data.AdminReply || '';

                // Store the message ID for the reply
                document.getElementById('viewMessageModal').dataset.messageId = id;

                // Show modal
                document.getElementById('viewMessageModal').style.display = 'block';
            }

            function onError(error) {
                console.error('Error fetching message:', error);
                alert('Error loading message details.');
            }
        }

        function showAddProjectModal() {
            document.getElementById('modalProjectTitle').textContent = 'Add Project';
            document.getElementById('<%= hdnCurrentProjectId.ClientID %>').value = '0';
            document.getElementById('<%= projectTitle.ClientID %>').value = '';
            document.getElementById('<%= projectDescription.ClientID %>').value = '';
            document.getElementById('<%= projectImageUrl.ClientID %>').value = '';
            document.getElementById('<%= projectGithubUrl.ClientID %>').value = '';
            document.getElementById('<%= projectDetailsUrl.ClientID %>').value = '';
            
            // Reset error messages
            document.querySelectorAll('.error-message').forEach(el => {
                el.style.display = 'none';
            });
            
            document.getElementById('projectModal').style.display = 'block';
        }

        function editProject(id) {
            // Use PageMethods to fetch project details
            PageMethods.GetProjectDetails(id, onSuccessGetProject, onError);
            
            function onSuccessGetProject(result) {
                const data = JSON.parse(result);
                document.getElementById('modalProjectTitle').textContent = 'Edit Project';
                document.getElementById('<%= hdnCurrentProjectId.ClientID %>').value = data.Id;
                document.getElementById('<%= projectTitle.ClientID %>').value = data.Title;
                document.getElementById('<%= projectDescription.ClientID %>').value = data.Description;
                document.getElementById('<%= projectImageUrl.ClientID %>').value = data.ImageUrl || '';
                document.getElementById('<%= projectGithubUrl.ClientID %>').value = data.GithubUrl || '';
                document.getElementById('<%= projectDetailsUrl.ClientID %>').value = data.DetailsUrl || '';
                
                // Reset error messages
                document.querySelectorAll('.error-message').forEach(el => {
                    el.style.display = 'none';
                });
                
                document.getElementById('projectModal').style.display = 'block';
            }
            
            function onError(error) {
                console.error('Error fetching project:', error);
                alert('Error loading project details.');
            }
        }

        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }

        function sendReply() {
            const messageId = document.getElementById('viewMessageModal').dataset.messageId;
            const reply = document.getElementById('adminReply').value;
            
            // Send reply via PageMethods
            PageMethods.SendReply(messageId, reply, onSuccessSendReply, onError);
            
            function onSuccessSendReply(result) {
                if (result) {
                    alert('Reply sent successfully!');
                    closeModal('viewMessageModal');
                    // Refresh messages
                    location.reload();
                } else {
                    alert('Error sending reply.');
                }
            }
        }

        function deleteMessage(id) {
            if (confirm('Are you sure you want to delete this message?')) {
                PageMethods.DeleteMessage(id, onSuccessDeleteMessage, onError);
                
                function onSuccessDeleteMessage(result) {
                    if (result) {
                        alert('Message deleted successfully!');
                        location.reload();
                    } else {
                        alert('Error deleting message.');
                    }
                }
            }
        }

        function deleteProject(id) {
            if (confirm('Are you sure you want to delete this project?')) {
                PageMethods.DeleteProject(id, onSuccessDeleteProject, onError);
                
                function onSuccessDeleteProject(result) {
                    if (result) {
                        alert('Project deleted successfully!');
                        location.reload();
                    } else {
                        alert('Error deleting project.');
                    }
                }
            }
        }

        function onError(error) {
            console.error('Error:', error);
            alert('An error occurred. Please try again.');
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modals = document.getElementsByClassName('modal');
            for (let i = 0; i < modals.length; i++) {
                if (event.target == modals[i]) {
                    modals[i].style.display = 'none';
                }
            }
        }

        // Validate project form before submission
        function validateProjectForm() {
            // Reset error messages
            document.querySelectorAll('.error-message').forEach(el => {
                el.style.display = 'none';
            });
            
            // Get form values
            const title = document.getElementById('<%= projectTitle.ClientID %>').value.trim();
            const description = document.getElementById('<%= projectDescription.ClientID %>').value.trim();
            const imageUrl = document.getElementById('<%= projectImageUrl.ClientID %>').value.trim();
            
            // Validate required fields
            let isValid = true;
            
            if (!title) {
                document.getElementById('titleError').style.display = 'block';
                isValid = false;
            }
            
            if (!description) {
                document.getElementById('descriptionError').style.display = 'block';
                isValid = false;
            }
            
            if (imageUrl && !isValidUrl(imageUrl)) {
                document.getElementById('imageUrlError').style.display = 'block';
                isValid = false;
            }
            
            return isValid;
        }

        function isValidUrl(string) {
            try {
                new URL(string);
                return true;
            } catch (_) {
                return false;
            }
        }

        // Show notification function
        function showNotification(message) {
            const notification = document.getElementById('<%= notification.ClientID %>');
            notification.textContent = message;
            notification.style.display = 'block';

            setTimeout(() => {
                notification.style.display = 'none';
            }, 3000);
        }
    </script>
</body>
</html>