<?php
session_start();
include 'db.php';

if(isset($_POST['login'])){
    $email = $_POST['email'];
    $pass = $_POST['password'];

    $res = mysqli_query($conn, "SELECT * FROM users WHERE email='$email' AND password='$pass'");
    $user = mysqli_fetch_assoc($res);

    if($user){
        $_SESSION['user_id'] = $user['user_id'];
        header("Location: dashboard.php");
    } else {
        $error = "Invalid Email or Password!";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
<title>Login</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    height: 100vh;
    background: url('https://images.unsplash.com/photo-1504674900247-0877df9cc836') no-repeat center center/cover;
    display: flex;
    align-items: center;
    justify-content: center;
}

.login-box {
    background: rgba(255,255,255,0.9);
    padding: 40px;
    border-radius: 15px;
    width: 350px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
}

.login-box h2 {
    text-align: center;
    margin-bottom: 20px;
}

.btn-custom {
    width: 100%;
    background: #28a745;
    color: white;
}
</style>

</head>

<body>

<div class="login-box">

<h2>🍲 Recipe Login</h2>

<?php if(isset($error)){ ?>
<div class="alert alert-danger"><?php echo $error; ?></div>
<?php } ?>

<form method="POST">

<div class="mb-3">
<input type="email" name="email" class="form-control" placeholder="Enter Email" required>
</div>

<div class="mb-3">
<input type="password" name="password" class="form-control" placeholder="Enter Password" required>
</div>

<button name="login" class="btn btn-custom">Login</button>

</form>

</div>

</body>
</html>