<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quên mật khẩu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<c:url value='/css/styles.css'/>">
</head>
<body>
<main class="container">
    <h1>Quên mật khẩu</h1>
    <form action="<c:url value='/forgot-password'/>" method="post">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <button type="submit">Gửi liên kết</button>
    </form>

    <%--    <c:if test="${not empty message}">--%>
    <%--        <div class="message">${message}</div>--%>
    <%--    </c:if>--%>

    <p><a href="<c:url value='/'/>">Trang chủ</a></p>
</main>
</body>
</html>
