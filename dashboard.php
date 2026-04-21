<?php
session_start();
include 'db.php';

if(!isset($_SESSION['user_id'])){
    header("Location: index.php");
}

$search = isset($_GET['search']) ? $_GET['search'] : '';

$query = "
SELECT r.*, c.category_name 
FROM recipes r
LEFT JOIN categories c ON r.category_id = c.category_id
WHERE r.recipe_title LIKE '%$search%'
";

$result = mysqli_query($conn, $query);
?>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container mt-4">

<h2>Dashboard</h2>
<a href="logout.php">Logout</a>

<form method="GET" class="mb-3">
<input type="text" name="search" placeholder="Search recipe..." class="form-control">
</form>

<div class="container mt-4">

<div class="row">

<?php while($row = mysqli_fetch_assoc($result)){ ?>

<div class="col-md-4">
<div class="card mb-4">

<?php 
$title = strtolower($row['recipe_title']);

if(strpos($title, 'omelette') !== false){
    $imgPath = "https://images.unsplash.com/photo-1551218808-94e220e084d2";
}
elseif(strpos($title, 'chicken') !== false){
    $imgPath = "https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Q2hpY2tlbiUyMEN1cnJ5fGVufDB8fDB8fHww";
}
elseif(strpos($title, 'cake') !== false){
    $imgPath = "https://images.unsplash.com/photo-1563805042-7684c019e1cb";
}
else{
    $imgPath = "https://images.unsplash.com/photo-1490645935967-10de6ba17061";
}
?>

<img src="<?php echo $imgPath; ?>" 
     class="card-img-top" 
     style="height:200px; object-fit:cover;">

<div class="card-body">
<h5 class="card-title"><?php echo $row['recipe_title']; ?></h5>
<p><?php echo $row['category_name']; ?></p>

<a href="edit.php?id=<?php echo $row['recipe_id']; ?>" class="btn btn-warning btn-sm">Edit</a>
<a href="delete.php?id=<?php echo $row['recipe_id']; ?>" class="btn btn-danger btn-sm">Delete</a>
<a href="favorite.php?id=<?php echo $row['recipe_id']; ?>" class="btn btn-primary btn-sm">❤️</a>

</div>
</div>
</div>

<?php } ?>

</div>

<a href="add.php" class="btn btn-success">+ Add Recipe</a>


</div>