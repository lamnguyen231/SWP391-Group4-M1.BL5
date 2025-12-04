<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>View My Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<c:url value='/css/styles.css'/>">
</head>
<body>
<main class="container">
    <h1>Thông tin cá nhân</h1>
    <div class="profile-box">
        <p><strong>Họ và tên:</strong> ${user.fullName}</p>
        <p><strong>Email:</strong> ${user.email}</p>
        <p><strong>Số điện thoại:</strong> ${user.phone}</p>
        <p><strong>Địa chỉ:</strong> ${user.address}</p>
    </div>

    <p><a href="<c:url value='/edit-profile'/>">Chỉnh sửa hồ sơ</a></p>
    <p><a href="<c:url value='/'/>">Trang chủ</a></p>
</main>
</body>
</html>