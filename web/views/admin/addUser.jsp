<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Add User</title>
</head>
<body>

<h1>Add User</h1>

<form name="fThem">

    <label>Ho va ten</label>
    <input type="text" name="hoten">

    <label>Ten dang nhap</label>
    <input type="text" name="user">

    <label>Mat khau</label>
    <input type="password" name="pass">

    <label>Nhap lai mat khau</label>
    <input type="password" name="pass2">

    <label>Email</label>
    <input type="email" name="email">

    <label>So dien thoai</label>
    <input type="text" name="phone">

    <label>Vai tro</label>
    <select name="role">
        <option value="">Chon vai tro</option>
        <option>Thu kho</option>
        <option>Nhan vien</option>
    </select>

    <br><br>

    <button type="button" onclick="themNguoiDung()">Them Nguoi Dung</button>
    <button type="reset">Lam Lai Form</button>

</form>

<script>
function themNguoiDung() {
    var ht = document.fThem.hoten.value;
    var tk = document.fThem.user.value;
    var mk = document.fThem.pass.value;
    var mk2 = document.fThem.pass2.value;
    var mail = document.fThem.email.value;
    var dt = document.fThem.phone.value;
    var vt = document.fThem.role.value;

    if(ht == "") { alert("Ban chua nhap ho ten"); return; }
    if(tk == "") { alert("Ban chua nhap ten dang nhap"); return; }
    if(mk == "") { alert("Ban chua nhap mat khau"); return; }
    if(mk != mk2) { alert("Mat khau nhap lai khong khop"); return; }
    if(mail == "") { alert("Ban chua nhap email"); return; }
    if(vt == "") { alert("Ban chua chon vai tro"); return; }

    alert("Them nguoi dung thanh cong!");
}
</script>

</body>
</html>
