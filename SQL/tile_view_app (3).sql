-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 10, 2024 at 10:42 AM
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
-- Database: `tile_view_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_login`
--

CREATE TABLE `tbl_login` (
  `id` int(10) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `user_type` int(3) NOT NULL,
  `status` int(2) NOT NULL DEFAULT 1,
  `user` varchar(100) NOT NULL,
  `created_date` datetime NOT NULL,
  `edited_by` varchar(50) NOT NULL,
  `edited_date` datetime NOT NULL,
  `token` varchar(255) NOT NULL
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
  `id` int(10) NOT NULL,
  `single_item_id` int(10) NOT NULL,
  `arabic_name` varchar(100) NOT NULL,
  `english_meaning` varchar(100) NOT NULL,
  `name_of_allah_swt` varchar(70) NOT NULL,
  `bangoli_meaning` varchar(100) NOT NULL,
  `status` int(2) NOT NULL DEFAULT 1,
  `created_by` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `like_status` varchar(6) NOT NULL DEFAULT 'false'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
  `id` int(5) NOT NULL,
  `title` varchar(100) NOT NULL,
  `status` int(2) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_task_board`
--

INSERT INTO `tbl_task_board` (`id`, `title`, `status`, `created_at`, `created_by`) VALUES
(1, 'Open', 1, '2024-11-10 07:38:18', 'muhsina'),
(2, 'Inprogress', 1, '2024-11-10 07:38:40', 'muhsina'),
(3, 'QA', 1, '2024-11-10 07:38:50', 'muhsina'),
(4, 'Done', 1, '2024-11-10 07:39:01', 'muhsina');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_task_name`
--

CREATE TABLE `tbl_task_name` (
  `id` int(10) NOT NULL,
  `title` varchar(255) NOT NULL,
  `column_name` int(2) NOT NULL,
  `model_name` int(10) NOT NULL,
  `project_name` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(50) NOT NULL,
  `status` int(2) NOT NULL DEFAULT 1,
  `edited_at` datetime NOT NULL,
  `edited_by` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_task_name`
--

INSERT INTO `tbl_task_name` (`id`, `title`, `column_name`, `model_name`, `project_name`, `created_at`, `created_by`, `status`, `edited_at`, `edited_by`) VALUES
(1, 'Multiple TT Create at a time for ITM Module', 1, 1, 1, '2024-11-10 07:39:26', 'muhisna', 1, '0000-00-00 00:00:00', ''),
(2, '10.	Display a report showing the average time for TT to open and close, organized by date. Additionally, show the average time for the current month on the dashboard', 3, 1, 1, '2024-11-10 07:42:20', 'muhisna', 1, '0000-00-00 00:00:00', ''),
(3, '7.	Update employee information in the HRIS system, including: ○	Mobile number. ○	Email. ○	Designation', 4, 1, 1, '2024-11-10 07:44:26', 'muhisna', 1, '0000-00-00 00:00:00', ''),
(4, '8.	Add \"Device Requisition\" to the main menu on the left sidebar. Under this menu, include: ○	TT Requisition List. ○	Approval List.', 3, 1, 1, '2024-11-10 07:45:50', 'muhisna', 1, '0000-00-00 00:00:00', ''),
(5, '10.	Display a report showing the average time for TT to open and close, organized by date. Additionally, show the average time for the current month on the dashboard.', 2, 1, 1, '2024-11-10 07:46:14', 'muhisna', 1, '0000-00-00 00:00:00', ''),
(6, '1.	Implement an \"Approve\" button.', 3, 1, 1, '2024-11-10 07:49:14', 'muhisna', 1, '0000-00-00 00:00:00', ''),
(7, '2.	Add print functionality with two options: ○	Print All TT Summary. ○	Print TT Details.', 3, 1, 1, '2024-11-10 07:49:31', 'muhisna', 1, '0000-00-00 00:00:00', ''),
(8, 'Supply Chain with ITM Device Issue', 1, 1, 1, '2024-11-10 09:34:17', 'muhsina', 1, '0000-00-00 00:00:00', '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_title_subtitle`
--

CREATE TABLE `tbl_title_subtitle` (
  `id` int(11) NOT NULL,
  `title` varchar(80) NOT NULL,
  `subtitle` varchar(80) NOT NULL,
  `status` int(2) NOT NULL,
  `created_by` varchar(15) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` varchar(50) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
  `id` int(10) NOT NULL,
  `single_item_id` int(10) NOT NULL,
  `arabic_name` varchar(50) NOT NULL,
  `bangoli_name` varchar(50) NOT NULL,
  `day_count` varchar(50) NOT NULL,
  `english_name` varchar(50) NOT NULL,
  `status` int(2) NOT NULL DEFAULT 1,
  `created_by` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_name_of_allah_swt`
--
ALTER TABLE `tbl_name_of_allah_swt`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tbl_task_board`
--
ALTER TABLE `tbl_task_board`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_task_name`
--
ALTER TABLE `tbl_task_name`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_title_subtitle`
--
ALTER TABLE `tbl_title_subtitle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `tbl_weekly_name`
--
ALTER TABLE `tbl_weekly_name`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
