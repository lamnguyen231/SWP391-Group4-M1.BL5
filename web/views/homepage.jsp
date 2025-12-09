<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.wmsmobile.model.User" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Home Page</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap">
            <!-- Bootstrap 5 for a more modern design -->

            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
            <!-- Custom Styles -->
            <link rel="stylesheet" href="css/homePage.css" />
        </head>

        <body>
            <div class="navbar">
                <div class="container-fluid">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="homepage.jsp">Home</a></li>
                        <li><a href="#"></a></li>
                        <li><a href="#">Products</a></li>
                        <li><a href="#">Report</a></li>
                        <li><a href="#">CreateRecord</a></li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownSettings" role="button"
                                data-bs-toggle="dropdown" aria-expanded="false">
                                Settings
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdownSettings">
                                <li><a class="dropdown-item" href="#">Profile</a></li>
                                <li><a class="dropdown-item" href="#">ChangePassword</a></li>
                                <li><a class="dropdown-item" href="#">Customize</a></li>
                            </ul>
                        </li>
                        <li class="login"><a href="${pageContext.request.contextPath}/login">Login</a></li>
                        <li class="logout"><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                    </ul>
                </div>
            </div>
            <div class="container">
                <h1>Welcome to the MobilePhone WareHouse G4</h1>
                <a href="${pageContext.request.contextPath}/login">Login</a>

            </div>
        </body>

        </html>