<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add User</title>

    <style>
        body { font-family: Arial; }
        table { margin: 0 auto; border-collapse: collapse; }
        td { padding: 8px 10px; }
        h1 { text-align: center; margin-bottom: 20px; }
        input, select { width: 260px; padding: 6px; }
        .btn-box { text-align: center; margin-top: 20px; }
        button { padding: 7px 15px; margin: 0 5px; cursor: pointer; }
    </style>
</head>

<body>

<h1>Add User</h1>

<form name="addForm">

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
                <!-- backend sẽ fill hoặc giữ như này đều ok -->
                <option value="keeper">Keeper</option>
                <option value="employee">Employee</option>
            </select>
        </td>
    </tr>

</table>

<div class="btn-box">
    <button type="button" onclick="submitAdd()">Add User</button>
    <button type="reset">Reset Form</button>
</div>

</form>

<script>
function submitAdd() {
    var name = document.addForm.fullName.value;
    var user = document.addForm.username.value;
    var pass = document.addForm.password.value;
    var pass2 = document.addForm.passwordConfirm.value;
    var email = document.addForm.email.value;
    var role = document.addForm.role.value;

    if (name === "") { alert("Please enter full name."); return; }
    if (user === "") { alert("Please enter username."); return; }
    if (pass === "") { alert("Please enter password."); return; }
    if (pass !== pass2) { alert("Passwords do not match."); return; }
    if (email === "") { alert("Please enter email."); return; }
    if (role === "") { alert("Please select a role."); return; }

    alert("User added successfully!");
}
</script>

</body>
</html>
