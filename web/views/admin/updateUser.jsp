<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Update User</title>
</head>
<body>

<h1>Update User</h1>

<form name="fCapNhat">

    <label>ID người dùng:</label>
    <input type="text" value="10056" disabled>

    <label>Họ và tên:</label>
    <input type="text" name="hoten" value="Trần Thị Lan">

    <label>Tên đăng nhập:</label>
    <input type="text" value="tranlan" disabled>

    <label>Mật khẩu mới (để trống nếu không đổi):</label>
    <input type="password" name="pass">

    <label>Nhập lại mật khẩu mới:</label>
    <input type="password" name="pass2">

    <label>Email:</label>
    <input type="email" name="email" value="lan.tran@company.com">

    <label>Số điện thoại:</label>
    <input type="text" name="phone" value="0987654321">

    <label>Vai trò:</label>
    <select name="role">
        <option>Thủ kho</option>
        <option selected>Nhân viên</option>
    </select>

    <label>Trạng thái tài khoản:</label>
    <select name="status">
        <option selected>Hoạt động</option>
        <option>Tạm khóa</option>
    </select>

    <br><br>
    <button type="button" onclick="luuCapNhat()">Cập Nhật</button>
    <button type="button" onclick="alert('Đóng form')">Đóng</button>

</form>

<script>
function luuCapNhat() {
    var mk = document.fCapNhat.pass.value;
    var mk2 = document.fCapNhat.pass2.value;

    if (mk !== "" && mk !== mk2) {
        alert("Hai mật khẩu mới không giống nhau!");
        return;
    }
    if (mk !== "" && mk.length < 6) {
        alert("Mật khẩu mới phải ít nhất 6 ký tự!");
        return;
    }

    alert("CẬP NHẬT THÀNH CÔNG!");
}
</script>

</body>
</html>
