<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xem Thông Tin User</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userDetail.css">
</head>
<body>
<div class="container">
    <!-- Header -->
    <div class="header">
        <h1>Thông Tin User</h1>
        <p>Chi tiết tài khoản người dùng</p>
    </div>

    <!-- Content -->
    <div class="content">
        <!-- User Avatar & Basic Info -->
        <div class="user-header">
            <div class="avatar">JD</div>
            <div class="user-info-main">
                <h2>John Doe</h2>
                <p>john.doe@example.com</p>
            </div>
        </div>

        <!-- User Details -->
        <div class="info-section">
            <div class="info-row">
                <div class="label">ID:</div>
                <div class="value">#001</div>
            </div>

            <div class="info-row">
                <div class="label">Tên:</div>
                <div class="value">John Doe</div>
            </div>

            <div class="info-row">
                <div class="label">Email:</div>
                <div class="value">john.doe@example.com</div>
            </div>

            <div class="info-row">
                <div class="label">Role:</div>
                <div class="value">
                    <span class="role-badge">Admin</span>
                </div>
            </div>

            <div class="info-row">
                <div class="label">Trạng Thái:</div>
                <div class="value">
                    <span class="status-badge status-active">Active</span>
                </div>
            </div>

            <div class="info-row">
                <div class="label">Ngày Tạo:</div>
                <div class="value" data-date="2024-01-12">12/01/2024</div>
            </div>

            <div class="info-row">
                <div class="label">Cập Nhật:</div>
                <div class="value" data-date="2024-12-04">04/12/2024</div>
            </div>
        </div>

        <!-- Buttons -->
        <div class="button-group">
            <button class="btn btn-back" onclick="goBack()">← Quay Lại</button>
            <button class="btn btn-edit" onclick="editUser(1)">✏️ Chỉnh Sửa</button>
            <button class="btn btn-delete" onclick="confirmDelete(1)">🗑️ Xóa</button>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/userDetail.js"></script>
</body>
</html>