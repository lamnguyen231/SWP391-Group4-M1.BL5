<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Admin Dashboard</title>
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/adminCommon.css"
            />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/adminLayout.css"
            />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/adminUserList.css"
            />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/adminRoleList.css"
            />
    </head>
    <body>
        <div class="admin-container">
            <aside class="sidebar">
                <div class="sidebar-header">
                    <h2>Admin Panel</h2>
                </div>

                <nav class="sidebar-nav">
                    <a
                        href="dashboard"
                        class="nav-item ${activeMenu == 'dashboard' ? 'active' : ''}"
                        >
                        <span>Dashboard</span>
                    </a>

                    <a
                        href="users"
                        class="nav-item ${activeMenu == 'users' ? 'active' : ''}"
                        >
                        <span>User Management</span>
                    </a>

                    <a
                        href="roles"
                        class="nav-item ${activeMenu == 'roles' ? 'active' : ''}"
                        >
                        <span>Role Management</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/" class="nav-item">
                        <span>Homepage</span>
                    </a>
                </nav>

                <div class="sidebar-footer">
                    <a
                        href="${pageContext.request.contextPath}/logout"
                        class="logout-btn"
                        >
                        <span>Logout</span>
                    </a>
                </div>
            </aside>

            <main class="main-content">
                <% String contentPage = (String) request.getAttribute("contentPage"); %>

                <jsp:include page="<%= contentPage %>" />
            </main>
        </div>
    </body>
</html>
