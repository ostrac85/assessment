-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 26, 2019 at 05:51 AM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.1.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `assessment_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `assement_questions`
--

CREATE TABLE `assement_questions` (
  `id` int(11) NOT NULL,
  `assesment_id` int(11) NOT NULL,
  `question` varchar(250) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `assement_questions`
--

INSERT INTO `assement_questions` (`id`, `assesment_id`, `question`, `date_created`) VALUES
(1, 1, 'How many letters are there in you?', '2019-09-05 11:41:00'),
(2, 1, 'Secret is what?', '2019-09-05 11:41:00'),
(3, 2, 'What is first letter in the alphabet?', '2019-09-05 18:52:05'),
(4, 2, 'What is the time yesterday?', '2019-09-05 18:52:05'),
(5, 15, 'asdf', '2019-09-06 11:00:20'),
(6, 15, 'sdfsadfhhhh', '2019-09-06 11:00:20'),
(7, 16, 'True or False?', '2019-09-06 12:11:40'),
(8, 16, 'Where are you?', '2019-09-06 12:11:40'),
(9, 16, 'Why?', '2019-09-06 12:11:40');

-- --------------------------------------------------------

--
-- Table structure for table `assessment`
--

CREATE TABLE `assessment` (
  `id` int(11) NOT NULL,
  `description` varchar(250) NOT NULL,
  `user_level` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '0 = inactive, 1 = active',
  `expiry_date` datetime NOT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Dumping data for table `assessment`
--

INSERT INTO `assessment` (`id`, `description`, `user_level`, `status`, `expiry_date`, `created_date`) VALUES
(1, 'Assessment one and done', 'Tier 1', 1, '2019-09-17 16:00:00', '0001-01-01 00:00:00'),
(2, 'Test 1 ', 'Tier 1', 1, '2019-09-30 16:00:00', '0001-01-01 00:00:00'),
(15, 'T3 assessment', 'Tier 3', 1, '2019-09-09 02:59:00', '0001-01-01 00:00:00'),
(16, 'Test 123', 'Tier 1', 1, '2019-09-17 04:10:00', '2019-09-06 12:10:22');

-- --------------------------------------------------------

--
-- Table structure for table `assessment_choices`
--

CREATE TABLE `assessment_choices` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `description` varchar(250) NOT NULL,
  `is_correct` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Dumping data for table `assessment_choices`
--

INSERT INTO `assessment_choices` (`id`, `question_id`, `description`, `is_correct`) VALUES
(1, 1, '1', 0),
(2, 1, '2', 0),
(3, 1, '3', 1),
(4, 2, 'none', 0),
(5, 2, 'true', 1),
(6, 2, 'false', 0),
(7, 3, 'A', 1),
(8, 3, 'B', 0),
(9, 3, 'C', 0),
(10, 4, '5pm', 0),
(11, 4, '7pm', 0),
(12, 4, 'i dont know', 0),
(13, 4, '8:30', 0),
(14, 4, 'Afternoon', 0),
(15, 4, 'Ask your neighbor', 1),
(16, 4, '3am', 0),
(17, 5, 'sssss', 0),
(18, 5, '22222', 1),
(19, 5, '1111', 0),
(20, 6, 'no', 0),
(21, 6, 'nonr', 1),
(22, 7, 'True', 0),
(23, 7, 'False', 1),
(24, 8, 'Here', 0),
(25, 8, 'There', 0),
(26, 8, 'Everywhere', 1),
(27, 9, 'Idk', 0),
(28, 9, 'because', 1),
(29, 9, 'zup!', 0);

-- --------------------------------------------------------

--
-- Table structure for table `assessment_user`
--

CREATE TABLE `assessment_user` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(25) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Dumping data for table `assessment_user`
--

INSERT INTO `assessment_user` (`id`, `username`, `user_password`, `first_name`, `last_name`, `email`, `phone`, `date_created`) VALUES
(1, 'adrian', 'adrian', 'Adrian', 'Castro', 'me@yahoo.com', '13334234234', '0001-01-01 00:00:00'),
(2, '', '', 'asdfsadf', 'sdfsadfasdf', 'me@hahaha.ca', '2323234', '0001-01-01 00:00:00'),
(3, '', '', 'dasfasdf', 'sdafsdaf', 'me@hahsadf.com', '12121', '0001-01-01 00:00:00'),
(4, 'ad', 'cast', 'Ad', 'saaaa', 'juan@yahoo.com', '12121', '0001-01-01 00:00:00'),
(5, '', '', 'asd', '123444', 'me@yaya.com', '1212', '0001-01-01 00:00:00'),
(6, '', '', 'ad', 'asda', 'me@haha.ca', '1212', '0001-01-01 00:00:00'),
(7, '', '', 'adrian', 'asjdhfkj', 'test@yahoo.com', '1234555', '0001-01-01 00:00:00'),
(8, '', '', 'adrian', '123', 'dsafasdf@hahaha.com', '12133', '0001-01-01 00:00:00'),
(9, '', '', 'asdfasdf', 'asdfasdf', 'me@sdfasd.ca', '1212', '0001-01-01 00:00:00'),
(10, '', '', 'Adrian', 'Jose', 'jose@ca.ca', '32232', '0001-01-01 00:00:00'),
(11, '', '', 'Aaa', 'kdasjflkasdj', 'test@yahoo.com', '123', '0001-01-01 00:00:00'),
(12, '', '', 'Test', '1233', 'me@yahoo.com', '1212', '0001-01-01 00:00:00'),
(13, 'cast', 'cast', 'ADrian', 'Cast', '12333@yahoo.com', '123', '0001-01-01 00:00:00'),
(14, '', '', 'aasdfasdf', 'cast', 'sadfsadf@haha.com', '1234', '0001-01-01 00:00:00'),
(15, '', '', 'Adrain', 'Cast', 'test@yahoo.com', '123444454', '0001-01-01 00:00:00'),
(16, '', '', 'Ad', 'test', 'test@yahoo.com', '2323232', '0001-01-01 00:00:00'),
(17, '', '', 'Addd', 'Castro', 'adrian@yahoo.com', '1212121', '0001-01-01 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_answers`
--

CREATE TABLE `user_answers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `user_answer` int(11) NOT NULL,
  `correct_answer` int(11) NOT NULL,
  `date_created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

--
-- Dumping data for table `user_answers`
--

INSERT INTO `user_answers` (`id`, `user_id`, `assessment_id`, `question_id`, `user_answer`, `correct_answer`, `date_created`) VALUES
(10, 1, 1, 1, 2, 3, 0),
(11, 1, 1, 2, 6, 5, 0),
(12, 1, 2, 3, 7, 7, 0),
(13, 1, 2, 4, 12, 15, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assement_questions`
--
ALTER TABLE `assement_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_assessment_id` (`assesment_id`);

--
-- Indexes for table `assessment`
--
ALTER TABLE `assessment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `desc_idx` (`description`) USING BTREE;

--
-- Indexes for table `assessment_choices`
--
ALTER TABLE `assessment_choices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `correct_idx` (`is_correct`);

--
-- Indexes for table `assessment_user`
--
ALTER TABLE `assessment_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_answers`
--
ALTER TABLE `user_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_idx` (`user_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `assessment_idx` (`assessment_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assement_questions`
--
ALTER TABLE `assement_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `assessment`
--
ALTER TABLE `assessment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `assessment_choices`
--
ALTER TABLE `assessment_choices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `assessment_user`
--
ALTER TABLE `assessment_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `user_answers`
--
ALTER TABLE `user_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
