-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 27, 2025 at 09:10 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

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
-- Table structure for table `tbl_login`
--

CREATE TABLE `tbl_login` (
  `id` int NOT NULL,
  `user_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mobile` varchar(11) COLLATE utf8mb4_general_ci NOT NULL,
  `user_type` int NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `user` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `created_date` datetime NOT NULL,
  `edited_by` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `edited_date` datetime NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
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
-- Table structure for table `tbl_task_board`
--

CREATE TABLE `tbl_task_board` (
  `id` int NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(10) COLLATE utf8mb4_general_ci NOT NULL
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
(6, 'Modification Task', 1, '2024-12-03 06:49:30', 'muhsina'),
(7, 'New Requirement', 1, '2025-04-23 10:28:42', 'muhsina');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_task_name`
--

CREATE TABLE `tbl_task_name` (
  `id` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `column_name` int NOT NULL,
  `model_name` int NOT NULL,
  `project_name` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
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
(1, 'TT Info by\nQuery(tt_info_by_query) for MIS is not working for searching.', 1, 1, 1, '2024-11-10 07:39:26', 'muhisna', 1, '2025-04-24 12:06:53', 'muhsina', 5, '2025-04-23 14:48:40', 'muhsina', '', '2024-11-24 17:58:36'),
(2, 'Display a report showing the average time for TT to open and close, organized by date. Additionally, show the average time for the current month on the dashboard. ', 1, 1, 1, '2024-11-10 07:42:20', 'muhisna', 1, '2025-04-23 09:28:30', 'muhsina', 5, '2025-04-23 15:10:48', 'muhsina', '', '2024-11-24 17:58:36'),
(3, ' Update employee information in the HRIS system, including: ○	Mobile number. ○	Email. ○	Designation  and Destrict', 4, 1, 1, '2024-11-10 07:44:26', 'muhisna', 1, '2024-12-01 11:13:50', 'Muhsina', 1, '2024-11-18 10:56:06', 'muhsina', '', '2024-11-24 17:58:36'),
(4, 'Add \"Device Requisition\" to the main menu on the left sidebar. Under this menu, include: ○	TT Requisition List. ○	Approval List.', 4, 1, 1, '2024-11-10 07:45:50', 'muhisna', 1, '2024-11-19 07:01:17', '', 3, '0000-00-00 00:00:00', 'muhsina', 'muhsina', '2024-11-25 12:54:34'),
(5, 'Display a report showing the average time for TT to open and close, organized by date. Additionally, show the average time for the current month on the dashboard.', 4, 1, 1, '2024-11-10 07:46:14', 'muhisna', 1, '2024-11-19 07:01:17', '', 2, '2024-11-19 12:57:39', 'muhsina', 'muhsina', '2024-11-25 12:55:32'),
(6, 'Implement an \"Approve\" button.', 4, 1, 1, '2024-11-10 07:49:14', 'muhisna', 1, '2024-11-19 07:01:17', '', 3, '0000-00-00 00:00:00', 'muhsina', '', '2024-11-24 17:58:36'),
(7, 'Add print functionality with two options: ○	Print All TT Summary. ○	Print TT Details.', 4, 1, 1, '2024-11-10 07:49:31', 'muhisna', 1, '2024-11-19 07:01:17', '', 3, '0000-00-00 00:00:00', 'muhsina', '', '2024-11-24 17:58:36'),
(8, 'Supply Chain with ITM Device Issue', 2, 1, 1, '2024-11-10 09:34:17', 'muhsina', 0, '2024-11-19 07:01:17', '', 3, '2024-11-20 12:57:25', 'muhsina', 'muhsina', '2024-11-25 15:02:44'),
(9, 'test. It\'s a only Test Purpose', 4, 1, 1, '2024-11-11 07:02:20', 'muhsina', 1, '2024-12-02 06:51:13', 'Muhsina', 3, '0000-00-00 00:00:00', 'muhsina', 'muhsina', '2024-11-25 12:08:18'),
(10, 'To add access issue for IT Persons', 5, 1, 1, '2024-11-11 12:16:38', 'muhsina', 1, '2024-11-19 07:01:17', '', 3, '0000-00-00 00:00:00', 'muhsina', '', '2024-11-24 17:58:36'),
(11, 'Modification for Device Requisition', 3, 1, 1, '2024-11-14 06:25:18', 'muhsina', 1, '2024-11-19 07:01:17', '', 4, '2024-11-26 15:21:28', 'muhsina', '', '2024-11-24 17:58:36'),
(12, 'Need to add email in TT Edit View Page', 5, 1, 1, '2024-11-14 06:25:44', 'muhsina', 1, '2024-11-19 07:01:17', '', 4, '2024-11-20 12:50:31', 'muhsina', '', '2024-11-24 17:58:36'),
(13, 'To add device report under report menu', 3, 1, 1, '2024-11-14 06:28:43', 'muhsina', 1, '2024-11-19 07:01:17', '', 2, '2024-11-18 18:30:05', 'muhsina', 'muhsina', '2024-11-25 12:36:15'),
(14, 'TT Average Age in MIS', 5, 1, 1, '2024-11-14 07:02:50', 'muhsina', 1, '2024-11-19 07:01:17', '', 4, '2024-11-18 18:30:09', 'muhsina', '', '2024-11-24 17:58:36'),
(15, 'test. It\'s a test purpose.', 5, 1, 1, '2024-11-19 07:12:48', 'muhsina', 1, '2024-12-02 05:37:54', 'muhsina', 1, '2024-11-24 16:31:34', 'muhsina', 'muhsina', '2024-11-25 12:09:01'),
(16, 'PHP Mail Configuration', 5, 1, 1, '2024-11-19 08:39:38', 'muhsina', 1, '2024-11-19 08:39:38', 'muhsina', 1, '2024-11-24 16:31:04', 'muhsina', '', '2024-11-24 17:58:36'),
(17, 'Test Purpose Only and Check . It\'s a test purpose', 2, 1, 1, '2024-11-20 07:01:47', 'muhsina', 1, '2024-12-02 05:54:05', 'Muhsina', 0, '2024-11-20 13:01:47', NULL, 'muhsina', '2024-11-25 14:46:03'),
(18, 'test purpose only', 5, 1, 1, '2024-11-21 06:03:35', 'muhsina', 1, '2024-11-21 06:03:35', 'muhsina', 1, '2024-11-24 16:30:21', 'muhsina', 'muhsina', '2024-11-25 15:25:23'),
(19, ' Test Purpose and It\'s a test purpose', 2, 1, 1, '2024-11-24 10:29:30', 'muhsina', 1, '2024-12-01 12:26:41', 'Muhsina', 0, '2024-11-24 16:29:30', NULL, 'muhsina', '2024-11-25 14:43:47'),
(20, 'It\'s a tes purpose only. Need a feedback from ITM', 1, 1, 1, '2024-11-24 10:32:34', 'muhsina', 0, '2024-12-02 10:46:23', 'Muhsina', 5, '2024-11-24 16:38:19', 'muhsina', 'muhsina', '2024-12-02 16:48:56'),
(21, 'TEST Only. test. abc. need to update. Test page', 1, 1, 1, '2024-11-24 10:36:51', 'muhsina', 0, '2025-04-20 10:36:07', 'Muhsina', 5, '2024-11-24 16:38:05', 'muhsina', 'muhsina', '2025-04-21 14:29:20'),
(22, ' test Purpose only for test purpose_ It\'s a test purpose. It\'s a my first project for PMP', 1, 1, 1, '2024-11-25 05:09:35', 'muhsina', 0, '2025-04-22 05:23:55', 'muhsina', 0, '2024-11-25 11:09:35', NULL, 'muhsina', '2025-04-22 11:24:04'),
(23, ' QA Test and test purpose only and ABC. It\'s a test purpose', 2, 1, 1, '2024-11-25 05:10:24', 'muhsina', 1, '2024-12-10 09:41:29', 'Muhsina', 0, '2024-11-25 11:10:24', NULL, 'muhsina', '2024-11-25 13:04:45'),
(24, 'Pending Issue for Test Purpose', 5, 1, 1, '2024-11-25 05:15:09', 'muhsina', 1, '2024-12-01 12:32:22', 'Muhsina', 0, '2024-11-25 11:15:09', NULL, 'muhsina', '2024-11-25 14:53:03'),
(25, ' Need to Add ID with Name  abc . test. It\'s a test purpose. Need a feedback', 1, 1, 1, '2024-11-25 06:00:20', 'muhsina', 0, '2024-12-02 10:46:35', 'Muhsina', 0, '2024-11-25 12:00:20', NULL, 'muhsina', '2025-04-22 11:24:23'),
(26, 'Approval Requisition List', 1, 1, 1, '2024-11-25 06:43:55', 'muhsina', 0, '2024-11-25 06:43:55', 'muhsina', 0, '2024-11-25 12:43:55', NULL, 'muhsina', '2024-11-25 14:52:14'),
(27, 'lkh8u', 1, 1, 1, '2024-11-25 09:25:49', 'muhsina', 0, '2024-11-25 09:25:49', 'muhsina', 0, '2024-11-25 15:25:49', NULL, 'muhsina', '2024-11-25 15:49:20'),
(28, 'working on focus out for Editing  ancf  . test purpose and need a feedback from ITM', 2, 1, 1, '2024-11-25 09:27:30', 'muhsina', 1, '2024-12-02 09:41:03', 'Muhsina', 0, '2024-11-25 15:27:30', NULL, 'muhsina', '2024-11-25 15:43:02'),
(29, 'MIS Need to upload in ITM server. And a mail from IT Personnel. And Need a Feedback.', 5, 1, 1, '2024-12-02 05:39:57', 'muhsina', 1, '2024-12-02 05:49:08', 'Muhsina', 0, '2024-12-02 11:39:57', NULL, NULL, NULL),
(30, 'Multiple TT Create for Multiple User for Same Issue.', 5, 1, 1, '2024-12-03 04:57:45', 'muhsina', 1, '2024-12-03 05:05:51', 'Muhsina', 0, '2024-12-03 10:57:45', NULL, NULL, NULL),
(31, 'Core Finnance Showing', 6, 1, 1, '2024-12-03 06:50:09', 'muhsina', 1, '2024-12-03 06:50:09', 'muhsina', 0, '2024-12-03 12:50:09', NULL, NULL, NULL),
(32, 'Marketing Showing', 6, 1, 1, '2024-12-03 06:51:08', 'muhsina', 1, '2024-12-03 06:51:08', 'muhsina', 0, '2024-12-03 12:51:08', NULL, NULL, NULL),
(33, 'MD Office is showing', 6, 1, 1, '2024-12-03 06:51:38', 'muhsina', 1, '2024-12-03 06:51:38', 'muhsina', 0, '2024-12-03 12:51:38', NULL, NULL, NULL),
(34, 'Showing Revenue Asurance. test', 6, 1, 1, '2024-12-03 06:52:35', 'muhsina', 1, '2024-12-04 06:12:08', 'Muhsina', 0, '2024-12-03 12:52:35', NULL, NULL, NULL),
(35, 'Need to send email . to add email', 6, 1, 1, '2024-12-04 06:13:33', 'muhsina', 1, '2024-12-04 06:28:15', 'Muhsina', 0, '2024-12-04 12:13:33', NULL, NULL, NULL),
(36, 'To update login page', 4, 1, 1, '2025-04-16 05:47:26', 'muhsina', 1, '2025-04-16 05:47:26', 'muhsina', 1, '2025-04-20 11:03:07', 'muhsina', NULL, NULL),
(37, 'To add PR Approval and Pettery Cash Approval for Requisition Module', 1, 1, 1, '2025-04-20 05:00:44', 'muhsina', 0, '2025-04-20 05:00:44', 'muhsina', 0, '2025-04-20 11:00:44', NULL, 'muhsina', '2025-04-22 11:24:30'),
(38, 'Need to show Petty Cash Approved and PR Approved in home page and procure TT page and Device Requistion Page', 1, 1, 1, '2025-04-20 05:16:12', 'muhsina', 1, '2025-04-23 09:47:03', 'muhsina', 2, '2025-04-20 11:21:29', 'muhsina', NULL, NULL),
(39, 'Need to show all Page title names in the Header. test . It\'s a test puerpose', 1, 1, 1, '2025-04-20 05:22:33', 'muhsina', 0, '2025-04-20 07:05:10', 'Muhsina', 0, '2025-04-20 11:22:33', NULL, 'muhsina', '2025-04-22 17:59:59'),
(40, 'We need to change the left menu bar as per the discussion, I sent it\'s by screenshot', 3, 1, 1, '2025-04-20 05:22:55', 'muhsina', 1, '2025-04-20 05:22:55', 'muhsina', 0, '2025-04-20 11:22:55', NULL, NULL, NULL),
(41, 'All tickets with a \'Closed TT\' status will be updated to either \'Canceled\' or \'Delivered\'.', 6, 1, 1, '2025-04-23 09:34:55', 'muhsina', 1, '2025-04-23 09:34:55', 'muhsina', 0, '2025-04-23 15:34:55', NULL, NULL, NULL),
(42, 'The \'Closed\' TT status will be removed from the Procure TT page.', 6, 1, 1, '2025-04-23 09:36:17', 'muhsina', 1, '2025-04-23 09:36:17', 'muhsina', 0, '2025-04-23 15:36:17', NULL, NULL, NULL),
(43, 'Each search bar will display both the username and user ID for improved identification.', 6, 1, 1, '2025-04-23 09:36:39', 'muhsina', 1, '2025-04-23 09:36:39', 'muhsina', 0, '2025-04-23 15:36:39', NULL, NULL, NULL),
(44, 'The last assigned person for a device will be displayed on the Device Warranty Close page.', 6, 1, 1, '2025-04-23 09:36:58', 'muhsina', 1, '2025-04-23 09:36:58', 'muhsina', 0, '2025-04-23 15:36:58', NULL, NULL, NULL),
(45, 'The existing \'Create TT\' form will be replaced with a new form.', 6, 1, 1, '2025-04-23 09:37:16', 'muhsina', 1, '2025-04-23 09:37:16', 'muhsina', 0, '2025-04-23 15:37:16', NULL, NULL, NULL),
(46, 'The existing issue with the change password functionality will be fixed.', 6, 1, 1, '2025-04-23 09:37:33', 'muhsina', 1, '2025-04-23 09:37:33', 'muhsina', 0, '2025-04-23 15:37:33', NULL, NULL, NULL),
(47, '\'PR\' and \'Petty Cash\' will be included under the \'Approved\' status in the Requisition List page.', 6, 1, 1, '2025-04-23 09:37:45', 'muhsina', 1, '2025-04-23 09:37:45', 'muhsina', 0, '2025-04-23 15:37:45', NULL, NULL, NULL),
(48, 'The OS Key will be updated as required.', 5, 1, 1, '2025-04-23 09:38:02', 'muhsina', 1, '2025-04-23 09:38:02', 'muhsina', 0, '2025-04-23 15:38:02', NULL, NULL, NULL),
(49, 'The \'Warranty End Date\' field will be changed to a dropdown selection in all Equipment New Device Assign pages.', 5, 1, 1, '2025-04-23 09:38:12', 'muhsina', 1, '2025-04-23 09:38:12', 'muhsina', 0, '2025-04-23 15:38:12', NULL, NULL, NULL),
(50, 'We want to collect new device information from the SCM module by MR or PR number.', 5, 1, 1, '2025-04-23 09:38:23', 'muhsina', 1, '2025-04-23 09:38:23', 'muhsina', 0, '2025-04-23 15:38:23', NULL, NULL, NULL),
(51, 'Need to remove # from home page to generate the page link', 1, 1, 1, '2025-04-23 09:49:25', 'muhsina', 1, '2025-04-23 09:49:25', 'muhsina', 0, '2025-04-23 15:49:25', NULL, NULL, NULL),
(52, 'test', 1, 1, 1, '2025-04-23 09:54:52', 'muhsina', 0, '2025-04-23 09:54:52', 'muhsina', 1, '2025-04-23 15:54:52', NULL, 'muhsina', '2025-04-23 16:01:07'),
(53, 'abc', 1, 1, 1, '2025-04-23 09:57:27', 'muhsina', 0, '2025-04-23 09:59:27', 'muhsina', 0, '2025-04-23 15:57:27', NULL, 'muhsina', '2025-04-23 16:00:07'),
(54, 'The OS Key will be updated as required.', 7, 1, 1, '2025-04-23 10:29:05', 'muhsina', 1, '2025-04-23 10:29:05', 'muhsina', 0, '2025-04-23 16:29:05', NULL, NULL, NULL),
(55, 'The \'Warranty End Date\' field will be changed to a dropdown selection in all Equipment New Device Assign pages.', 7, 1, 1, '2025-04-23 10:29:14', 'muhsina', 1, '2025-04-23 10:29:14', 'muhsina', 0, '2025-04-23 16:29:14', NULL, NULL, NULL),
(56, 'We want to collect new device information from the SCM module by MR or PR number.', 7, 1, 1, '2025-04-23 10:30:29', 'muhsina', 1, '2025-04-23 10:30:29', 'muhsina', 0, '2025-04-23 16:30:29', NULL, NULL, NULL),
(57, 'Device Stack Module', 7, 1, 1, '2025-04-23 10:31:40', 'muhsina', 1, '2025-04-23 10:31:40', 'muhsina', 0, '2025-04-23 16:31:40', NULL, NULL, NULL),
(58, 'Test Purpose only', 7, 1, 1, '2025-04-23 10:32:47', 'muhsina', 0, '2025-04-23 10:32:47', 'muhsina', 0, '2025-04-23 16:32:47', NULL, 'muhsina', '2025-04-23 16:37:54'),
(59, 'test', 7, 1, 1, '2025-04-23 10:33:33', 'muhsina', 0, '2025-04-23 10:33:33', 'muhsina', 0, '2025-04-23 16:33:33', NULL, 'muhsina', '2025-04-23 16:36:26'),
(60, 'To Design Dashboard', 7, 1, 1, '2025-04-23 10:37:36', 'muhsina', 1, '2025-04-23 10:37:36', 'muhsina', 0, '2025-04-23 16:37:36', NULL, NULL, NULL),
(61, 'test abc. It\'s a test purpose. It is good practice', 1, 1, 1, '2025-04-23 10:44:47', 'muhsina', 0, '2025-04-23 12:16:50', 'muhsina', 0, '2025-04-23 16:44:47', NULL, 'muhsina', '2025-04-23 18:17:57'),
(62, 'It\'s a test purpose . It\'s is a test prupsoe .TEST Purpose', 1, 1, 1, '2025-04-24 11:58:11', 'muhsina', 0, '2025-04-27 06:56:03', 'muhsina', 0, '2025-04-24 17:58:11', NULL, 'muhsina', '2025-04-27 12:56:21'),
(63, 'Test Purpose', 1, 1, 1, '2025-04-27 08:40:41', 'muhsina', 1, '2025-04-27 08:40:41', 'muhsina', 0, '2025-04-27 14:40:41', NULL, NULL, NULL);

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
