<?php
include 'db.php';
$id = $_GET['id'];

$data = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM recipes WHERE recipe_id=$id"));

if(isset($_POST['update'])){
    $title = $_POST['title'];

    mysqli_query($conn, "UPDATE recipes SET recipe_title='$title' WHERE recipe_id=$id");
    header("Location: dashboard.php");
}
?>

<form method="POST">
<input type="text" name="title" value="<?php echo $data['recipe_title']; ?>">
<button name="update">Update</button>
</form>