<?php
include 'db.php';

if(isset($_POST['add'])){
    $title = $_POST['title'];
    $cat = $_POST['category'];

    $img = $_FILES['image']['name'];
    move_uploaded_file($_FILES['image']['tmp_name'], "uploads/".$img);

    mysqli_query($conn, "INSERT INTO recipes (recipe_title, category_id, image_url) 
    VALUES ('$title','$cat','$img')");

    header("Location: dashboard.php");
}
?>

<form method="POST" enctype="multipart/form-data">
<input type="text" name="title" placeholder="Recipe Name"><br>
<input type="number" name="category" placeholder="Category ID"><br>
<input type="file" name="image"><br>
<button name="add">Add</button>
</form>