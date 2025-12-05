<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update User</title>

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

<h1>Update User</h1>

<form name="updateForm">

<table>

    <tr>
        <td><label>User ID:</label></td>
        <td><input type="text" name="userId" value="" disabled></td>
    </tr>

    <tr>
        <td><label>Full Name:</label></td>
        <td><input type="text" name="fullName" value=""></td>
    </tr>

    <tr>
        <td><label>Username:</label></td>
        <td><input type="text" name="username" value="" disabled></td>
    </tr>

    <tr>
        <td><label>New Password:</label></td>
        <td><input type="password" name="password"></td>
    </tr>

    <tr>
        <td><label>Confirm New Password:</label></td>
        <td><input type="password" name="passwordConfirm"></td>
    </tr>

    <tr>
        <td><label>Email:</label></td>
        <td><input type="email" name="email" value=""></td>
    </tr>

    <tr>
        <td><label>Phone Number:</label></td>
        <td><input type="text" name="phone" value=""></td>
    </tr>

    <tr>
        <td><label>Role:</label></td>
        <td>
            <select name="role">
                <option value="keeper">Keeper</option>
                <option value="employee">Employee</option>
            </select>
        </td>
    </tr>

</table>

<div class="btn-box">
    <button type="button" onclick="submitUpdate()">Update</button>
    <button type="button" onclick="history.back()">Close</button>
</div>

</form>

<script>
function submitUpdate() {
    var pwd = document.updateForm.password.value;
    var pwd2 = document.updateForm.passwordConfirm.value;

    if (pwd !== "" && pwd !== pwd2) {
        alert("The new passwords do not match!");
        return;
    }

    if (pwd !== "" && pwd.length < 6) {
        alert("The new password must be at least 6 characters.");
        return;
    }

    alert("User updated successfully!");
}
</script>

</body>
</html>
