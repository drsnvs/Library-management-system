-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2024 at 08:02 AM
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
-- Database: `liabrarymanagenentsystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `book_fine_table`
--

CREATE TABLE `book_fine_table` (
  `fine_id` int(4) NOT NULL,
  `rent_id` int(4) NOT NULL,
  `id` int(4) NOT NULL,
  `fine_amount` double NOT NULL,
  `paid` tinyint(4) NOT NULL,
  `active` int(1) NOT NULL,
  `createdBy` int(4) NOT NULL,
  `createdOn` date NOT NULL,
  `modifiedBy` int(11) DEFAULT NULL,
  `modifiedOn` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_fine_table`
--

INSERT INTO `book_fine_table` (`fine_id`, `rent_id`, `id`, `fine_amount`, `paid`, `active`, `createdBy`, `createdOn`, `modifiedBy`, `modifiedOn`) VALUES
(1, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(2, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(3, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(4, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(5, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(6, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(7, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(8, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(9, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(10, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(11, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(12, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(13, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(14, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(15, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(16, 8, 2, 160, 1, 1, 1, '2024-09-30', 2, '2024-10-02'),
(17, 8, 2, 180, 1, 1, 1, '2024-10-02', 2, '2024-10-02'),
(18, 8, 2, 180, 1, 1, 1, '2024-10-02', 2, '2024-10-02'),
(19, 8, 2, 180, 1, 1, 1, '2024-10-02', 2, '2024-10-02'),
(20, 8, 2, 180, 1, 1, 1, '2024-10-02', 2, '2024-10-02'),
(21, 8, 2, 180, 1, 1, 1, '2024-10-02', 2, '2024-10-02'),
(22, 8, 2, 180, 1, 1, 1, '2024-10-02', 2, '2024-10-02'),
(23, 8, 2, 180, 1, 1, 1, '2024-10-02', 2, '2024-10-02'),
(24, 8, 2, 180, 1, 1, 1, '2024-10-02', 2, '2024-10-02'),
(25, 10, 2, 40, 1, 1, 1, '2024-10-02', 2, '2024-10-02'),
(26, 10, 2, 40, 0, 1, 1, '2024-10-02', NULL, NULL),
(27, 12, 2, 160, 1, 1, 1, '2024-10-02', 2, '2024-10-02'),
(28, 16, 2, 470, 1, 0, 1, '2024-10-02', 2, '2024-10-02'),
(29, 17, 2, 780, 1, 0, 1, '2024-10-02', 2, '2024-10-02'),
(30, 18, 2, 470, 1, 0, 1, '2024-10-02', 2, '2024-10-02'),
(31, 19, 3, 160, 1, 0, 1, '2024-10-03', 3, '2024-10-03'),
(32, 20, 6, 470, 1, 0, 1, '2024-10-03', 6, '2024-10-03'),
(33, 20, 6, 470, 1, 0, 1, '2024-10-03', 6, '2024-10-03'),
(34, 32, 1, 190, 1, 0, 1, '2024-11-12', 1, '2024-11-12'),
(35, 33, 1, 170, 1, 0, 1, '2024-11-12', 1, '2024-11-12'),
(36, 34, 1, 170, 1, 0, 1, '2024-11-12', 1, '2024-11-12'),
(37, 36, 1, 170, 1, 0, 1, '2024-11-12', 1, '2024-11-12'),
(38, 36, 1, 170, 1, 0, 1, '2024-11-12', 1, '2024-11-12'),
(39, 38, 1, 170, 1, 0, 1, '2024-11-12', 1, '2024-11-12'),
(40, 39, 1, 170, 1, 0, 1, '2024-11-12', 1, '2024-11-12'),
(41, 41, 1, 2910, 1, 0, 1, '2024-11-12', 1, '2024-11-12'),
(42, 42, 1, 470, 1, 0, 1, '2024-11-17', 1, '2024-11-17'),
(43, 43, 1, 480, 1, 0, 1, '2024-11-18', 1, '2024-11-18'),
(44, 44, 4, 160, 1, 0, 1, '2024-11-18', 4, '2024-11-18');

-- --------------------------------------------------------

--
-- Table structure for table `book_rent_table`
--

CREATE TABLE `book_rent_table` (
  `rent_id` int(4) NOT NULL,
  `book_id` int(4) NOT NULL,
  `id` int(4) NOT NULL,
  `date_out` date NOT NULL,
  `date_due` date NOT NULL,
  `return_date` date DEFAULT NULL,
  `allocated_book` int(11) DEFAULT NULL,
  `active` int(1) NOT NULL,
  `createdBy` int(4) NOT NULL,
  `createdOn` date NOT NULL,
  `modifiedBy` int(4) DEFAULT NULL,
  `modifiedOn` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_rent_table`
--

INSERT INTO `book_rent_table` (`rent_id`, `book_id`, `id`, `date_out`, `date_due`, `return_date`, `allocated_book`, `active`, `createdBy`, `createdOn`, `modifiedBy`, `modifiedOn`) VALUES
(1, 2, 2, '2024-09-28', '2024-10-12', '2024-09-28', 0, 1, 1, '2024-09-28', NULL, NULL),
(2, 3, 2, '2024-09-28', '2024-10-12', '2024-09-28', 0, 1, 1, '2024-09-28', NULL, NULL),
(3, 2, 2, '2024-09-28', '2024-10-12', '2024-09-28', 0, 1, 2, '2024-09-28', NULL, NULL),
(4, 2, 2, '2024-09-08', '2024-10-12', '2024-09-28', 0, 1, 1, '2024-09-28', 1, '2024-09-28'),
(5, 1, 2, '2024-09-28', '2024-10-12', '2024-09-30', 0, 1, 1, '2024-09-28', NULL, NULL),
(6, 2, 2, '2024-09-10', '2024-10-14', '2024-09-30', 0, 1, 1, '2024-09-30', 1, '2024-09-30'),
(7, 4, 2, '2024-09-10', '2024-10-14', '2024-09-30', 0, 1, 1, '2024-09-30', 1, '2024-09-30'),
(8, 2, 2, '2024-09-30', '2024-09-14', '2024-10-02', 0, 1, 1, '2024-09-30', 1, '2024-09-30'),
(9, 1, 2, '2024-10-02', '2024-10-16', '2024-10-02', 0, 1, 1, '2024-10-02', NULL, NULL),
(10, 1, 2, '2024-09-14', '2024-09-28', '2024-10-02', 0, 1, 1, '2024-10-02', 1, '2024-10-02'),
(11, 1, 2, '2024-09-02', '2024-09-16', '2024-10-02', 0, 1, 1, '2024-10-02', 1, '2024-10-02'),
(12, 1, 2, '2024-09-02', '2024-09-16', '2024-10-02', 0, 1, 1, '2024-10-02', 1, '2024-10-02'),
(13, 1, 2, '2024-10-02', '2024-10-16', '2024-10-02', 0, 1, 1, '2024-10-02', NULL, NULL),
(14, 2, 2, '2024-10-02', '2024-10-16', '2024-10-02', 0, 1, 1, '2024-10-02', NULL, NULL),
(15, 1, 2, '2024-10-02', '2024-10-16', '2024-10-02', 0, 1, 1, '2024-10-02', NULL, NULL),
(16, 1, 2, '2024-08-02', '2024-08-16', '2024-10-02', 0, 1, 1, '2024-10-02', 1, '2024-10-02'),
(17, 1, 2, '2024-07-02', '2024-07-16', '2024-10-02', 0, 1, 1, '2024-10-02', 1, '2024-10-02'),
(18, 2, 2, '2024-08-02', '2024-08-16', '2024-10-02', 0, 1, 1, '2024-10-02', 1, '2024-10-02'),
(19, 4, 3, '2024-09-03', '2024-09-17', '2024-10-03', 0, 1, 1, '2024-10-03', 1, '2024-10-03'),
(20, 6, 6, '2024-08-03', '2024-08-17', '2024-10-03', 0, 1, 1, '2024-10-03', 1, '2024-10-03'),
(21, 1, 8, '2024-10-09', '2024-10-23', '2024-10-09', 0, 1, 1, '2024-10-09', NULL, NULL),
(22, 7, 3, '2024-10-09', '2024-10-23', '2024-10-09', 0, 1, 1, '2024-10-09', NULL, NULL),
(23, 6, 1, '2024-10-09', '2024-10-23', '2024-10-09', 0, 1, 1, '2024-10-09', NULL, NULL),
(24, 10, 1, '2024-10-09', '2024-10-23', '2024-10-09', 0, 1, 1, '2024-10-09', NULL, NULL),
(25, 1, 1, '2024-10-09', '2024-10-23', '2024-10-09', 0, 1, 1, '2024-10-09', NULL, NULL),
(26, 11, 1, '2024-10-09', '2024-10-23', '2024-10-09', 0, 1, 1, '2024-10-09', NULL, NULL),
(27, 10, 1, '2024-10-09', '2024-10-23', '2024-10-09', 0, 1, 1, '2024-10-09', NULL, NULL),
(28, 12, 1, '2024-10-09', '2024-10-23', '2024-10-09', 0, 1, 1, '2024-10-09', NULL, NULL),
(29, 8, 1, '2024-10-09', '2024-10-23', '2024-10-09', 0, 1, 1, '2024-10-09', NULL, NULL),
(30, 7, 6, '2024-10-10', '2024-10-24', '2024-10-10', 0, 1, 1, '2024-10-10', NULL, NULL),
(31, 10, 1, '2024-10-10', '2024-10-24', '2024-10-10', 0, 1, 1, '2024-10-10', NULL, NULL),
(32, 8, 1, '2024-10-10', '2024-10-24', '2024-11-12', 0, 1, 1, '2024-10-10', NULL, NULL),
(33, 6, 1, '2024-10-12', '2024-10-26', '2024-11-12', 0, 1, 1, '2024-11-12', 1, '2024-11-12'),
(34, 9, 1, '2024-10-12', '2024-10-26', '2024-11-12', 0, 1, 1, '2024-11-12', 1, '2024-11-12'),
(35, 15, 1, '2024-11-12', '2024-11-26', '2024-11-12', 0, 1, 1, '2024-11-12', NULL, NULL),
(36, 1, 1, '2024-10-12', '2024-10-26', '2024-11-12', 0, 1, 1, '2024-11-12', 1, '2024-11-12'),
(37, 11, 1, '2024-11-12', '2024-11-26', '2024-11-12', 0, 1, 1, '2024-11-12', NULL, NULL),
(38, 7, 1, '2024-10-12', '2024-10-26', '2024-11-12', 0, 1, 1, '2024-11-12', 1, '2024-11-12'),
(39, 11, 1, '2024-10-12', '2024-10-26', '2024-11-12', 0, 1, 1, '2024-11-12', 1, '2024-11-12'),
(40, 12, 1, '2024-11-12', '2024-11-26', '2024-11-12', 0, 1, 1, '2024-11-12', NULL, NULL),
(41, 8, 1, '2024-01-12', '2024-01-26', '2024-11-12', 0, 1, 1, '2024-11-12', 1, '2024-11-12'),
(42, 11, 1, '2024-10-17', '2024-10-01', '2024-11-17', 0, 1, 1, '2024-11-17', 1, '2024-11-17'),
(43, 8, 1, '2024-10-17', '2024-10-01', '2024-11-18', 0, 1, 1, '2024-11-17', 1, '2024-11-18'),
(44, 7, 4, '2024-10-18', '2024-11-02', '2024-11-18', 0, 1, 1, '2024-11-18', 1, '2024-11-18'),
(45, 6, 1, '2024-11-18', '2024-12-02', '2024-11-18', 0, 1, 1, '2024-11-18', NULL, NULL),
(46, 7, 4, '2024-11-18', '2024-12-02', '2024-11-18', 0, 1, 1, '2024-11-18', NULL, NULL),
(47, 9, 3, '2024-11-18', '2024-12-02', '2024-11-18', 0, 1, 1, '2024-11-18', NULL, NULL),
(48, 11, 4, '2024-11-18', '2024-12-02', '2024-11-18', 0, 1, 1, '2024-11-18', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `book_table`
--

CREATE TABLE `book_table` (
  `book_id` int(4) NOT NULL,
  `book_title` varchar(45) NOT NULL,
  `author_name` varchar(45) NOT NULL,
  `price` double NOT NULL,
  `quantity` int(4) NOT NULL,
  `ISBN` varchar(13) NOT NULL,
  `publisher` varchar(45) NOT NULL,
  `edition_year` int(4) NOT NULL,
  `language` int(11) NOT NULL,
  `pages` int(11) DEFAULT NULL,
  `format` int(11) DEFAULT NULL,
  `active` int(1) NOT NULL,
  `createdBy` int(4) NOT NULL,
  `createdOn` date NOT NULL,
  `modifiedBy` int(4) DEFAULT NULL,
  `modifiedOn` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_table`
--

INSERT INTO `book_table` (`book_id`, `book_title`, `author_name`, `price`, `quantity`, `ISBN`, `publisher`, `edition_year`, `language`, `pages`, `format`, `active`, `createdBy`, `createdOn`, `modifiedBy`, `modifiedOn`) VALUES
(1, 'Avenger', 'Richard Js Jameson', 1200, 1, '7894561231023', 'Marvel', 2001, 4, 20, 2, 1, 1, '2024-09-08', 1, '2024-09-28'),
(2, 'Thor', 'Richard J Jameson', 1200, 1, '1234567891022', 'Marvel', 2021, 5, 250, 2, 1, 1, '2024-09-09', 1, '2024-09-28'),
(3, 'Hulk', 'Richard J Jameson', 1350, 1, '1234567891023', 'Marvel', 2022, 3, 100, 2, 1, 1, '2024-09-09', 1, '2024-09-28'),
(4, 'Krishna', 'Dayaram', 2100, 1, '7894561231027', 'IOS', 2020, 3, 256, 2, 1, 1, '2024-09-28', 1, '2024-09-28'),
(5, 'Pragmatic Programmer	', 'Andrew Hunt	', 520, 1, '9780201616224', 'Addison-Wesley	', 1999, 1, 352, 2, 1, 1, '2024-09-28', 1, '2024-10-09'),
(6, 'Clean Code	', 'Robert C. Martin	', 450, 1, '9780132350884', 'Prentice Hall	', 2008, 1, 464, 2, 1, 1, '2024-09-28', 1, '2024-10-09'),
(7, 'Algorithm intro', 'Thomas H. Cormen	', 900, 1, '9780262033848', 'MIT Press	', 2009, 1, 1312, 2, 1, 1, '2024-09-28', 1, '2024-10-09'),
(8, 'Kill a Mockingbird', 'Harper Lee', 159, 1, '9780061120084', 'J.B. Lippincott & Co.', 1960, 1, 281, 2, 1, 1, '2024-10-02', 1, '2024-10-10'),
(9, 'The Great Gatsby', 'F. Scott Fitzgerald', 125, 1, '9780743273565', 'Charles Scribner\'s Sons', 1925, 1, 218, 2, 1, 1, '2024-10-02', NULL, NULL),
(10, '1984', 'George Orwell', 1212, 1, '9780451524935', 'Secker and Warburg', 1949, 1, 328, 2, 1, 1, '2024-10-02', NULL, NULL),
(11, 'Pride and Prejudice', 'Jane Austen', 157, 1, '9780486280511', 'T. Egerton', 1813, 1, 384, 2, 1, 1, '2024-10-02', NULL, NULL),
(12, 'Catcher in Rye', 'J.D. Salinger', 520, 1, '9780316769174', 'Little, Brown and Company', 1951, 1, 157, 2, 1, 1, '2024-10-02', 1, '2024-10-09'),
(13, 'The Lord of the Rings', 'J.R.R. Tolkien', 125, 1, '9780618260589', 'Allen & Unwin', 1954, 1, 1216, 2, 1, 1, '2024-10-02', NULL, NULL),
(14, 'The Hunger Games', 'Suzanne Collins', 1299, 1, '9780439023528', 'Scholastic Press', 2008, 1, 384, 2, 1, 1, '2024-10-02', NULL, NULL),
(15, 'Wuthering Heights', 'Emily BrontÃ«', 2100, 1, '9780486280512', 'Thomas Cautley Newby', 1847, 1, 231, 2, 1, 1, '2024-10-02', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `data_table`
--

CREATE TABLE `data_table` (
  `id` int(4) NOT NULL,
  `role_id` int(4) NOT NULL,
  `email_id` varchar(255) NOT NULL,
  `password` varchar(45) NOT NULL,
  `mobile_no` varchar(15) DEFAULT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `address` varchar(255) NOT NULL,
  `allocated_book` int(3) NOT NULL,
  `enrollment_no` int(11) NOT NULL,
  `active` int(1) NOT NULL,
  `createdBy` int(4) NOT NULL,
  `createdOn` date NOT NULL,
  `modifiedBy` int(4) DEFAULT NULL,
  `modifiedOn` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `data_table`
--

INSERT INTO `data_table` (`id`, `role_id`, `email_id`, `password`, `mobile_no`, `first_name`, `last_name`, `address`, `allocated_book`, `enrollment_no`, `active`, `createdBy`, `createdOn`, `modifiedBy`, `modifiedOn`) VALUES
(1, 1, '212308014.gvp@gujaratvidyapith.org', '12345678', '9824312924', 'Darshan', 'Sarvaiya', 'Odhav', 0, 212308014, 1, 1, '0000-00-00', 1, '2024-09-28'),
(2, 2, '212308026.gvp@gujaratvidyapith.org', 'mahir@2003', '9316709014', 'Mahir', 'Makwana', 'Chandkheda', 0, 212308026, 1, 1, '2024-09-06', NULL, NULL),
(3, 2, '212308037.gvp@gujaratvidyapith.org', '12345678', '9408731865', 'Vikas', 'Parmar', 'Chandkheda', 0, 212308037, 1, 1, '2024-09-06', NULL, NULL),
(4, 2, '212308016.gvp@gujaratvidyapith.org', 'Drashti@1', '7894561230', 'Drashti', 'Gosai', 'Bhavnagar', 0, 212308016, 1, 1, '2024-09-28', NULL, NULL),
(6, 2, '212308045.gvp@gujaratvidyapith.org', '12345678', '7894561230', 'Smit', 'Thakar', 'Nikol', 0, 212308045, 1, 1, '2024-09-30', 1, '2024-09-30'),
(7, 2, '212308039.gvp@gujaratvidyapith.org', '12345678', '7894561230', 'Vaidik', 'Limbachiya', 'Ranip', 0, 212308039, 1, 1, '2024-10-02', NULL, NULL),
(8, 2, '212308043.gvp@gujaratvidyapith.org', '12345678', '7845963210', 'Sahil', 'Lalani', 'Ahmedabad', 0, 212308043, 1, 1, '2024-10-02', NULL, NULL),
(9, 2, '212308015.gvp@gujaratvidyapith.org', '12345678', '7410258963', 'Drashti', 'Pithava', 'Ahmedabad', 0, 212308015, 1, 1, '2024-10-02', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `format_table`
--

CREATE TABLE `format_table` (
  `format_id` int(11) NOT NULL,
  `format_name` varchar(30) NOT NULL,
  `createdOn` date DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updatedOn` date DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `format_table`
--

INSERT INTO `format_table` (`format_id`, `format_name`, `createdOn`, `createdBy`, `updatedOn`, `updatedBy`) VALUES
(1, 'Video', '2024-09-28', 1, '2024-09-28', 1),
(2, 'Text', '2024-09-28', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `language_table`
--

CREATE TABLE `language_table` (
  `language_id` int(11) NOT NULL,
  `language_name` varchar(30) NOT NULL,
  `createdOn` date DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `updatedOn` date DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `language_table`
--

INSERT INTO `language_table` (`language_id`, `language_name`, `createdOn`, `createdBy`, `updatedOn`, `updatedBy`) VALUES
(1, 'English', '2024-09-07', 1, NULL, NULL),
(3, 'Gujarati', '2024-09-08', 1, NULL, NULL),
(4, 'Spanish', '2024-09-08', 1, NULL, NULL),
(5, 'Dutch', '2024-09-08', 1, NULL, NULL),
(6, 'Arabic', '2024-09-08', 1, NULL, NULL),
(7, 'French', '2024-09-08', 1, '2024-09-08', 1);

-- --------------------------------------------------------

--
-- Table structure for table `record_table`
--

CREATE TABLE `record_table` (
  `record_id` int(4) NOT NULL,
  `book_id` int(4) NOT NULL,
  `fine_id` int(4) DEFAULT NULL,
  `id` int(4) NOT NULL,
  `date_out` date NOT NULL,
  `date_due` date NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` date NOT NULL,
  `modifiedBy` int(11) DEFAULT NULL,
  `modifiedOn` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `record_table`
--

INSERT INTO `record_table` (`record_id`, `book_id`, `fine_id`, `id`, `date_out`, `date_due`, `createdBy`, `createdOn`, `modifiedBy`, `modifiedOn`) VALUES
(1, 2, NULL, 2, '2024-09-28', '2024-10-12', 1, '2024-09-28', NULL, NULL),
(2, 3, NULL, 2, '2024-09-28', '2024-10-12', 1, '2024-09-28', NULL, NULL),
(3, 2, NULL, 2, '2024-09-28', '2024-10-12', 2, '2024-09-28', NULL, NULL),
(4, 2, NULL, 2, '2024-09-28', '2024-10-12', 1, '2024-09-28', NULL, NULL),
(5, 1, NULL, 2, '2024-09-28', '2024-10-12', 1, '2024-09-28', NULL, NULL),
(6, 2, NULL, 2, '2024-09-30', '2024-10-14', 1, '2024-09-30', NULL, NULL),
(7, 4, NULL, 2, '2024-09-30', '2024-10-14', 1, '2024-09-30', NULL, NULL),
(8, 2, NULL, 2, '2024-09-30', '2024-10-14', 1, '2024-09-30', NULL, NULL),
(9, 1, NULL, 2, '2024-10-02', '2024-10-16', 1, '2024-10-02', NULL, NULL),
(10, 1, NULL, 2, '2024-10-02', '2024-10-16', 1, '2024-10-02', NULL, NULL),
(11, 1, NULL, 2, '2024-10-02', '2024-10-16', 1, '2024-10-02', NULL, NULL),
(12, 1, NULL, 2, '2024-10-02', '2024-10-16', 1, '2024-10-02', NULL, NULL),
(13, 1, NULL, 2, '2024-10-02', '2024-10-16', 1, '2024-10-02', NULL, NULL),
(14, 2, NULL, 2, '2024-10-02', '2024-10-16', 1, '2024-10-02', NULL, NULL),
(15, 1, NULL, 2, '2024-10-02', '2024-10-16', 1, '2024-10-02', NULL, NULL),
(16, 1, NULL, 2, '2024-10-02', '2024-10-16', 1, '2024-10-02', NULL, NULL),
(17, 1, NULL, 2, '2024-10-02', '2024-10-16', 1, '2024-10-02', NULL, NULL),
(18, 2, NULL, 2, '2024-10-02', '2024-10-16', 1, '2024-10-02', NULL, NULL),
(19, 4, NULL, 3, '2024-10-03', '2024-10-17', 1, '2024-10-03', NULL, NULL),
(20, 6, NULL, 6, '2024-10-03', '2024-10-17', 1, '2024-10-03', NULL, NULL),
(21, 1, NULL, 8, '2024-10-09', '2024-10-23', 1, '2024-10-09', NULL, NULL),
(22, 7, NULL, 3, '2024-10-09', '2024-10-23', 1, '2024-10-09', NULL, NULL),
(23, 6, NULL, 1, '2024-10-09', '2024-10-23', 1, '2024-10-09', NULL, NULL),
(24, 10, NULL, 1, '2024-10-09', '2024-10-23', 1, '2024-10-09', NULL, NULL),
(25, 1, NULL, 1, '2024-10-09', '2024-10-23', 1, '2024-10-09', NULL, NULL),
(26, 11, NULL, 1, '2024-10-09', '2024-10-23', 1, '2024-10-09', NULL, NULL),
(27, 10, NULL, 1, '2024-10-09', '2024-10-23', 1, '2024-10-09', NULL, NULL),
(28, 12, NULL, 1, '2024-10-09', '2024-10-23', 1, '2024-10-09', NULL, NULL),
(29, 8, NULL, 1, '2024-10-09', '2024-10-23', 1, '2024-10-09', NULL, NULL),
(30, 7, NULL, 6, '2024-10-10', '2024-10-24', 1, '2024-10-10', NULL, NULL),
(31, 10, NULL, 1, '2024-10-10', '2024-10-24', 1, '2024-10-10', NULL, NULL),
(32, 8, NULL, 1, '2024-10-10', '2024-10-24', 1, '2024-10-10', NULL, NULL),
(33, 6, NULL, 1, '2024-11-12', '2024-11-26', 1, '2024-11-12', NULL, NULL),
(34, 9, NULL, 1, '2024-11-12', '2024-11-26', 1, '2024-11-12', NULL, NULL),
(35, 15, NULL, 1, '2024-11-12', '2024-11-26', 1, '2024-11-12', NULL, NULL),
(36, 1, NULL, 1, '2024-11-12', '2024-11-26', 1, '2024-11-12', NULL, NULL),
(37, 11, NULL, 1, '2024-11-12', '2024-11-26', 1, '2024-11-12', NULL, NULL),
(38, 7, NULL, 1, '2024-11-12', '2024-11-26', 1, '2024-11-12', NULL, NULL),
(39, 11, NULL, 1, '2024-11-12', '2024-11-26', 1, '2024-11-12', NULL, NULL),
(40, 12, NULL, 1, '2024-11-12', '2024-11-26', 1, '2024-11-12', NULL, NULL),
(41, 8, NULL, 1, '2024-11-12', '2024-11-26', 1, '2024-11-12', NULL, NULL),
(42, 11, NULL, 1, '2024-11-17', '2024-12-01', 1, '2024-11-17', NULL, NULL),
(43, 8, NULL, 1, '2024-11-17', '2024-12-01', 1, '2024-11-17', NULL, NULL),
(44, 7, NULL, 4, '2024-11-18', '2024-12-02', 1, '2024-11-18', NULL, NULL),
(45, 6, NULL, 1, '2024-11-18', '2024-12-02', 1, '2024-11-18', NULL, NULL),
(46, 7, NULL, 4, '2024-11-18', '2024-12-02', 1, '2024-11-18', NULL, NULL),
(47, 9, NULL, 3, '2024-11-18', '2024-12-02', 1, '2024-11-18', NULL, NULL),
(48, 11, NULL, 4, '2024-11-18', '2024-12-02', 1, '2024-11-18', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_table`
--

CREATE TABLE `role_table` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_table`
--

INSERT INTO `role_table` (`role_id`, `role_name`) VALUES
(1, 'admin'),
(2, 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book_fine_table`
--
ALTER TABLE `book_fine_table`
  ADD PRIMARY KEY (`fine_id`);

--
-- Indexes for table `book_rent_table`
--
ALTER TABLE `book_rent_table`
  ADD PRIMARY KEY (`rent_id`);

--
-- Indexes for table `book_table`
--
ALTER TABLE `book_table`
  ADD PRIMARY KEY (`book_id`),
  ADD UNIQUE KEY `ISBN_UNIQUE` (`ISBN`),
  ADD KEY `language_id` (`language`),
  ADD KEY `format_id` (`format`);

--
-- Indexes for table `data_table`
--
ALTER TABLE `data_table`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_id_UNIQUE` (`email_id`);

--
-- Indexes for table `format_table`
--
ALTER TABLE `format_table`
  ADD PRIMARY KEY (`format_id`);

--
-- Indexes for table `language_table`
--
ALTER TABLE `language_table`
  ADD PRIMARY KEY (`language_id`);

--
-- Indexes for table `record_table`
--
ALTER TABLE `record_table`
  ADD PRIMARY KEY (`record_id`);

--
-- Indexes for table `role_table`
--
ALTER TABLE `role_table`
  ADD PRIMARY KEY (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `book_fine_table`
--
ALTER TABLE `book_fine_table`
  MODIFY `fine_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `book_rent_table`
--
ALTER TABLE `book_rent_table`
  MODIFY `rent_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `book_table`
--
ALTER TABLE `book_table`
  MODIFY `book_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `data_table`
--
ALTER TABLE `data_table`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `format_table`
--
ALTER TABLE `format_table`
  MODIFY `format_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `language_table`
--
ALTER TABLE `language_table`
  MODIFY `language_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `record_table`
--
ALTER TABLE `record_table`
  MODIFY `record_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `role_table`
--
ALTER TABLE `role_table`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book_table`
--
ALTER TABLE `book_table`
  ADD CONSTRAINT `format_id` FOREIGN KEY (`format`) REFERENCES `format_table` (`format_id`),
  ADD CONSTRAINT `language_id` FOREIGN KEY (`language`) REFERENCES `language_table` (`language_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
