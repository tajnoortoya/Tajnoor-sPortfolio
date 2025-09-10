<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TajnoorPortfolio.Login" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - Tajnoor's Portfolio</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            box-sizing: border-box;
        }
        
        body {
            background: #0a0a0a;
            color: #fff;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }
        
        /* Background effects */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 10% 20%, rgba(255, 0, 79, 0.1) 0%, transparent 20%),
                        radial-gradient(circle at 90% 80%, rgba(255, 0, 79, 0.1) 0%, transparent 20%);
            z-index: -1;
        }
        
        .login-container {
            width: 100%;
            max-width: 450px;
            padding: 20px;
            animation: fadeIn 0.8s ease-out;
        }
        
        .login-card {
            background: rgba(25, 25, 25, 0.95);
            border-radius: 15px;
            padding: 40px 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .login-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 0, 79, 0.1), rgba(255, 0, 79, 0.3));
            transform: rotate(0deg);
            z-index: 0;
            animation: animateBorder 6s linear infinite;
        }
        
        @keyframes animateBorder {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }
        
        .login-content {
            position: relative;
            z-index: 2;
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .login-header h2 {
            font-size: 32px;
            color: #fff;
            margin-bottom: 10px;
            font-weight: 700;
            background: linear-gradient(45deg, #ff4b2b, #ff416c);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .login-header p {
            color: #ababab;
            font-size: 16px;
        }
        
        .input-group {
            margin-bottom: 25px;
            position: relative;
        }
        
        .input-group label {
            display: block;
            margin-bottom: 8px;
            color: #ababab;
            font-size: 16px;
            font-weight: 500;
        }
        
        .input-group input {
            width: 100%;
            padding: 15px 20px 15px 45px;
            background: rgba(255, 255, 255, 0.08);
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            color: #fff;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .input-group input:focus {
            outline: none;
            border-color: #ff004f;
            background: rgba(255, 255, 255, 0.12);
            box-shadow: 0 0 15px rgba(255, 0, 79, 0.2);
        }
        
        .input-group i {
            position: absolute;
            left: 15px;
            top: 42px;
            color: #ababab;
            font-size: 18px;
            transition: all 0.3s ease;
        }
        
        .input-group input:focus + i {
            color: #ff004f;
        }
        
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            font-size: 14px;
        }
        
        .remember {
            display: flex;
            align-items: center;
        }
        
        .remember input {
            margin-right: 8px;
            accent-color: #ff004f;
            width: 16px;
            height: 16px;
        }
        
        .forgot a {
            color: #ff004f;
            text-decoration: none;
            transition: color 0.3s ease;
            font-weight: 500;
        }
        
        .forgot a:hover {
            color: #ff3366;
            text-decoration: underline;
        }
        
        .login-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(45deg, #ff4b2b, #ff416c);
            color: #fff;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(255, 0, 79, 0.3);
            position: relative;
            overflow: hidden;
        }
        
        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 0, 79, 0.4);
        }
        
        .login-btn:active {
            transform: translateY(0);
        }
        
        .login-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: 0.5s;
        }
        
        .login-btn:hover::before {
            left: 100%;
        }
        
        .error-message {
            background: rgba(255, 0, 79, 0.1);
            border: 1px solid rgba(255, 0, 79, 0.3);
            border-radius: 8px;
            padding: 12px 15px;
            margin-top: 20px;
            color: #ff4b2b;
            text-align: center;
            display: none;
            animation: shake 0.5s ease;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        
        .branding {
            text-align: center;
            margin-top: 30px;
            color: #ababab;
            font-size: 14px;
        }
        
        .branding a {
            color: #ff004f;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        
        .branding a:hover {
            color: #ff3366;
            text-decoration: underline;
        }
        
        /* Responsive design */
        @media (max-width: 500px) {
            .login-card {
                padding: 30px 20px;
            }
            
            .login-header h2 {
                font-size: 28px;
            }
            
            .remember-forgot {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }
            
            .input-group input {
                padding: 12px 15px 12px 40px;
            }
            
            .input-group i {
                top: 38px;
            }
        }
        
        /* Animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Ripple effect */
        .ripple {
            position: absolute;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: scale(0);
            animation: ripple 0.6s linear;
        }
        
        @keyframes ripple {
            to {
                transform: scale(2.5);
                opacity: 0;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="login-card">
                <div class="login-content">
                    <div class="login-header">
                        <h2>Admin Login</h2>
                        <p>Access your portfolio management dashboard</p>
                    </div>

                    <div class="input-group">
                        <label for="txtUsername">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter your username" required></asp:TextBox>
                        <i class="fas fa-user"></i>
                    </div>

                    <div class="input-group">
                        <label for="txtPassword">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password" required></asp:TextBox>
                        <i class="fas fa-lock"></i>
                    </div>

                    <div class="remember-forgot">
                        <div class="remember">
                            <asp:CheckBox ID="chkRemember" runat="server" />
                            <label for="chkRemember">Remember me</label>
                        </div>
                        <div class="forgot">
                            <a href="#">Forgot password?</a>
                        </div>
                    </div>

                    <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="login-btn" OnClick="btnLogin_Click" />
                    
                    <asp:Label ID="lblError" runat="server" Text="" CssClass="error-message" Visible="false"></asp:Label>
                </div>
            </div>
            
            <div class="branding">
                <p>© 2023 Tajnoor's Portfolio | <a href="../index.html">Back to Portfolio</a></p>
            </div>
        </div>
    </form>

    <script>
        // Add ripple effect to buttons
        document.addEventListener('DOMContentLoaded', function() {
            const buttons = document.querySelectorAll('.login-btn');
            
            buttons.forEach(button => {
                button.addEventListener('click', function(e) {
                    const x = e.clientX - e.target.offsetLeft;
                    const y = e.clientY - e.target.offsetTop;
                    
                    const ripple = document.createElement('span');
                    ripple.classList.add('ripple');
                    ripple.style.left = `${x}px`;
                    ripple.style.top = `${y}px`;
                    
                    this.appendChild(ripple);
                    
                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });
            
            // Show error message with animation if exists
            const errorMessage = document.querySelector('.error-message');
            if (errorMessage && errorMessage.textContent.trim() !== '') {
                errorMessage.style.display = 'block';
            }
        });
    </script>
</body>
</html>