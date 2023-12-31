-- USE spotifySocial;

CREATE TABLE `artist` (
  `artist_id` varchar(255) NOT NULL,
  `artist_name` varchar(255) DEFAULT NULL,
   Primary key (artist_id)
);

CREATE TABLE `song` (
  `song_id` varchar(255) NOT NULL,
  `song_name` varchar(255) NOT NULL,
   Primary key (song_id)
);

CREATE TABLE `user_profile` (
  `user_name` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `full_name` varchar(255),
  `number_of_posts` int(11) DEFAULT 0,
  `school` varchar(255) DEFAULT NULL,
  `area_of_study` varchar(255) DEFAULT NULL,
  `computing_id` varchar(255) DEFAULT NULL,
  `bio` varchar(200) DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `date_of_birth` varchar(255) NOT NULL,
   CONSTRAINT checkPost CHECK (number_of_posts>=0),
   Primary key (user_name)
);

CREATE TABLE `album` (
  `album_id` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
   Primary key (album_id)
);

CREATE TABLE `follows_artist` (
    `user_name` varchar(255) NOT NULL,
    `artist_id` varchar(255) NOT NULL,
    Primary key (user_name, artist_id),
    CONSTRAINT `fk_follows_artist_user_profile` Foreign key (user_name) references user_profile (user_name) ON delete cascade,
    CONSTRAINT `fk_follows_artist_artist` Foreign key (artist_id) references artist (artist_id) ON delete cascade
);

CREATE TABLE `follows_profile` (
  `user_name_follower` varchar(255) NOT NULL,
  `user_name_following` varchar(255) NOT NULL,
   Primary key (user_name_follower, user_name_following),
   CONSTRAINT `fk_follows_profile_user_profile1` Foreign key (user_name_follower) references user_profile (user_name) ON delete cascade,
   CONSTRAINT `fk_follows_profile_user_profile2` Foreign key (user_name_following) references user_profile (user_name) ON delete cascade
);

CREATE TABLE `post` (
    `user_name` varchar(255) NOT NULL,
    `date_time` timestamp NOT NULL,
    `content` varchar(500) DEFAULT NULL,
    Primary key (user_name, date_time),
    CONSTRAINT `fk_post_user_profile` Foreign key (user_name) references user_profile (user_name) ON delete cascade
);

CREATE TABLE `upvote_album` (
  `user_name` varchar(255) NOT NULL,
  `album_id` varchar(255) NOT NULL,
  `date_time` timestamp NOT NULL,
   Primary key (user_name, album_id),
   CONSTRAINT `fk_upvote_album_user_profile` Foreign key (user_name) references user_profile (user_name) ON delete cascade,
   CONSTRAINT `fk_upvote_album_album` Foreign key (album_id) references album (album_id) ON delete cascade
);

CREATE TABLE `upvote_song` (
    `user_name` varchar(255) NOT NULL,
    `song_id` varchar(255) NOT NULL,
    `date_time` timestamp NOT NULL,
    Primary key(user_name, song_id),
    CONSTRAINT `fk_upvote_song_user_profile` Foreign key (user_name) references user_profile (user_name) ON delete cascade,
    CONSTRAINT `fk_upvote_song_song` Foreign key (song_id) references song (song_id) ON delete cascade
);

CREATE TABLE `user_login` (
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
   Primary key (user_name),
   CONSTRAINT `fk_user_login_user_profile` Foreign key (user_name) references user_profile (user_name) ON delete cascade
);

CREATE TABLE `user_top_items` (
  `user_name` varchar(255) NOT NULL,
  `item_id` varchar(255) NOT NULL,
  `item_type` varchar(255) NOT NULL,
  `item_ranking` int NOT NULL,
   Primary key (user_name, item_type, item_ranking),
   CONSTRAINT checkRank CHECK (item_ranking >= 1),
   CONSTRAINT `fk_user_top_items_user_profile` Foreign key (user_name) references user_profile (user_name) ON delete cascade
);

CREATE OR REPLACE VIEW protected_profile AS (
 SELECT user_name, first_name, last_name, full_name, number_of_posts, school, area_of_study, computing_id, bio
 FROM user_profile);

DELIMITER $$
CREATE TRIGGER makeFullName
BEFORE INSERT ON user_profile
FOR EACH ROW
  BEGIN
    SET NEW.full_name = CONCAT(NEW.first_name, ' ', NEW.last_name);
  END$$
DELIMITER ;
