-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 13, 2025 at 06:59 PM
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
  `created_at` timestamp NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `edited_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `edited_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_project_details`
--

INSERT INTO `tbl_project_details` (`id`, `project_name`, `project_owner_name`, `attached_file`, `contact_number`, `email_address`, `permanent_address`, `created_by`, `created_at`, `status`, `edited_by`, `edited_at`) VALUES
(1, 'ITM', 'Muhsina Akter', NULL, '01715022945', 'muhsina.akter2@gmail.com', 'Kushtia', 'Muhsina Akter', '2025-09-13 12:30:02', 1, NULL, NULL),
(2, 'ITM', 'Muhsina Akter', NULL, '01715022945', 'muhsina.akter2@gmail.com', '8/1 B.C. Street, Babor Ali Gate, Kuhshtia.', 'Muhsina Akter', '2025-09-13 12:34:56', 1, NULL, NULL),
(3, 'ITM', 'Muhsina Akter', NULL, '01715022945', 'muhsina.akter2@gmail.com', '8/1 B.C. Street, Babor Ali Gate, Kuhshtia.', 'Muhsina Akter', '2025-09-13 12:35:00', 1, NULL, NULL),
(4, 'ITM', 'Muhsina Akter', NULL, '01715022945', 'muhsina.akter2@gmail.com', '8/1 B.C. Street, Babor Ali Gate, Kuhshtia.', 'Muhsina Akter', '2025-09-13 12:35:06', 1, NULL, NULL),
(5, 'ITM', 'Muhsina Akter', NULL, '01715022945', 'muhsina.akter2@gmail.com', '8/1 B.C. Street, Babor Ali Gate, Kuhshtia.', 'Muhsina Akter', '2025-09-13 12:35:30', 1, NULL, NULL),
(6, 'HRIS', 'Radiah Islam', NULL, '01715022945', 'muhsinaakter3@gmail.com', 'Kushia', 'Radiah Islam', '2025-09-13 12:37:07', 1, NULL, NULL),
(7, 'HRIS', 'Sadia Islam', NULL, '01715022945', 'muhsina.akter2@gmail.com', 'Kushia', 'Sadia Islam', '2025-09-13 12:54:30', 1, NULL, NULL),
(8, 'ITM MIS', 'Nadia Islam', NULL, '01847102314', 'muhsinaakter3@gmail.com', '8/1 B.C.Street, Babor Ali Gate, Amlapara, Kushaia-7000.', 'Nadia Islam', '2025-09-13 12:56:45', 1, NULL, NULL);

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
(7, 'today news', 1, '2025-09-13 08:48:30', 'muhsina');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_task_name`
--

CREATE TABLE `tbl_task_name` (
  `id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `column_name` int NOT NULL,
  `model_name` int NOT NULL,
  `project_name` int NOT NULL,
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

INSERT INTO `tbl_task_name` (`id`, `title`, `column_name`, `model_name`, `project_name`, `created_at`, `created_by`, `status`, `edited_at`, `edited_by`, `previous_status`, `status_change_time`, `status_change_by`, `deleted_by`, `deleted_at`) VALUES
(1, 'Multiple TT Create at a time for ITM Module', 5, 1, 1, '2024-11-10 07:39:26', 'muhisna', 1, '2024-11-19 07:01:17', '', 1, '2024-11-24 16:34:33', 'muhsina', '', '2024-11-24 17:58:36'),
(2, 'Display a report showing the average time for TT to open and close, organized by date. Additionally, show the average time for the current month on the dashboard', 5, 1, 1, '2024-11-10 07:42:20', 'muhisna', 1, '2024-11-19 07:01:17', '', 1, '0000-00-00 00:00:00', 'muhsina', '', '2024-11-24 17:58:36'),
(3, 'Update employee information in the HRIS system, including: ○	Mobile number. ○	Email. ○	Designation', 4, 1, 1, '2024-11-10 07:44:26', 'muhisna', 1, '2024-11-19 07:01:17', '', 1, '2024-11-18 10:56:06', 'muhsina', '', '2024-11-24 17:58:36'),
(4, 'Add \"Device Requisition\" to the main menu on the left sidebar. Under this menu, include: ○	TT Requisition List. ○	Approval List.', 4, 1, 1, '2024-11-10 07:45:50', 'muhisna', 1, '2024-11-19 07:01:17', '', 3, '0000-00-00 00:00:00', 'muhsina', '', '2024-11-24 17:58:36'),
(5, 'Display a report showing the average time for TT to open and close, organized by date. Additionally, show the average time for the current month on the dashboard.', 4, 1, 1, '2024-11-10 07:46:14', 'muhisna', 1, '2024-11-19 07:01:17', '', 2, '2024-11-19 12:57:39', 'muhsina', '', '2024-11-24 17:58:36'),
(6, 'Implement an \"Approve\" button.', 4, 1, 1, '2024-11-10 07:49:14', 'muhisna', 1, '2024-11-19 07:01:17', '', 3, '0000-00-00 00:00:00', 'muhsina', '', '2024-11-24 17:58:36'),
(7, 'Add print functionality with two options: ○	Print All TT Summary. ○	Print TT Details. test', 4, 1, 1, '2024-11-10 07:49:31', 'muhisna', 1, '2025-09-13 08:49:50', 'muhsina', 3, '0000-00-00 00:00:00', 'muhsina', '', '2024-11-24 17:58:36'),
(8, 'Supply Chain with ITM Device Issue', 2, 1, 1, '2024-11-10 09:34:17', 'muhsina', 0, '2024-11-19 07:01:17', '', 3, '2024-11-20 12:57:25', 'muhsina', 'muhsina', '2024-11-25 12:01:31'),
(9, 'test', 4, 1, 1, '2024-11-11 07:02:20', 'muhsina', 0, '2024-11-19 07:01:17', '', 3, '0000-00-00 00:00:00', 'muhsina', 'muhsina', '2025-09-13 14:49:40'),
(10, 'To add access issue for IT Persons', 5, 1, 1, '2024-11-11 12:16:38', 'muhsina', 1, '2024-11-19 07:01:17', '', 3, '0000-00-00 00:00:00', 'muhsina', '', '2024-11-24 17:58:36'),
(11, 'Modification for Device Requisition', 6, 1, 1, '2024-11-14 06:25:18', 'muhsina', 1, '2025-06-15 08:15:41', 'muhsina', 4, '2025-06-15 14:14:34', 'muhsina', '', '2024-11-24 17:58:36'),
(12, 'Need to add email in TT Edit View Page', 5, 1, 1, '2024-11-14 06:25:44', 'muhsina', 1, '2024-11-19 07:01:17', '', 4, '2024-11-20 12:50:31', 'muhsina', '', '2024-11-24 17:58:36'),
(13, 'To add device report under report menu', 3, 1, 1, '2024-11-14 06:28:43', 'muhsina', 1, '2024-11-19 07:01:17', '', 2, '2024-11-18 18:30:05', 'muhsina', '', '2024-11-24 17:58:36'),
(14, 'TT Average Age in MIS', 5, 1, 1, '2024-11-14 07:02:50', 'muhsina', 1, '2024-11-19 07:01:17', '', 4, '2024-11-18 18:30:09', 'muhsina', '', '2024-11-24 17:58:36'),
(15, 'test', 5, 1, 1, '2024-11-19 07:12:48', 'muhsina', 1, '2024-11-19 07:12:48', 'muhsina', 1, '2024-11-24 16:31:34', 'muhsina', '', '2024-11-24 17:58:36'),
(16, 'PHP Mail Configuration', 5, 1, 1, '2024-11-19 08:39:38', 'muhsina', 1, '2024-11-19 08:39:38', 'muhsina', 1, '2024-11-24 16:31:04', 'muhsina', '', '2024-11-24 17:58:36'),
(17, 'Test Purpose Only', 2, 1, 1, '2024-11-20 07:01:47', 'muhsina', 0, '2024-11-20 07:01:47', 'muhsina', 0, '2024-11-20 13:01:47', NULL, 'muhsina', '2024-11-25 11:57:51'),
(18, 'test purpose only', 5, 1, 1, '2024-11-21 06:03:35', 'muhsina', 0, '2024-11-21 06:03:35', 'muhsina', 1, '2024-11-24 16:30:21', 'muhsina', 'muhsina', '2024-11-25 11:55:03'),
(19, 'Test Purpose. It\'s a test', 2, 1, 1, '2024-11-24 10:29:30', 'muhsina', 1, '2025-09-03 06:07:04', 'muhsina', 0, '2024-11-24 16:29:30', NULL, '', '2024-11-24 17:58:36'),
(20, 'Need to check from ITM Side', 1, 1, 1, '2024-11-24 10:32:34', 'muhsina', 0, '2024-11-24 10:32:34', 'muhsina', 5, '2024-11-24 16:38:19', 'muhsina', 'muhsina', '2024-11-25 11:58:53'),
(21, 'test only itm issue', 1, 1, 1, '2024-11-24 10:36:51', 'muhsina', 0, '2024-11-24 10:36:51', 'muhsina', 5, '2024-11-24 16:38:05', 'muhsina', 'muhsina', '2024-11-25 11:59:31'),
(22, 'test', 1, 1, 1, '2024-11-25 05:09:35', 'muhsina', 0, '2024-11-25 05:09:35', 'muhsina', 0, '2024-11-25 11:09:35', NULL, 'muhsina', '2024-11-25 11:49:42'),
(23, 'QA Test', 2, 1, 1, '2024-11-25 05:10:24', 'muhsina', 0, '2024-11-25 05:10:24', 'muhsina', 0, '2024-11-25 11:10:24', NULL, 'muhsina', '2024-11-25 11:57:16'),
(24, 'Pending Issue', 5, 1, 1, '2024-11-25 05:15:09', 'muhsina', 0, '2024-11-25 05:15:09', 'muhsina', 0, '2024-11-25 11:15:09', NULL, 'muhsina', '2024-11-25 11:46:23'),
(25, 'Need to Add ID with Name', 3, 1, 1, '2024-11-25 06:00:20', 'muhsina', 1, '2024-11-25 06:00:20', 'muhsina', 1, '2025-09-02 12:24:02', 'muhsina', NULL, NULL),
(26, 'Recruitment Approved-2025', 6, 1, 1, '2025-06-15 08:12:13', 'muhsina', 1, '2025-06-15 08:12:13', 'muhsina', 0, '2025-06-15 14:12:13', NULL, NULL, NULL),
(27, 'Home Page Design-It\'s a test purpose', 1, 1, 1, '2025-06-15 08:16:27', 'muhsina', 1, '2025-07-12 08:44:50', 'muhsina', 0, '2025-06-15 14:16:27', NULL, NULL, NULL),
(28, 'It\'s a test purpose', 3, 1, 1, '2025-07-12 08:27:17', 'muhsina', 1, '2025-07-12 08:27:17', 'muhsina', 1, '2025-09-02 12:23:59', 'muhsina', NULL, NULL),
(29, 'ITM Inventory is progress status', 2, 1, 1, '2025-07-12 08:45:34', 'muhsina', 1, '2025-07-12 08:45:34', 'muhsina', 0, '2025-07-12 14:45:34', NULL, NULL, NULL),
(30, 'Inventory Implementaton with ITM Module', 1, 1, 1, '2025-09-02 05:35:26', 'muhsina', 1, '2025-09-02 05:35:26', 'muhsina', 0, '2025-09-02 11:35:26', NULL, NULL, NULL),
(31, 'Need to show project name as asc order', 1, 1, 1, '2025-09-02 06:23:54', 'muhsina', 1, '2025-09-02 06:23:54', 'muhsina', 0, '2025-09-02 12:23:54', NULL, NULL, NULL),
(32, 'It\' a tet pouprose', 2, 1, 1, '2025-09-02 06:31:45', 'muhsina', 1, '2025-09-02 06:31:45', 'muhsina', 0, '2025-09-02 12:31:45', NULL, NULL, NULL),
(33, 'It\'s a test for open. It\'s a test', 1, 1, 1, '2025-09-02 06:41:45', 'muhsina', 1, '2025-09-03 06:06:46', 'muhsina', 0, '2025-09-02 12:41:45', NULL, NULL, NULL),
(34, 'It\'s a test for inprogress', 2, 1, 1, '2025-09-02 06:41:57', 'muhsina', 1, '2025-09-02 06:41:57', 'muhsina', 0, '2025-09-02 12:41:57', NULL, NULL, NULL),
(35, 'It\'s a test for QA. Need to test as QA postion', 3, 1, 1, '2025-09-02 06:42:06', 'muhsina', 1, '2025-09-03 06:07:21', 'muhsina', 0, '2025-09-02 12:42:06', NULL, NULL, NULL),
(36, 'To Add Home Page with kanban_set_state_page', 4, 1, 1, '2025-09-02 11:49:14', 'muhsina', 1, '2025-09-02 11:49:14', 'muhsina', 0, '2025-09-02 17:49:14', NULL, NULL, NULL),
(37, 'To add Enlish, Hirji and Bangla Calender', 1, 1, 1, '2025-09-06 15:16:10', 'muhsina', 1, '2025-09-06 15:16:10', 'muhsina', 0, '2025-09-06 21:16:10', NULL, NULL, NULL),
(38, 'test', 2, 1, 1, '2025-09-06 15:16:25', 'muhsina', 1, '2025-09-06 15:16:25', 'muhsina', 0, '2025-09-06 21:16:25', NULL, NULL, NULL),
(39, 'abc', 1, 1, 1, '2025-09-06 15:19:55', 'muhsina', 1, '2025-09-06 15:19:55', 'muhsina', 0, '2025-09-06 21:19:55', NULL, NULL, NULL),
(40, 'Its\' a test', 1, 1, 1, '2025-09-06 15:21:45', 'muhsina', 1, '2025-09-06 15:21:45', 'muhsina', 0, '2025-09-06 21:21:45', NULL, NULL, NULL),
(41, 'poy', 3, 1, 1, '2025-09-06 15:22:08', 'muhsina', 1, '2025-09-06 15:22:08', 'muhsina', 0, '2025-09-06 21:22:08', NULL, NULL, NULL),
(42, 'It\' a test purpose', 1, 1, 1, '2025-09-08 10:54:41', 'muhsina', 1, '2025-09-08 10:54:41', 'muhsina', 0, '2025-09-08 16:54:41', NULL, NULL, NULL),
(43, 'gjkkl', 2, 1, 1, '2025-09-08 10:55:00', 'muhsina', 1, '2025-09-08 10:55:00', 'muhsina', 0, '2025-09-08 16:55:00', NULL, NULL, NULL),
(44, 'Current date data only', 1, 1, 1, '2025-09-08 11:14:09', 'muhsina', 1, '2025-09-08 11:14:09', 'muhsina', 0, '2025-09-08 17:14:09', NULL, NULL, NULL),
(45, 'searching is wokring from dropdown menu. It\' a test only', 2, 1, 1, '2025-09-08 11:22:43', 'muhsina', 1, '2025-09-12 19:07:40', 'muhsina', 0, '2025-09-08 17:22:43', NULL, NULL, NULL),
(46, 'Searching is not completed', 1, 1, 1, '2025-09-08 11:28:52', 'muhsina', 1, '2025-09-08 11:28:52', 'muhsina', 0, '2025-09-08 17:28:52', NULL, NULL, NULL),
(47, 'Need to test from QA Side', 3, 1, 1, '2025-09-08 11:35:08', 'muhsina', 1, '2025-09-08 11:35:08', 'muhsina', 0, '2025-09-08 17:35:08', NULL, NULL, NULL),
(48, 'After adding task showing in at the top', 3, 1, 1, '2025-09-08 11:37:31', 'muhsina', 1, '2025-09-08 11:37:31', 'muhsina', 0, '2025-09-08 17:37:31', NULL, NULL, NULL),
(49, 'need to test from QA Side', 1, 1, 1, '2025-09-08 12:08:24', 'muhsina', 1, '2025-09-08 12:08:24', 'muhsina', 0, '2025-09-08 18:08:24', NULL, NULL, NULL),
(50, 'need to add project name, company name or project host name', 1, 1, 1, '2025-09-12 14:59:45', 'muhsina', 1, '2025-09-12 14:59:45', 'muhsina', 0, '2025-09-12 20:59:45', NULL, NULL, NULL),
(51, 'need to add calender for english, bangla and arabic', 1, 1, 1, '2025-09-12 15:02:29', 'muhsina', 1, '2025-09-12 15:02:29', 'muhsina', 0, '2025-09-12 21:02:29', NULL, NULL, NULL),
(52, 'Calaned is showing in three language', 1, 1, 1, '2025-09-12 15:50:59', 'muhsina', 1, '2025-09-12 15:50:59', 'muhsina', 0, '2025-09-12 21:50:59', NULL, NULL, NULL),
(53, 'currently showing current date in three language. It\'s a test', 1, 1, 1, '2025-09-12 19:06:27', 'muhsina', 1, '2025-09-12 19:07:17', 'muhsina', 0, '2025-09-13 01:06:27', NULL, NULL, NULL),
(54, 'It\'s a test only', 4, 1, 1, '2025-09-12 19:07:56', 'muhsina', 1, '2025-09-12 19:07:56', 'muhsina', 3, '2025-09-13 02:35:01', 'muhsina', NULL, NULL),
(55, 'Need to show modal onclicking the calender date picder', 2, 1, 1, '2025-09-12 19:32:58', 'muhsina', 1, '2025-09-12 19:32:58', 'muhsina', 0, '2025-09-13 01:32:58', NULL, NULL, NULL),
(56, 'Calender is showing in modal', 2, 1, 1, '2025-09-12 19:59:25', 'muhsina', 1, '2025-09-12 19:59:25', 'muhsina', 0, '2025-09-13 01:59:25', NULL, NULL, NULL),
(57, 'need to test from QA Side', 3, 1, 1, '2025-09-12 20:33:19', 'muhsina', 1, '2025-09-12 20:33:19', 'muhsina', 0, '2025-09-13 02:33:19', NULL, NULL, NULL),
(58, 'need to add project with dynamcally', 5, 1, 1, '2025-09-12 20:33:47', 'muhsina', 1, '2025-09-12 20:33:47', 'muhsina', 0, '2025-09-13 02:33:47', NULL, NULL, NULL),
(59, 'need to add user details', 5, 1, 1, '2025-09-12 20:34:07', 'muhsina', 1, '2025-09-12 20:34:07', 'muhsina', 0, '2025-09-13 02:34:07', NULL, NULL, NULL),
(60, 'need to add calender for three language (arabic, enlish and bangla )', 5, 1, 1, '2025-09-12 20:34:47', 'muhsina', 1, '2025-09-12 20:34:47', 'muhsina', 0, '2025-09-13 02:34:47', NULL, NULL, NULL),
(61, 'It\'s a test', 3, 1, 1, '2025-09-12 20:35:13', 'muhsina', 1, '2025-09-12 20:35:13', 'muhsina', 0, '2025-09-13 02:35:13', NULL, NULL, NULL),
(62, 'To set drawer image for task managment', 4, 1, 1, '2025-09-13 08:44:22', 'muhsina', 1, '2025-09-13 08:44:22', 'muhsina', 0, '2025-09-13 14:44:22', NULL, NULL, NULL),
(63, 'today task', 1, 1, 1, '2025-09-13 08:50:56', 'muhsina', 1, '2025-09-13 08:50:56', 'muhsina', 0, '2025-09-13 14:50:56', NULL, NULL, NULL);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_task_board`
--
ALTER TABLE `tbl_task_board`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_task_name`
--
ALTER TABLE `tbl_task_name`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

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
