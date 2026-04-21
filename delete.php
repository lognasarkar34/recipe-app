<?php
include 'db.php';
$id = $_GET['id'];

mysqli_query($conn, "DELETE FROM recipes WHERE recipe_id=$id");

header("Location: dashboard.php");
?>