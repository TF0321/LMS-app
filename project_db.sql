-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 10, 2024 at 06:56 PM
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
-- Database: `project_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `roleID` smallint(6) NOT NULL,
  `roleDescription` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`roleID`, `roleDescription`) VALUES
(1, 'Student'),
(2, 'Administrator');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(100) NOT NULL,
  `userFirstName` varchar(100) NOT NULL,
  `userLastName` varchar(100) NOT NULL,
  `userEmail` varchar(100) NOT NULL,
  `userRoleID` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `userFirstName`, `userLastName`, `userEmail`, `userRoleID`) VALUES
(21, 'RoleTest', '', 'RoleTest@email.com', 1),
(22, 'TestRole', '', 'Test2@gmail.com', 2),
(23, 'Thomas', '', 'Thomas@gmail.com', 1),
(24, 'Thomas', '', 'thomas.forder@virginmedia.com', 1),
(25, 'Thomas', 'Thomas', 'thomas.forder@virginmedia.com', 1),
(26, 'Thomas', 'Forder', 'thomas.forder@virginmedia.com', 2),
(28, 'Thomas', 'Forder', 'tforder@gmail.com', 1),
(30, 'Darren', 'Forder', 'dforder@gmail.com', 1),
(32, 'Thomas', 'Forder', 'tforder@stpaulscc.co.ukdddd', 1),
(33, 'Thomas', 'Forder', 'tforder@stpaulscc.co.uk', 2),
(34, 'Thomas', 'Forder', 'tforder@stpaulscc.co.ukz', 1),
(35, 'Thomas', 'Forder', 'tforder@stpaulscc.co.uk', 1),
(36, 'Thomas', 'Forder', 'tforder@stpaulscc.co.uk', 1),
(37, 'Thomas', 'Forder', 'tforder@stpaulscc.co.uka', 1),
(38, 'Angela', 'Forder', 'aforder@gmail.com', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`roleID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`),
  ADD KEY `userRoleFKey` (`userRoleID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `roleID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `userRoleFKey` FOREIGN KEY (`userRoleID`) REFERENCES `roles` (`roleID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
