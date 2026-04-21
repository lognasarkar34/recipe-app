-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 21, 2026 at 07:54 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `recipe_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `description`) VALUES
(1, 'Breakfast', 'Morning meals'),
(2, 'Lunch', 'Afternoon meals'),
(3, 'Dinner', 'Evening meals'),
(4, 'Dessert', 'Sweet dishes');

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `user_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`user_id`, `recipe_id`, `added_at`) VALUES
(2, 1, '2026-04-13 15:32:06'),
(2, 3, '2026-04-13 15:32:06'),
(3, 2, '2026-04-13 15:32:06');

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `ingredient_id` int(11) NOT NULL,
  `ingredient_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`ingredient_id`, `ingredient_name`) VALUES
(4, 'Chicken'),
(9, 'Chocolate'),
(1, 'Egg'),
(7, 'Flour'),
(6, 'Garlic'),
(2, 'Oil'),
(5, 'Onion'),
(3, 'Salt'),
(8, 'Sugar');

--
-- Triggers `ingredients`
--
DELIMITER $$
CREATE TRIGGER `before_ingredient_insert` BEFORE INSERT ON `ingredients` FOR EACH ROW BEGIN
    SET NEW.ingredient_name = UPPER(NEW.ingredient_name);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `recipe_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `recipe_title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `cooking_time` int(11) DEFAULT NULL COMMENT 'Minutes',
  `difficulty` enum('Easy','Medium','Hard') DEFAULT 'Easy',
  `servings` int(11) DEFAULT 1,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`recipe_id`, `user_id`, `category_id`, `recipe_title`, `description`, `cooking_time`, `difficulty`, `servings`, `image_url`, `created_at`) VALUES
(1, 2, 1, 'Egg Omelette', 'সহজ ডিমের অমলেট', 10, 'Easy', 1, NULL, '2025-12-23 15:29:05'),
(2, 3, 2, 'Chicken Curry', 'মজাদার চিকেন কারি', 40, 'Medium', 4, NULL, '2025-12-23 15:29:05'),
(3, 2, 4, 'Chocolate Cake', 'চকলেট কেক রেসিপি', 60, 'Hard', 6, NULL, '2025-12-23 15:29:05');

--
-- Triggers `recipes`
--
DELIMITER $$
CREATE TRIGGER `before_recipe_delete` BEFORE DELETE ON `recipes` FOR EACH ROW BEGIN
    IF EXISTS (
        SELECT 1 FROM reviews WHERE recipe_id = OLD.recipe_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete recipe with existing reviews';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_recipe_insert` BEFORE INSERT ON `recipes` FOR EACH ROW BEGIN
    SET NEW.created_at = CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `recipe_ingredients`
--

CREATE TABLE `recipe_ingredients` (
  `recipe_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `quantity` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipe_ingredients`
--

INSERT INTO `recipe_ingredients` (`recipe_id`, `ingredient_id`, `quantity`) VALUES
(1, 1, '2 pcs'),
(1, 2, '1 spoon'),
(1, 3, 'To taste'),
(2, 3, 'To taste'),
(2, 4, '1 kg'),
(2, 5, '2 pcs'),
(2, 6, '1 spoon'),
(3, 7, '2 cups'),
(3, 8, '1 cup'),
(3, 9, '200 gm');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `recipe_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `recipe_id`, `user_id`, `rating`, `comment`, `created_at`) VALUES
(1, 1, 2, 5, 'খুব সহজ ও সুস্বাদু', '2025-12-23 15:31:50'),
(2, 2, 1, 4, 'দারুণ রেসিপি', '2025-12-23 15:31:50'),
(3, 3, 2, 5, 'খুবই মজা হয়েছে', '2025-12-23 15:31:50');

--
-- Triggers `reviews`
--
DELIMITER $$
CREATE TRIGGER `before_review_insert` BEFORE INSERT ON `reviews` FOR EACH ROW BEGIN
    IF NEW.rating < 1 OR NEW.rating > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rating must be between 1 and 5';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `steps`
--

CREATE TABLE `steps` (
  `step_id` int(11) NOT NULL,
  `recipe_id` int(11) DEFAULT NULL,
  `step_number` int(11) DEFAULT NULL,
  `instruction` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `steps`
--

INSERT INTO `steps` (`step_id`, `recipe_id`, `step_number`, `instruction`) VALUES
(1, 1, 1, 'ডিম ফেটাও'),
(2, 1, 2, 'তেল গরম করো'),
(3, 1, 3, 'ডিম ভেজে নাও'),
(4, 2, 1, 'চিকেন ধুয়ে নাও'),
(5, 2, 2, 'মসলা মিশাও'),
(6, 2, 3, 'ভালোভাবে রান্না করো'),
(7, 3, 1, 'ময়দা ও চিনি মেশাও'),
(8, 3, 2, 'চকলেট যোগ করো'),
(9, 3, 3, 'ওভেনে বেক করো'),
(10, 1, 1, 'ডিম ফেটাও'),
(11, 1, 2, 'তেল গরম করো'),
(12, 1, 3, 'ডিম ভেজে নাও'),
(13, 2, 1, 'চিকেন ধুয়ে নাও'),
(14, 2, 2, 'মসলা মিশাও'),
(15, 2, 3, 'ভালোভাবে রান্না করো'),
(16, 3, 1, 'ময়দা ও চিনি মেশাও'),
(17, 3, 2, 'চকলেট যোগ করো'),
(18, 3, 3, 'ওভেনে বেক করো');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','chef','user') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Admin User', 'admin@recipe.com', 'admin123', 'admin', '2025-12-23 15:20:13'),
(2, 'Sara Khan', 'sara@recipe.com', 'sara123', 'user', '2025-12-23 15:20:13'),
(3, 'Admin User', 'admin@gmail.com', 'admin123', 'admin', '2025-12-23 15:27:40'),
(4, 'Rahim Uddin', 'rahim@gmail.com', 'rahim123', 'user', '2025-12-23 15:27:40'),
(5, 'Karim Ali', 'karim@gmail.com', 'karim123', 'chef', '2025-12-23 15:27:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`user_id`,`recipe_id`),
  ADD KEY `recipe_id` (`recipe_id`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`ingredient_id`),
  ADD UNIQUE KEY `ingredient_name` (`ingredient_name`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`recipe_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `recipe_ingredients`
--
ALTER TABLE `recipe_ingredients`
  ADD PRIMARY KEY (`recipe_id`,`ingredient_id`),
  ADD KEY `ingredient_id` (`ingredient_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `recipe_id` (`recipe_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `steps`
--
ALTER TABLE `steps`
  ADD PRIMARY KEY (`step_id`),
  ADD KEY `recipe_id` (`recipe_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `ingredient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `recipe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `steps`
--
ALTER TABLE `steps`
  MODIFY `step_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`) ON DELETE CASCADE;

--
-- Constraints for table `recipes`
--
ALTER TABLE `recipes`
  ADD CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `recipes_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL;

--
-- Constraints for table `recipe_ingredients`
--
ALTER TABLE `recipe_ingredients`
  ADD CONSTRAINT `recipe_ingredients_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `recipe_ingredients_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `steps`
--
ALTER TABLE `steps`
  ADD CONSTRAINT `steps_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
