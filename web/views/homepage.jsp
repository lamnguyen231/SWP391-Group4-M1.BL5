<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Home Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap">

        <jsp:include page="/views/common/header.jsp" />

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <!-- Custom Styles -->
        <link rel="stylesheet" href="css/homePage.css" />
    </head>

    <body>
        <jsp:include page="/views/common/navbar.jsp" />
        
        <div class="container">
            <h1>Welcome to the MobilePhone WareHouse G4</h1>
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </div>
    </body>

</html>
