<?php
session_start();
include 'db.php';

$user = $_SESSION['user_id'];
$id = $_GET['id'];

mysqli_query($conn, "INSERT INTO favorites (user_id, recipe_id) VALUES ($user, $id)");

header("Location: dashboard.php");
?>