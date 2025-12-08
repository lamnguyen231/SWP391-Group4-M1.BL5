<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
    .modal-form table { margin: 0 auto; border-collapse: collapse; width: 100%; }
    .modal-form td { padding: 8px 5px; }
    .modal-form h1 { text-align: center; margin-bottom: 20px; font-size: 24px; color: #333; }
    .modal-form input, .modal-form select { width: 100%; padding: 8px; box-sizing: border-box; }
    .modal-btn-box { text-align: center; margin-top: 20px; }
    .modal-btn-box button { padding: 8px 20px; margin: 0 5px; cursor: pointer; }
</style>

<div class="modal-form">
    <h1>Add New User</h1>

    <form name="addForm" action="${pageContext.request.contextPath}/admin/addUser" method="POST" onsubmit="return validateForm()">
        
        <table>
            <tr>
                <td><label>Full Name:</label></td>
                <td><input type="text" name="fullName"></td>
            </tr>
            <tr>
                <td><label>Username:</label></td>
                <td><input type="text" name="username"></td>
            </tr>
            <tr>
                <td><label>Password:</label></td>
                <td><input type="password" name="password"></td>
            </tr>
            <tr>
                <td><label>Confirm Password:</label></td>
                <td><input type="password" name="passwordConfirm"></td>
            </tr>
            <tr>
                <td><label>Email:</label></td>
                <td><input type="email" name="email"></td>
            </tr>
            <tr>
                <td><label>Phone Number:</label></td>
                <td><input type="text" name="phone"></td>
            </tr>
            <tr>
                <td><label>Role:</label></td>
                <td>
                    <select name="role">
                        <option value="">Select a role</option>
                        <option value="Keeper">Keeper</option>
                        <option value="Employee">Employee</option>
                    </select>
                </td>
            </tr>
        </table>

        <div class="modal-btn-box">
            <button type="submit" style="background: #28a745; color: white; border: none;">Add User</button>
            <button type="button" onclick="closeModal()" style="background: #dc3545; color: white; border: none;">Cancel</button>
        </div>
    </form>
</div>

<script>
    function validateForm() {
        var name = document.addForm.fullName.value;
        var user = document.addForm.username.value;
        var pass = document.addForm.password.value;
        var pass2 = document.addForm.passwordConfirm.value;
        var email = document.addForm.email.value;
        var role = document.addForm.role.value;

        if (name === "") { alert("Please enter full name."); return false; }
        if (user === "") { alert("Please enter username."); return false; }
        if (pass === "") { alert("Please enter password."); return false; }
        if (pass !== pass2) { alert("Passwords do not match."); return false; }
        if (email === "") { alert("Please enter email."); return false; }
        if (role === "") { alert("Please select a role."); return false; }

        return true; // Allows the form to submit to the Servlet
    }
</script>