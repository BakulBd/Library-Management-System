-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 20, 2024 at 07:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library_ms`
--

-- --------------------------------------------------------

--
-- Table structure for table `book_details`
--

CREATE TABLE `book_details` (
  `book_id` int(11) NOT NULL,
  `book_name` varchar(255) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `issue_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_details`
--

INSERT INTO `book_details` (`book_id`, `book_name`, `author`, `quantity`, `issue_count`) VALUES
(101, 'Mat', 'Bakul', 4, 0),
(184, 'Exam Fail Tips', 'Bakul', 85, 0),
(203, 'Object  Oriented Programming', 'Aminur', 7, 0),
(207, 'Data Structure', 'Saiful Azad', 5, 0),
(209, 'Algorithm', 'Parvez Hossain', 99, 0);

-- --------------------------------------------------------

--
-- Table structure for table `issue_book_details`
--

CREATE TABLE `issue_book_details` (
  `issue_id` int(11) NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `fine` decimal(10,2) DEFAULT 0.00,
  `book_name` varchar(255) DEFAULT NULL,
  `student_name` varchar(255) DEFAULT NULL,
  `issue_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `issue_book_details`
--

INSERT INTO `issue_book_details` (`issue_id`, `book_id`, `student_id`, `issue_date`, `due_date`, `status`, `fine`, `book_name`, `student_name`, `issue_count`) VALUES
(2, 101, 232002184, '2024-12-02', '2024-12-04', 'returned', 0.00, 'Mat', 'Bakul', 1),
(4, 207, 232002185, '2024-11-14', '2024-11-18', 'pending', 1650.00, 'Data Structure', 'Mr S', 2),
(5, 207, 232002184, '2024-12-01', '2024-12-07', 'pending', 700.00, 'Data Structure', 'Bakul', 2),
(7, 184, 232002140, '2024-11-13', '2024-11-29', 'pending', 1100.00, 'Exam Fail Tips', 'Sadika Afroz Mithi', 0),
(8, 184, 232002500, '2023-12-04', '2024-12-16', 'pending', 250.00, 'Exam Fail Tips', 'Parvez Hossain', 0);

--
-- Triggers `issue_book_details`
--
DELIMITER $$
CREATE TRIGGER `increment_issue_count` AFTER INSERT ON `issue_book_details` FOR EACH ROW BEGIN
    -- Only update if the record is being inserted for the first time
    -- This prevents the conflict when the table is updated within the same session
    IF NOT EXISTS (SELECT 1 FROM issue_book_details WHERE book_id = NEW.book_id AND status = 'pending') THEN
        UPDATE issue_book_details
        SET issue_count = issue_count + 1
        WHERE book_id = NEW.book_id;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_fine_on_due_date` BEFORE UPDATE ON `issue_book_details` FOR EACH ROW BEGIN
    -- Check if the status is not 'returned' and if the due date is passed
    IF NEW.status != 'returned' AND CURDATE() > NEW.due_date THEN
        -- Calculate the number of days overdue
        SET NEW.fine = DATEDIFF(CURDATE(), NEW.due_date) * 50;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_fine_on_return` BEFORE UPDATE ON `issue_book_details` FOR EACH ROW BEGIN
    IF NEW.status = 'returned' THEN
        SET NEW.fine = 0;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `student_details`
--

CREATE TABLE `student_details` (
  `student_id` int(11) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `course` varchar(255) DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_details`
--

INSERT INTO `student_details` (`student_id`, `student_name`, `course`, `branch`) VALUES
(23200190, 'Mahfuz', 'M.Sc', 'Biology'),
(232002140, 'Sadika Afroz Mithi', 'B.Sc', 'English'),
(232002184, 'Bakul', 'B.Sc', 'Computer Science'),
(232002185, 'Mr S', 'B.Sc', 'Computer Science'),
(232002500, 'Parvez Hossain', 'PHD', 'Computer Science');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `usertype` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `contact`, `usertype`) VALUES
(1, 'Bolu', '1222', 'hg@gmail.com', '017866255522', 'Student'),
(2, 'Bakul', '123456', 'bokula88@gmail.com', '01786685665', 'Admin'),
(3, 'Rashed', '123456', 'rashed@gmail.com', '01712345678', 'Student'),
(4, 'Hasan', '123456', 'hasan@gmail.com', '01982727272', 'Librarian'),
(5, 'Pranto', '123456', 'pranto@gmail.com', '0179826222', 'Librarian'),
(6, 'Mahfuz', '123456', 'mahfuz@gmail.com', '017347655646', 'Guest');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book_details`
--
ALTER TABLE `book_details`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `issue_book_details`
--
ALTER TABLE `issue_book_details`
  ADD PRIMARY KEY (`issue_id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `student_details`
--
ALTER TABLE `student_details`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `issue_book_details`
--
ALTER TABLE `issue_book_details`
  MODIFY `issue_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `issue_book_details`
--
ALTER TABLE `issue_book_details`
  ADD CONSTRAINT `issue_book_details_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book_details` (`book_id`),
  ADD CONSTRAINT `issue_book_details_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student_details` (`student_id`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `calculate_fine_daily` ON SCHEDULE EVERY 1 DAY STARTS '2024-12-21 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE issue_book_details
SET fine = DATEDIFF(CURDATE(), due_date) * 50
WHERE status = 'Not Returned' AND CURDATE() > due_date$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
