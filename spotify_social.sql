-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 24, 2023 at 01:47 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17
CREATE DATABASE spotifySocial;

USE spotifySocial;


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spotify_social`
--

-- --------------------------------------------------------

--
-- Table structure for table `album`
--

CREATE TABLE `album` (
  `album_id` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `popularity` int(11) NOT NULL DEFAULT 0,
  `album_type` varchar(20) DEFAULT NULL,
  `total_tracks` int(11) NOT NULL DEFAULT 0,
  `release_date` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `album_by`
--

CREATE TABLE `album_by` (
  `album_id` varchar(255) NOT NULL,
  `artist_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `album_genre`
--

CREATE TABLE `album_genre` (
  `album_id` varchar(255) NOT NULL,
  `genre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `artist`
--

CREATE TABLE `artist` (
  `artist_id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `popularity` int(11) DEFAULT 0,
  `follower_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `artist_genre`
--

CREATE TABLE `artist_genre` (
  `artist_id` varchar(255) NOT NULL,
  `genre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `follows_artist`
--

CREATE TABLE `follows_artist` (
  `user_name` varchar(255) NOT NULL,
  `artist_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `follows_profile`
--

CREATE TABLE `follows_profile` (
  `user_name_follower` varchar(255) NOT NULL,
  `user_name_following` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `user_name` varchar(255) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `content` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `school_song_chart`
--

CREATE TABLE `school_song_chart` (
  `school_name` varchar(255) NOT NULL,
  `rank` int(11) NOT NULL,
  `song_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `song`
--

CREATE TABLE `song` (
  `song_id` varchar(255) NOT NULL,
  `duration_ms` int(11) DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `popularity` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `song_by`
--

CREATE TABLE `song_by` (
  `song_id` varchar(255) NOT NULL,
  `artist_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `upvote_album`
--

CREATE TABLE `upvote_album` (
  `user_name` varchar(255) NOT NULL,
  `album_id` varchar(255) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `upvote_post`
--

CREATE TABLE `upvote_post` (
  `upvoter` varchar(255) NOT NULL,
  `receiver` varchar(255) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `upvote_song`
--

CREATE TABLE `upvote_song` (
  `user_name` varchar(255) NOT NULL,
  `song_id` varchar(255) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_login`
--

CREATE TABLE `user_login` (
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_profile`
--

CREATE TABLE `user_profile` (
  `user_name` varchar(255) NOT NULL,
  `number_of_posts` int(11) DEFAULT 0,
  `school` varchar(255) DEFAULT NULL,
  `area_of_study` varchar(255) DEFAULT NULL,
  `computing_id` varchar(255) DEFAULT NULL,
  `bio` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `album`
--
ALTER TABLE `album`
  ADD PRIMARY KEY (`album_id`);

--
-- Indexes for table `album_by`
--
ALTER TABLE `album_by`
  ADD PRIMARY KEY (`album_id`,`artist_id`),
  ADD KEY `artist_id` (`artist_id`);

--
-- Indexes for table `album_genre`
--
ALTER TABLE `album_genre`
  ADD PRIMARY KEY (`album_id`,`genre`);

--
-- Indexes for table `artist`
--
ALTER TABLE `artist`
  ADD PRIMARY KEY (`artist_id`);

--
-- Indexes for table `artist_genre`
--
ALTER TABLE `artist_genre`
  ADD PRIMARY KEY (`artist_id`,`genre`);

--
-- Indexes for table `follows_artist`
--
ALTER TABLE `follows_artist`
  ADD PRIMARY KEY (`user_name`,`artist_id`),
  ADD KEY `artist_id` (`artist_id`);

--
-- Indexes for table `follows_profile`
--
ALTER TABLE `follows_profile`
  ADD PRIMARY KEY (`user_name_follower`,`user_name_following`),
  ADD KEY `user_name_following` (`user_name_following`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`user_name`,`date_time`);

--
-- Indexes for table `school_song_chart`
--
ALTER TABLE `school_song_chart`
  ADD PRIMARY KEY (`school_name`),
  ADD KEY `song_id` (`song_id`);

--
-- Indexes for table `song`
--
ALTER TABLE `song`
  ADD PRIMARY KEY (`song_id`);

--
-- Indexes for table `song_by`
--
ALTER TABLE `song_by`
  ADD PRIMARY KEY (`song_id`,`artist_id`),
  ADD KEY `artist_id` (`artist_id`);

--
-- Indexes for table `upvote_album`
--
ALTER TABLE `upvote_album`
  ADD PRIMARY KEY (`user_name`,`album_id`),
  ADD KEY `album_id` (`album_id`);

--
-- Indexes for table `upvote_post`
--
ALTER TABLE `upvote_post`
  ADD PRIMARY KEY (`upvoter`,`receiver`,`date_time`),
  ADD KEY `receiver` (`receiver`,`date_time`);

--
-- Indexes for table `upvote_song`
--
ALTER TABLE `upvote_song`
  ADD PRIMARY KEY (`user_name`,`song_id`),
  ADD KEY `song_id` (`song_id`);

--
-- Indexes for table `user_login`
--
ALTER TABLE `user_login`
  ADD PRIMARY KEY (`user_name`);

--
-- Indexes for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD PRIMARY KEY (`user_name`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `album_by`
--
ALTER TABLE `album_by`
  ADD CONSTRAINT `album_by_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`),
  ADD CONSTRAINT `album_by_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`);

--
-- Constraints for table `album_genre`
--
ALTER TABLE `album_genre`
  ADD CONSTRAINT `album_genre_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`);

--
-- Constraints for table `artist_genre`
--
ALTER TABLE `artist_genre`
  ADD CONSTRAINT `artist_genre_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`);

--
-- Constraints for table `follows_artist`
--
ALTER TABLE `follows_artist`
  ADD CONSTRAINT `follows_artist_ibfk_1` FOREIGN KEY (`user_name`) REFERENCES `user_profile` (`user_name`),
  ADD CONSTRAINT `follows_artist_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`);

--
-- Constraints for table `follows_profile`
--
ALTER TABLE `follows_profile`
  ADD CONSTRAINT `follows_profile_ibfk_1` FOREIGN KEY (`user_name_follower`) REFERENCES `user_profile` (`user_name`),
  ADD CONSTRAINT `follows_profile_ibfk_2` FOREIGN KEY (`user_name_following`) REFERENCES `user_profile` (`user_name`);

--
-- Constraints for table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `post_ibfk_1` FOREIGN KEY (`user_name`) REFERENCES `user_profile` (`user_name`);

--
-- Constraints for table `school_song_chart`
--
ALTER TABLE `school_song_chart`
  ADD CONSTRAINT `school_song_chart_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`);

--
-- Constraints for table `song_by`
--
ALTER TABLE `song_by`
  ADD CONSTRAINT `song_by_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`),
  ADD CONSTRAINT `song_by_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`);

--
-- Constraints for table `upvote_album`
--
ALTER TABLE `upvote_album`
  ADD CONSTRAINT `upvote_album_ibfk_1` FOREIGN KEY (`user_name`) REFERENCES `user_profile` (`user_name`),
  ADD CONSTRAINT `upvote_album_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`);

--
-- Constraints for table `upvote_post`
--
ALTER TABLE `upvote_post`
  ADD CONSTRAINT `upvote_post_ibfk_1` FOREIGN KEY (`upvoter`) REFERENCES `user_profile` (`user_name`),
  ADD CONSTRAINT `upvote_post_ibfk_2` FOREIGN KEY (`receiver`,`date_time`) REFERENCES `post` (`user_name`, `date_time`);

--
-- Constraints for table `upvote_song`
--
ALTER TABLE `upvote_song`
  ADD CONSTRAINT `upvote_song_ibfk_1` FOREIGN KEY (`user_name`) REFERENCES `user_profile` (`user_name`),
  ADD CONSTRAINT `upvote_song_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
