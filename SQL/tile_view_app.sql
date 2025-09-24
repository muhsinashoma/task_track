-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 24, 2025 at 08:45 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tile_view_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `assigned_personnel` varchar(100) DEFAULT NULL,
  `personnel_image_url` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `business_info` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_login`
--

CREATE TABLE `tbl_login` (
  `id` int NOT NULL,
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_type` int NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `user` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_date` datetime NOT NULL,
  `edited_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `edited_date` datetime NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_login`
--

INSERT INTO `tbl_login` (`id`, `user_name`, `password`, `email`, `mobile`, `user_type`, `status`, `user`, `created_date`, `edited_by`, `edited_date`, `token`) VALUES
(1, 'muhsina', 'muhsina', 'muhsina.akter2@gmail.com', '01715022945', 1, 1, 'muhsina', '2023-06-18 07:47:24', '', '2023-06-18 07:47:24', 'gjufgtfgbkigi86564'),
(2, 'bushra', 'bushra', 'bushra@gmail.com', '01770168958', 2, 1, 'bushra.aktar', '2023-06-18 07:50:44', '', '2023-06-18 07:50:44', 'fdfdfd'),
(3, 'noman', 'noman', 'noman@gmail.com', '01724-62302', 3, 1, 'noman', '2023-06-25 09:58:20', '', '2023-06-25 09:58:20', 'fdfdfd');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_name_of_allah_swt`
--

CREATE TABLE `tbl_name_of_allah_swt` (
  `id` int NOT NULL,
  `single_item_id` int NOT NULL,
  `arabic_name` varchar(100) NOT NULL,
  `english_meaning` varchar(100) NOT NULL,
  `name_of_allah_swt` varchar(70) NOT NULL,
  `bangoli_meaning` varchar(100) NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_by` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `like_status` varchar(6) NOT NULL DEFAULT 'false'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_name_of_allah_swt`
--

INSERT INTO `tbl_name_of_allah_swt` (`id`, `single_item_id`, `arabic_name`, `english_meaning`, `name_of_allah_swt`, `bangoli_meaning`, `status`, `created_by`, `created_at`, `like_status`) VALUES
(1, 1, 'Ø§Ù„Ù„Ù‡', 'The almighty', 'Allah', 'à¦†à¦²à§à¦²à¦¾à¦¹', 1, 'Muhsina', '2023-02-19 20:51:22', 'true'),
(2, 1, 'Ø§Ù„Ø±Ø­Ù…Ù†', 'The Most or Entirely Merciful', 'Ar-Rahman', 'à¦ªà¦°à¦® à¦¦à¦¯à¦¼à¦¾à¦²à§', 1, 'Muhsina', '2023-02-19 20:54:21', 'true'),
(3, 1, 'Ø§Ù„Ø±Ø­ÙŠÙ…', 'The Most Merciful', 'Ar-Rahim', 'à¦ªà¦°à¦® à¦•à¦°à§à¦£à¦¾à¦®à¦¯à¦¼', 1, 'Muhsina', '2023-02-19 21:12:47', 'true'),
(4, 1, 'Ø§Ù„Ù…Ù„Ùƒ', 'The King', 'Al-Malik', 'à¦¬à¦¾à¦¦à¦¶à¦¾à¦¹ à¦¬à¦¾ à¦°à¦¾à¦œà¦¾', 1, 'Muhsina', '2023-02-19 21:12:59', 'true'),
(5, 1, 'Ø§Ù„Ù‚Ø¯ÙˆØ³', 'Sacred', 'Al-Quddus', 'à¦†à¦²-à¦•à§à¦¦à§à¦¦à§à¦¸', 1, 'Muhsina', '2023-02-19 21:13:05', 'true'),
(6, 1, 'Ø§Ù„Ø³Ù„Ø§Ù…', 'The Giver of Peace', 'As-Salam', 'à¦¶à¦¾à¦¨à§à¦¤à¦¿ à¦¦à¦¾à¦¤à¦¾', 1, 'Muhsina', '2023-02-19 21:13:06', 'true'),
(7, 3, '???? ??????', 'Sunday', '1st day', '??????', 0, 'Muhsina', '2023-02-19 20:50:58', 'false'),
(8, 3, 'ÙŠÙŽÙˆÙ… Ø§Ù„Ø¥Ø«Ù†ÙŠÙ†', 'Monday', '2nd day', '??????', 0, 'Muhsina', '2023-02-19 23:59:18', 'false'),
(9, 3, 'ÙŠÙŽÙˆÙ… Ø§Ù„Ø£Ø±Ø¨Ø¹Ø§Ø¡', 'Tuesday', '3rd day', 'à¦®à¦™à§à¦—à¦²à¦¬à¦¾à¦°', 0, 'Muhsina', '2023-02-19 23:59:34', 'false'),
(10, 1, 'Ø§Ù„Ù…Ø¤Ù…Ù†', 'The Giver', 'Al-Mumin', 'à¦ªà§à¦°à¦¦à¦¾à¦¨à¦•à¦¾à¦°à§€', 1, 'Muhsina', '2023-02-20 00:00:25', 'true'),
(11, 1, 'Ø§Ù„Ù…Ù‡ÙŠÙ…Ù†', 'Guardian Over All', 'Al-Muhaymin', 'à¦¸à¦•à¦²à§‡à¦° à¦‰à¦ªà¦° à¦…à¦­à¦¿à¦­à¦¾à¦¬à¦•', 1, 'Muhsina', '2024-09-02 09:38:13', 'false'),
(12, 3, 'ÙŠÙŽÙˆÙ… Ø§Ù„Ø£Ø­ÙŽØ¯', 'Sunday', '1st day', 'à¦°à¦¬à¦¿à¦¬à¦¾à¦°', 1, 'Muhsina', '2023-02-19 23:59:54', 'false'),
(13, 3, 'ÙŠÙŽÙˆÙ… Ø§Ù„Ø¥Ø«Ù†ÙŠÙ†', 'Monday', '2nd day', 'à¦¸à§‹à¦®à¦¬à¦¾à¦°', 1, 'Muhsina', '2024-09-11 06:04:23', 'true'),
(14, 3, 'ÙŠÙŽÙˆÙ… Ø§Ù„Ø«Ù„Ø§Ø«Ø§Ø¡', 'Tuesday', '3rd day', 'à¦®à¦™à§à¦—à¦²à¦¬à¦¾à¦°', 1, 'Muhsina', '2023-02-20 00:03:32', 'false'),
(15, 3, 'ÙŠÙŽÙˆÙ… Ø§Ù„Ø£Ø±Ø¨Ø¹Ø§Ø¡', 'Wednesday', '4th day', 'à¦¬à§à¦§à¦¬à¦¾à¦°', 1, 'Muhsina', '2024-09-11 06:04:39', 'true'),
(16, 3, 'ÙŠÙŽÙˆÙ… Ø§Ù„Ø®Ù…ÙŠØ³', 'Thursday', '5th day', 'à¦¬à§ƒà¦¹à¦¸à§à¦ªà¦¤à¦¿à¦¬à¦¾à¦°', 1, 'Muhsina', '2023-02-03 18:10:26', '0'),
(17, 3, 'ÙŠÙŽÙˆÙ… Ø§Ù„Ø¬Ù…Ø¹Ø©', 'Friday', '6th day', 'à¦¶à§à¦•à§à¦°à¦¬à¦¾à¦°', 1, 'Muhsina', '2023-02-03 18:10:33', '0'),
(18, 3, 'ÙŠÙŽÙˆÙ… Ø§Ù„Ø³Ø¨Øª', 'Saturday', '7th day', 'à¦¶à¦¨à¦¿à¦¬à¦¾à¦°', 1, 'Muhsina', '2023-02-03 18:10:38', '0'),
(19, 5, 'dsdsdsddd', 'dsdsd', 'dsdsd', 'sdsdsd', 1, 'Muhsina', '2023-02-03 18:10:41', '0'),
(20, 5, 'fdfdf', 'fdfdf', 'dfdfd', 'fdfdfdf', 1, 'Muhsina', '2023-02-03 18:10:46', '0');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project_details`
--

CREATE TABLE `tbl_project_details` (
  `id` int NOT NULL,
  `project_name` varchar(100) NOT NULL,
  `project_owner_name` varchar(100) NOT NULL,
  `attached_file` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `contact_number` varchar(15) NOT NULL,
  `email_address` varchar(100) NOT NULL,
  `permanent_address` tinytext NOT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `edited_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `edited_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_project_details`
--

INSERT INTO `tbl_project_details` (`id`, `project_name`, `project_owner_name`, `attached_file`, `contact_number`, `email_address`, `permanent_address`, `created_by`, `created_at`, `status`, `edited_by`, `edited_at`) VALUES
(1, 'HRIS', 'Md. Masud Rabbi', NULL, '01715022945', 'mrabbi@gmail.com', 'Road#1, House#2, Mirpur-1, Dhaka.', 'Md. Masud Rabbi', '2025-09-16 05:24:27', 1, NULL, NULL),
(2, 'C-Portal', 'Marketing Department', NULL, '01847102314', 'muhsinaakter3@gmail.com', 'Banani', 'Marketing Department', '2025-09-16 05:25:28', 1, NULL, NULL),
(3, 'ITM', 'Shakil Akhter Kahn', NULL, '01847102314', 'shaki.khan@gmail.com', 'Banani', 'Shakil Akhter Kahn', '2025-09-16 05:27:44', 1, NULL, NULL),
(4, 'Billing', 'Murad Ahmrd', NULL, '01715022945', 'murad.ahmed@gmail.com', 'Banai', 'Murad Ahmrd', '2025-09-16 11:58:25', 1, NULL, NULL),
(5, 'ITM MIS', 'Shakil Bhaia', NULL, '01715022945', 'muhsina.akter2@gmail.com', 'Banani', 'Shakil Bhaia', '2025-09-23 05:58:33', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_task_board`
--

CREATE TABLE `tbl_task_board` (
  `id` int NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_task_board`
--

INSERT INTO `tbl_task_board` (`id`, `title`, `status`, `created_at`, `created_by`) VALUES
(1, 'Open', 1, '2024-11-10 07:38:18', 'muhsina'),
(2, 'Inprogress', 1, '2024-11-10 07:38:40', 'muhsina'),
(3, 'QA', 1, '2024-11-10 07:38:50', 'muhsina'),
(4, 'Done', 1, '2024-11-10 07:39:01', 'muhsina'),
(5, 'Pending Task', 1, '2024-11-11 07:02:15', 'muhsina'),
(6, 'Approved', 1, '2025-06-15 08:11:15', 'muhsina'),
(7, 'today news', 1, '2025-09-13 08:48:30', 'muhsina'),
(8, 'test', 1, '2025-09-16 10:43:01', 'muhsina');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_task_name`
--

CREATE TABLE `tbl_task_name` (
  `id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `column_name` int NOT NULL,
  `model_name` int NOT NULL,
  `project_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `edited_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `edited_by` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'muhsina',
  `previous_status` int NOT NULL DEFAULT '0',
  `status_change_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status_change_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_task_name`
--

INSERT INTO `tbl_task_name` (`id`, `title`, `column_name`, `model_name`, `project_id`, `created_at`, `created_by`, `status`, `edited_at`, `edited_by`, `previous_status`, `status_change_time`, `status_change_by`, `deleted_by`, `deleted_at`) VALUES
(1, 'need to add calender with dropdown menu', 4, 1, 1, '2025-09-18 12:09:54', 'muhsina', 1, '2025-09-18 12:09:54', 'muhsina', 1, '2025-09-19 16:34:08', 'muhsina', NULL, NULL),
(2, 'Need to show project as dropdown in appBar', 1, 1, 2, '2025-09-19 10:06:29', 'muhsina', 1, '2025-09-19 10:06:29', 'muhsina', 0, '2025-09-19 16:06:29', NULL, NULL, NULL),
(3, 'Test purpose', 2, 1, 4, '2025-09-19 10:17:13', 'muhsina', 1, '2025-09-19 10:17:13', 'muhsina', 0, '2025-09-19 16:17:13', NULL, NULL, NULL),
(4, 'tesr', 1, 1, 3, '2025-09-19 10:19:57', 'muhsina', 1, '2025-09-19 10:19:57', 'muhsina', 0, '2025-09-19 16:19:57', NULL, NULL, NULL),
(5, 'need to show enligh, bengali and hirji calender', 1, 1, 1, '2025-09-20 15:15:30', 'muhsina', 1, '2025-09-20 15:15:30', 'muhsina', 0, '2025-09-20 21:15:30', NULL, NULL, NULL),
(6, 'need to show all total task', 1, 1, 1, '2025-09-20 15:22:18', 'muhsina', 1, '2025-09-20 15:22:18', 'muhsina', 0, '2025-09-20 21:22:18', NULL, NULL, NULL),
(7, 'To show total task under respective project', 1, 1, 1, '2025-09-23 04:44:49', 'muhsina', 1, '2025-09-23 04:44:49', 'muhsina', 0, '2025-09-23 10:44:49', NULL, NULL, NULL),
(8, 'need to add total age for each device', 1, 1, 1, '2025-09-23 05:59:31', 'muhsina', 1, '2025-09-23 05:59:31', 'muhsina', 0, '2025-09-23 11:59:31', NULL, NULL, NULL),
(9, 'Need to show attendance', 1, 1, 1, '2025-09-23 06:01:49', 'muhsina', 1, '2025-09-23 06:01:49', 'muhsina', 0, '2025-09-23 12:01:49', NULL, NULL, NULL),
(10, 'need to apply salary certificate', 1, 1, 1, '2025-09-23 06:02:32', 'muhsina', 1, '2025-09-23 06:02:32', 'muhsina', 0, '2025-09-23 12:02:32', NULL, NULL, NULL),
(11, 'To test  only', 1, 1, 1, '2025-09-23 06:14:22', 'muhsina', 1, '2025-09-23 06:14:22', 'muhsina', 0, '2025-09-23 12:14:22', NULL, NULL, NULL),
(12, 'abc', 1, 1, 1, '2025-09-23 06:14:53', 'muhsina', 1, '2025-09-23 06:14:53', 'muhsina', 0, '2025-09-23 12:14:53', NULL, NULL, NULL),
(13, 'Task adding count', 2, 1, 1, '2025-09-23 06:18:01', 'muhsina', 1, '2025-09-23 06:18:01', 'muhsina', 0, '2025-09-23 12:18:01', NULL, NULL, NULL),
(14, 'need to test from QA Side', 3, 1, 1, '2025-09-24 04:44:30', 'muhsina', 1, '2025-09-24 04:44:30', 'muhsina', 0, '2025-09-24 10:44:30', NULL, NULL, NULL),
(15, 'abc', 3, 1, 1, '2025-09-24 04:45:32', 'muhsina', 1, '2025-09-24 04:45:32', 'muhsina', 0, '2025-09-24 10:45:32', NULL, NULL, NULL),
(16, 'need to show task count instanlty inside app badge', 3, 1, 1, '2025-09-24 05:00:57', 'muhsina', 1, '2025-09-24 05:00:57', 'muhsina', 0, '2025-09-24 11:00:57', NULL, NULL, NULL),
(17, 'test purpose', 4, 1, 1, '2025-09-24 05:17:17', 'muhsina', 1, '2025-09-24 05:17:17', 'muhsina', 0, '2025-09-24 11:17:17', NULL, NULL, NULL),
(18, 'To add a task', 2, 1, 1, '2025-09-24 05:23:40', 'muhsina', 1, '2025-09-24 05:23:40', 'muhsina', 0, '2025-09-24 11:23:40', NULL, NULL, NULL),
(19, 'pqr', 2, 1, 1, '2025-09-24 05:24:51', 'muhsina', 1, '2025-09-24 05:24:51', 'muhsina', 0, '2025-09-24 11:24:51', NULL, NULL, NULL),
(20, 'abcdrkl;\';ol;l;l;', 2, 1, 1, '2025-09-24 05:55:43', 'muhsina', 1, '2025-09-24 05:55:43', 'muhsina', 0, '2025-09-24 11:55:43', NULL, NULL, NULL),
(21, 'need to add project ID for task dynamically', 1, 1, 1, '2025-09-24 05:58:15', 'muhsina', 1, '2025-09-24 05:58:15', 'muhsina', 0, '2025-09-24 11:58:15', NULL, NULL, NULL),
(22, 'QA Query', 2, 1, 1, '2025-09-24 05:59:39', 'muhsina', 1, '2025-09-24 05:59:39', 'muhsina', 0, '2025-09-24 11:59:39', NULL, NULL, NULL),
(23, 'Billing Data ID', 1, 1, 1, '2025-09-24 05:59:56', 'muhsina', 1, '2025-09-24 05:59:56', 'muhsina', 0, '2025-09-24 11:59:56', NULL, NULL, NULL),
(24, 'abcdf', 1, 1, 1, '2025-09-24 06:29:00', 'muhsina', 1, '2025-09-24 06:29:00', 'muhsina', 0, '2025-09-24 12:29:00', NULL, NULL, NULL),
(25, 'It\'s a test purpose', 1, 1, 2, '2025-09-24 06:58:42', 'muhsina', 1, '2025-09-24 06:58:42', 'muhsina', 0, '2025-09-24 12:58:42', NULL, NULL, NULL),
(26, 'Need to add total device age for all status', 1, 1, 5, '2025-09-24 07:00:57', 'muhsina', 1, '2025-09-24 07:00:57', 'muhsina', 0, '2025-09-24 13:00:57', NULL, NULL, NULL),
(27, 'need to test from QA side', 2, 1, 5, '2025-09-24 07:01:28', 'muhsina', 1, '2025-09-24 07:01:28', 'muhsina', 0, '2025-09-24 13:01:28', NULL, NULL, NULL),
(28, 'billing report generate', 1, 1, 4, '2025-09-24 07:03:05', 'muhsina', 1, '2025-09-24 07:03:05', 'muhsina', 0, '2025-09-24 13:03:05', NULL, NULL, NULL),
(29, 'need to add MIS for device', 1, 1, 5, '2025-09-24 07:04:12', 'muhsina', 1, '2025-09-24 07:04:12', 'muhsina', 0, '2025-09-24 13:04:12', NULL, NULL, NULL),
(30, 'Need to show Age Caluculation in MIS', 1, 1, 5, '2025-09-24 08:37:45', 'muhsina', 1, '2025-09-24 08:37:45', 'muhsina', 0, '2025-09-24 14:37:45', NULL, NULL, NULL),
(31, 'To add billing cost for Task Managment', 1, 1, 4, '2025-09-24 08:41:36', 'muhsina', 1, '2025-09-24 08:41:36', 'muhsina', 0, '2025-09-24 14:41:36', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_title_subtitle`
--

CREATE TABLE `tbl_title_subtitle` (
  `id` int NOT NULL,
  `title` varchar(80) NOT NULL,
  `subtitle` varchar(80) NOT NULL,
  `status` int NOT NULL,
  `created_by` varchar(15) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(50) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_title_subtitle`
--

INSERT INTO `tbl_title_subtitle` (`id`, `title`, `subtitle`, `status`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, '99 Names of Allah(Subhanahu Wa Ta\'ala)', 'Arabic, English & Bangoli', 1, 'Muhsina', '2022-11-23 18:56:57', '', '0000-00-00 00:00:00'),
(2, 'Arabic Words those are used in Bangoly  Test', 'Arabic, English & Bangoly   Test', 1, 'Muhsina', '2022-11-23 19:31:59', 'Muhsina', '2022-11-23 19:31:41'),
(3, 'Weekly Name', 'Arabic, English & Bangoly', 1, 'Muhsina', '2023-01-01 22:43:14', 'Muhsina Akter', '2023-01-01 22:43:07'),
(4, 'Monthly Name  Test', 'Arabic, English & Bangoli  Test Purpos', 1, 'muhsina', '2023-06-03 05:00:37', 'Muhsina', '2022-11-23 19:29:36'),
(5, 'List of Ayatun(Simble) of Quran', 'Arabic, English & Bangoli', 1, 'muhsina', '2023-06-03 05:00:52', 'Muhsina Akter', '2023-01-11 21:35:20'),
(6, 'Colors Name', 'Arabic, English & Bangoli', 1, 'muhsina', '2023-06-03 05:00:57', '', '0000-00-00 00:00:00'),
(7, 'fdfdf', 'dfd', 1, 'Muhsina', '2023-06-03 05:04:48', '', '0000-00-00 00:00:00'),
(8, 'rere', 'rerer', 1, 'rer', '2023-06-03 05:04:53', '', '0000-00-00 00:00:00'),
(9, 'Ayatun of Quran', 'Arabic, English & Bangoli', 1, 'Muhsina', '2023-06-03 05:04:14', '', '0000-00-00 00:00:00'),
(10, 'rtrtrt', 'rtrfdf', 1, 'Muhsina', '2023-06-03 05:05:00', '', '0000-00-00 00:00:00'),
(11, 'op', 'llll', 1, 'Muhsina', '2023-06-03 05:15:26', '', '0000-00-00 00:00:00'),
(12, 'ty', 'ggg', 1, 'Muhsina', '2023-06-03 05:19:51', '', '0000-00-00 00:00:00'),
(19, '', '', 1, '', '2023-06-03 05:17:16', '', '0000-00-00 00:00:00'),
(20, 'fdfd', 'df', 1, 'muhsina', '2023-06-03 05:17:16', '', '0000-00-00 00:00:00'),
(21, 'ewewe', 'ewew', 1, 'eewewew', '2023-06-03 05:17:16', '', '0000-00-00 00:00:00'),
(22, 'ewewe', 'ewew', 1, '', '2023-06-03 05:17:16', '', '0000-00-00 00:00:00'),
(23, 'ewewe', 'ewew', 1, 'Muhsina', '2023-06-03 05:17:16', '', '0000-00-00 00:00:00'),
(24, 'fdfdf', 'fdfd', 1, 'fdfdf', '2023-06-03 05:17:16', '', '0000-00-00 00:00:00'),
(25, 'dsdsds', 'fdfdfdf', 1, 'Muhsina', '2023-06-03 05:17:16', '', '0000-00-00 00:00:00'),
(26, 'Radiah Islam', 'Arabic, English & Bangoli', 1, 'Muhsina', '2023-06-03 05:17:16', '', '0000-00-00 00:00:00'),
(27, 'Title   three', 'Subtitle three', 1, 'Muhsina', '2023-06-03 05:17:16', '', '0000-00-00 00:00:00'),
(28, 'dsds', 'sdsds', 1, 'dsdd', '2023-06-03 05:17:16', '', '0000-00-00 00:00:00'),
(29, 'sdsds', 'sdsdsd', 1, 'MuhSIna', '2023-06-03 05:17:16', '', '0000-00-00 00:00:00'),
(30, 'fdfdf', 'dfdffd', 0, 'Muhsina', '2023-06-07 04:10:02', '', '0000-00-00 00:00:00'),
(31, 'ABC test 123456', 'ABC Subtitle test', 0, '', '2023-06-07 04:10:30', '', '0000-00-00 00:00:00'),
(32, 'fdfdf', 'fdfdfdf', 1, 'muhsina', '2023-06-03 05:09:02', '', '0000-00-00 00:00:00'),
(33, 'fdfdf   test', 'test', 0, 'fdfdf', '2023-06-07 04:09:55', '', '0000-00-00 00:00:00'),
(34, 'Title', 'Subtitle', 1, 'Muhsina', '2023-06-03 05:09:15', '', '0000-00-00 00:00:00'),
(35, 'abc', 'zyx', 0, '', '2022-11-23 18:56:09', '', '0000-00-00 00:00:00'),
(36, 'ffdfdddsdsds', 'dfdfdfdf', 0, 'fdfdfdfd', '2022-11-23 18:56:11', '', '0000-00-00 00:00:00'),
(37, 'dfdfd', 'fdfdfdffdfdfdf', 0, 'fdfdfd', '2022-11-23 18:56:12', '', '0000-00-00 00:00:00'),
(38, 'dfdfd', 'fdfdfdffdfdfdf', 0, 'fdfdfd', '2022-11-23 18:56:14', '', '0000-00-00 00:00:00'),
(39, 'dfdfd', 'fdfdfdffdfdfdf', 0, 'fdfdfd', '2022-11-23 18:56:16', '', '0000-00-00 00:00:00'),
(40, 'dfdfd', 'fdfdfdffdfdfdf', 0, 'fdfdfd', '2022-11-23 18:56:18', '', '0000-00-00 00:00:00'),
(41, 'dfdfd', 'fdfdfdffdfdfdf', 0, 'fdfdfd', '2022-11-23 18:56:43', '', '0000-00-00 00:00:00'),
(42, 'fdfdf', 'errrfdfdf', 0, 'fdfdf', '2022-11-23 18:56:41', '', '0000-00-00 00:00:00'),
(43, 'Test Purpose   TEST', 'Subtitle Test Purpose  TEST', 0, 'Muhsina', '2022-11-23 18:56:07', '', '0000-00-00 00:00:00'),
(44, 'FDFDF', 'DFDF', 0, 'MUHSINA', '2022-11-23 18:56:45', '', '2022-11-23 18:54:27'),
(45, 'You and Me', 'test', 0, 'muhsina akter', '2022-11-23 21:16:22', '', '2022-11-23 19:39:59'),
(46, 'You & Me', 'You & Me', 0, ' Muhsina', '2022-11-23 21:16:24', '', '2022-11-23 19:40:21'),
(47, 'Test purpose  1', 'Test Purpose 1', 0, 'Muhsina', '2022-12-01 01:41:55', 'Muhsina', '2022-11-23 21:18:37'),
(48, 'Today Test Saturday', 'Today Subtitle Saturday', 0, 'Muhsina', '2022-12-16 19:48:00', 'muhsina akter', '2022-11-25 18:37:14'),
(49, 'dfdfd', 'dfdf', 0, 'fdfdf', '2022-11-25 18:35:50', '', '2022-11-23 21:17:59'),
(50, 'abc', '123', 0, 'Muhsina', '2022-12-01 01:41:41', '', '2022-11-29 23:23:29'),
(51, 'gfgfg', 'gfgfg', 0, 'ffgf', '2022-12-01 01:41:46', '', '2022-11-29 23:24:15'),
(52, 'Today Test', 'Today Test Subtitle', 0, 'Muhsina Akter', '2022-12-01 01:41:38', '', '2022-11-30 21:07:27'),
(53, 'fdfdf', 'fdfdf', 0, 'muhsina', '2022-12-01 01:41:34', '', '2022-11-30 21:08:16'),
(54, 'Tittle', 'Subtitle', 0, 'Muhsina', '2022-12-16 19:48:13', '', '2022-11-30 21:08:49'),
(55, 'Title', 'Sub title', 0, 'Muhsina', '2023-01-01 18:51:27', '', '2023-01-01 18:51:14'),
(56, 'Title Name abc  ', 'Suntitle Name abc  ', 0, 'Muhsina', '2023-01-11 19:41:56', 'Muhsina Akter', '2023-01-11 19:41:22'),
(57, 'fdfdfd', 'fdfdfd', 0, 'Muhsina', '2023-01-11 19:41:18', '', '2023-01-11 19:19:57'),
(58, 'fdfdfdf', 'fdfdf', 0, 'muhsina', '2023-01-21 05:59:29', '', '2023-01-21 05:58:48'),
(59, 'uyuyuyu', 'ppopopo', 0, 'muhsina', '2023-01-21 05:59:33', '', '2023-01-21 05:59:21'),
(60, 'Test purpose only', 'test', 1, 'Muhsina', '0000-00-00 00:00:00', '', '2024-09-10 10:01:33'),
(61, 'ABC', '123', 1, '', '0000-00-00 00:00:00', '', '2024-09-10 10:02:09');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_weekly_name`
--

CREATE TABLE `tbl_weekly_name` (
  `id` int NOT NULL,
  `single_item_id` int NOT NULL,
  `arabic_name` varchar(50) NOT NULL,
  `bangoli_name` varchar(50) NOT NULL,
  `day_count` varchar(50) NOT NULL,
  `english_name` varchar(50) NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_by` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_weekly_name`
--

INSERT INTO `tbl_weekly_name` (`id`, `single_item_id`, `arabic_name`, `bangoli_name`, `day_count`, `english_name`, `status`, `created_by`, `created_at`) VALUES
(1, 3, 'fdfd', 'fdfdf', '1', 'Sunday', 1, 'Muhsina', '2023-01-04 22:55:02'),
(2, 3, 'fdfdf', 'fd', '2', 'Monday', 1, 'Muhsina', '2023-01-04 22:55:05'),
(3, 3, 'fdfdf', 'fdfdf', '3', 'Tuesday', 1, 'Muhsina', '2023-01-04 22:55:10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_login`
--
ALTER TABLE `tbl_login`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_name_of_allah_swt`
--
ALTER TABLE `tbl_name_of_allah_swt`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_project_details`
--
ALTER TABLE `tbl_project_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_task_board`
--
ALTER TABLE `tbl_task_board`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_task_name`
--
ALTER TABLE `tbl_task_name`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_title_subtitle`
--
ALTER TABLE `tbl_title_subtitle`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_weekly_name`
--
ALTER TABLE `tbl_weekly_name`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_login`
--
ALTER TABLE `tbl_login`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_name_of_allah_swt`
--
ALTER TABLE `tbl_name_of_allah_swt`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tbl_project_details`
--
ALTER TABLE `tbl_project_details`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_task_board`
--
ALTER TABLE `tbl_task_board`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_task_name`
--
ALTER TABLE `tbl_task_name`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `tbl_title_subtitle`
--
ALTER TABLE `tbl_title_subtitle`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `tbl_weekly_name`
--
ALTER TABLE `tbl_weekly_name`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
