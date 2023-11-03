-- spotifySocial is the name of the database on google cloud
USE spotifySocial;

DROP TABLE school_song_chart;

CREATE TABLE `school_song_chart` (
  `school_name` varchar(255) NOT NULL,
  `ranking` int(11) NOT NULL,
  `song_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `school_song_chart`
  ADD PRIMARY KEY (`school_name`, `ranking`),
  ADD KEY `ranking_key` (`ranking`);

ALTER TABLE `school_song_chart`
  ADD CONSTRAINT `school_song_chart_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`);

NOTE: USER_PROFILE IS MISSING NAME. INSERT NAME COLUMN INTO DATABASE
spotifySocial is the name of the database on google cloud

INSERT INTO album (album_id, title, popularity, album_type, total_tracks, release_date)
VALUES
	('TS123456789ABCDEFGHIJ', 'reputation', 98, 'Studio', 15, '2017-11-10 00:00:00'), 
	('BTSALBUM45678912345', 'Renaissance', 95, 'Studio', 16, '2022-07-29 18:06:20'), 
	('NEWJEANS567891234567', 'Map of the Soul: 7', 87, 'Studio', 20, '2020-02-21 01:03:50'), 
	('KENSHI1234567890ALBM', '21', 72, 'Studio', 11, '2011-01-24 09:00:00'), 
	('TAYLORSWIFTALBUM5678', '÷ (Deluxe)', 65, 'Studio', 16, '2017-03-03 10:20:30'), 
	('BTS45678912345ALBUM', 'thank u, next', 76, 'Studio', 12, '2019-02-08 06:44:55'), 
	('JEANSNEWALBUM567891', 'Illuminate (Deluxe)', 94, 'Studio', 16, '2016-09-23 00:08:10'), 
	('KENSHI567890ALBUM123', 'When We All Fall Asleep, Where Do We Go?', 92, 'Studio', 14, '2019-03-29 08:07:09'), 
	('SWIFTTAYLORALBUM123', 'Next Episode', 78, 'Studio', 7, '2020-11-16 00:00:00'), 
	('BTSALBUM1234567890', 'Kid Krow', 87, 'Studio', 12, '2020-03-20 16:26:00'), 
	('NEWALBUM4567890JEANS', 'beerbongs & bentleys', 82, 'Studio', 18, '2018-04-27 12:11:05'), 
	('KENSHIALBUM5678901', 'k bye for now (swt live)', 68, 'Live', 32, '2019-12-23 00:00:00'), 
	('TAYLORALBUM12345678', 'Speak Now World Tour Live', 95, 'Live', 16, '2011-11-21 00:00:00'), 
	('BTSALBUM45678901', 'Teenage Dream', 89, 'Studio', 12, '2010-08-24 10:03:02'),
	('JEANSNEW45678ALBUM', 'Purpose (Deluxe)', 86, 'Studio', 19, '2015-11-13 03:19:56'), 
	('KENSHI12345ALBUM67', 'Endless Summer Vacation', 72, 'Studio', 14, '2023-03-10 17:28:08'), 
	('SWIFTALBUM56789012', 'Recovery (Deluxe Edition)', 90, 'Studio', 19, '2010-06-18 23:34:10'), 
	('BTSALBUM56789123', 'Good Girl Gone Bad: Reloaded', 78, 'Studio', 15, '2007-05-31 00:00:00'),
	('JEANSNEW40121ALBUM', 'The Joshua Tree (Super Deluxe)', 85, 'Studio', 49, '1987-03-09 09:18:45'), 
	('KENSHI567890ALBUM', 'After Hours (Deluxe)', 76, 'Studio', 18, '2020-03-20 14:20:13');

INSERT INTO artist (artist_id, artist_name, popularity, follower_count)
VALUES
	('A1b2C3d4E5f6G7h8I9j0', 'Taylor Swift', 10, 90026456),
	('K1L2M3N4O5P6Q7R8S9T0', 'Beyoncé', 20, 36075322),
	('U1V2W3X4Y5Z6a7b8c9d0', 'BTS', 50, 70356205),
	('D1E2F3G4H5I6J7K8L9M0', 'Adele', 12, 52004063),
	('N1O2P3Q4R5S6T7U8V9W0', 'Ed Sheeran', 86, 114875034),
	('X1Y2Z3A4B5C6D7E8F9G0', 'Ariana Grande', 92, 94233961),
	('H1I2J3K4L5M6N7O8P9Q0', 'Shawn Mendes', 72, 42521163),
	('R1S2T3U4V5W6X7Y8Z9A0', 'Billie Eilish', 54, 87878184),
	('B1C2D3E4F5G6H7I8J9K0', 'AKMU', 88, 1457519),
	('E1F2G3H4I5J6K7L8M9N0', 'Conan Gray', 96, 8518108),
	('L1M2N3O4P5Q6R7S8T9U0', 'Post Malone', 93, 42396464),
	('G1H2I3J4K5L6M7N8O9P0', 'Penomeco', 68, 356958),
	('P1Q2R3S4T5U6V7W8X9Y0', 'Coldplay', 77, 47637325),
	('Q1W2E3R4T5Y6U7I8O9', 'Katy Perry', 78, 29903757),
	('Z1X2C3V4B5N6M7A8S9', 'Justin Bieber', 100, 74256151),
	('F1D2S3A4J5K6L7F8J9', 'Miley Cyrus', 76, 22394226),
	('B1E2T3S4Y5E6J7S8D9', 'Eminem', 94, 77596640),
	('R1O2N3E4D5I6R7N8K9', 'Rihanna', 83, 58044161),
	('A1R2T3I4S5T6G7A8R9', 'U2', 33, 11614096),
	('L1O2V3E4S5H6A7C8M9', 'The Weeknd', 89, 73418832),
	('S1T2I3N4G5K6U7I8L9', 'Alicia Keys', 82, 11110247),
	('N1O2L3T4O5Y6I7T8S9', 'Norah Jones', 69, 3026525),
	('C1H2R3I4S5B6R7O8W9', 'New Jeans', 85, 5811406);

INSERT INTO user_profile (user_name, number_of_posts, school, area_of_study, computing_id, bio, full_name)
VALUES
	('11121', 7, 'UVA', 'Biology', 'aw11121', NULL, 'arnold'),
	('12345', 5, 'UVA', 'Computer Science', 'jd12345', NULL, 'bob'),
	('13141', 10, 'UVA', 'Mathematics', 'bb13141', NULL, 'sally'),
	('15161', 3, 'UVA', 'Chemical Engineering', 'cc15161', NULL, 'kelly'),
	('67890', 12, 'UVA', 'Mechanical Engineering', 'js67890', NULL, 'billy');

INSERT INTO song (song_id, duration_ms, song_name, popularity)
VALUES
    ('11dFghVXANMlKmJXsNCbNl001', 228500, 'I Did Something Bad', 100),
    ('11dFghVXANMlKmJXsNCbNl002', 205800, 'Single Ladies (Put a Ring on It)', 90),
    ('11dFghVXANMlKmJXsNCbNl003', 219700, 'Dynamite', 85),
    ('11dFghVXANMlKmJXsNCbNl004', 212400, 'Someone Like You', 80),
    ('11dFghVXANMlKmJXsNCbNl005', 198200, 'Shape of You', 95),
    ('11dFghVXANMlKmJXsNCbNl006', 226100, '7rings', 88),
    ('11dFghVXANMlKmJXsNCbNl007', 207500, 'Stitches', 75),
    ('11dFghVXANMlKmJXsNCbNl008', 214800, 'bad guy', 78),
    ('11dFghVXANMlKmJXsNCbNl009', 197600, 'Nakka (feat. IU)', 92),
    ('11dFghVXANMlKmJXsNCbNl010', 222300, 'Heather', 89),
    ('11dFghVXANMlKmJXsNCbNl011', 218700, 'rockstar (feat. 21 Savage)', 82),
    ('11dFghVXANMlKmJXsNCbNl012', 211900, 'Bolo (feat. YDG)', 79),
    ('11dFghVXANMlKmJXsNCbNl013', 206500, 'My Universe', 97),
    ('11dFghVXANMlKmJXsNCbNl014', 199300, 'Dark Horse', 91),
    ('11dFghVXANMlKmJXsNCbNl015', 223400, 'Sorry', 84);

INSERT INTO album_by (album_id, artist_id)
VALUES
	('TS123456789ABCDEFGHIJ', 'A1b2C3d4E5f6G7h8I9j0'), 
	('BTSALBUM45678912345', 'K1L2M3N4O5P6Q7R8S9T0'), 
	('NEWJEANS567891234567', 'U1V2W3X4Y5Z6a7b8c9d0'), 
	('KENSHI1234567890ALBM', 'D1E2F3G4H5I6J7K8L9M0'), 
	('TAYLORSWIFTALBUM5678', 'N1O2P3Q4R5S6T7U8V9W0'), 
	('BTS45678912345ALBUM', 'X1Y2Z3A4B5C6D7E8F9G0'), 
	('JEANSNEWALBUM567891', 'H1I2J3K4L5M6N7O8P9Q0'), 
	('KENSHI567890ALBUM123', 'R1S2T3U4V5W6X7Y8Z9A0'), 
	('SWIFTTAYLORALBUM123', 'B1C2D3E4F5G6H7I8J9K0'), 
	('BTSALBUM1234567890', 'E1F2G3H4I5J6K7L8M9N0'), 
	('NEWALBUM4567890JEANS', 'L1M2N3O4P5Q6R7S8T9U0'), 
	('KENSHIALBUM5678901', 'X1Y2Z3A4B5C6D7E8F9G0'), 
	('TAYLORALBUM12345678', 'A1b2C3d4E5f6G7h8I9j0'), 
	('BTSALBUM45678901', 'Q1W2E3R4T5Y6U7I8O9'), 
	('JEANSNEW45678ALBUM', 'Z1X2C3V4B5N6M7A8S9'), 
	('KENSHI12345ALBUM67', 'F1D2S3A4J5K6L7F8J9'), 
	('SWIFTALBUM56789012', 'B1E2T3S4Y5E6J7S8D9'), 
	('BTSALBUM56789123', 'R1O2N3E4D5I6R7N8K9'), 
	('JEANSNEW40121ALBUM', 'A1R2T3I4S5T6G7A8R9'), 
	('KENSHI567890ALBUM', 'L1O2V3E4S5H6A7C8M9');

INSERT INTO album_genre (album_id, genre)
VALUES
	('TS123456789ABCDEFGHIJ', 'Electropop'), 
	('BTSALBUM45678912345', 'R&B'), 
	('NEWJEANS567891234567', 'K-Pop'), 
	('KENSHI1234567890ALBM', 'Pop Soul'), 
	('TAYLORSWIFTALBUM5678', 'Pop'), 
	('BTS45678912345ALBUM', 'Pop'), 
	('JEANSNEWALBUM567891', 'Pop'), 
	('KENSHI567890ALBUM123', 'Pop'), 
	('SWIFTTAYLORALBUM123', 'Synth Pop'), 
	('BTSALBUM1234567890', 'Pop'), 
	('NEWALBUM4567890JEANS', 'Hip-Hop'), 
	('KENSHIALBUM5678901', 'Pop'), 
	('TAYLORALBUM12345678', 'Country Pop'), 
	('BTSALBUM45678901', 'Dance Pop'), 
	('JEANSNEW45678ALBUM', 'EDM Pop'), 
	('KENSHI12345ALBUM67', 'Pop'), 
	('SWIFTALBUM56789012', 'Rap'), 
	('BTSALBUM56789123', 'Dance Pop'), 
	('JEANSNEW40121ALBUM', 'Rock'),
	('KENSHI567890ALBUM', 'R&B');

INSERT INTO artist_genre (artist_id, genre)
VALUES
	('A1b2C3d4E5f6G7h8I9j0', 'Pop'),
	('K1L2M3N4O5P6Q7R8S9T0', 'R&B'),
	('U1V2W3X4Y5Z6a7b8c9d0', 'K-Pop'),
	('D1E2F3G4H5I6J7K8L9M0', 'Pop Soul'),
	('N1O2P3Q4R5S6T7U8V9W0', 'Pop'),
	('X1Y2Z3A4B5C6D7E8F9G0', 'Pop'),
	('H1I2J3K4L5M6N7O8P9Q0', 'Pop'),
	('R1S2T3U4V5W6X7Y8Z9A0', 'Pop'),
	('B1C2D3E4F5G6H7I8J9K0', 'K-Pop'),
	('E1F2G3H4I5J6K7L8M9N0', 'Pop'),
	('L1M2N3O4P5Q6R7S8T9U0', 'Rap'),
	('G1H2I3J4K5L6M7N8O9P0', 'K-Pop'),
	('P1Q2R3S4T5U6V7W8X9Y0', 'Alternative Rock'),
	('Q1W2E3R4T5Y6U7I8O9', 'Pop'),
	('Z1X2C3V4B5N6M7A8S9', 'Pop'),
	('F1D2S3A4J5K6L7F8J9', 'Pop'),
	('B1E2T3S4Y5E6J7S8D9', 'Rap'), 
	('R1O2N3E4D5I6R7N8K9', 'Reggae'),
	('A1R2T3I4S5T6G7A8R9', 'Rock'), 
	('L1O2V3E4S5H6A7C8M9', 'R&B'),
	('S1T2I3N4G5K6U7I8L9', 'R&B'),
	('N1O2L3T4O5Y6I7T8S9', 'Pop'),
	('C1H2R3I4S5B6R7O8W9', 'K-Pop');

INSERT INTO follows_artist (user_name, artist_id)
Values
	('12345', 'A1b2C3d4E5f6G7h8I9j0'),
	('67890', 'A1b2C3d4E5f6G7h8I9j0'),
	('11121','R1O2N3E4D5I6R7N8K9'),
	('13141', 'N1O2P3Q4R5S6T7U8V9W0'),
	('15161', 'F1D2S3A4J5K6L7F8J9'),
	('15161', 'E1F2G3H4I5J6K7L8M9N0'),
	('15161', 'L1O2V3E4S5H6A7C8M9');

INSERT INTO follows_profile (user_name_follower, user_name_following)
VALUES 
	('12345', '67890'), 
	('12345', '11121'),
	('67890', '15161'),
	('11121', '13141'),
	('13141', '15161'), 
	('15161', '67890');

INSERT INTO post (user_name, date_time, content) 
VALUES 
	('12345', '2023-10-26 13:00:00', 'just listened to "bohemian rhapsody" again. timeless classic!'),
	('67890', '2023-10-26 13:05:25', 'anyone else love the beat drop in "on the floor"?’'), ('12345', '2023-10-26 13:10:10', 'been on a jazz spree. coltrane is pure magic.'), 
	('13141', '2023-10-26 13:15:15', 'recommendations for indie rock bands? need new tunes!'), ('67890', '2023-10-26 13:20:20', 'the harmonies in "hallelujah" give me chills every time.'), ('13141', '2023-10-26 13:25:25', 'i cannot get the chorus of "shape of you" out of my head! #catchy'),
	('67890', '2023-10-26 13:30:30', 'just discovered "fleetwood mac". why did i wait so long?!'), ('13141', '2023-10-26 13:35:35', 'the lyrics of "imagine" by john lennon always make me ponder.'),
	('67890', '2023-10-26 13:40:40', 'on a reggae journey. bob marley vibes all day long.'), ('67890', '2023-10-26 13:45:45', 'there is something hauntingly beautiful about "sound of silence" by simon & garfunkel.');

INSERT INTO school_song_chart (school_name, ranking, song_id)
VALUES
	('engineering', 1, '11dFghVXANMlKmJXsNCbNl003'),
	('engineering', 2, '11dFghVXANMlKmJXsNCbNl007'),
	('engineering', 3, '11dFghVXANMlKmJXsNCbNl015'), 
	('engineering', 4, '11dFghVXANMlKmJXsNCbNl013'), 
	('engineering', 5, '11dFghVXANMlKmJXsNCbNl005');

INSERT INTO song_by (song_id, artist_id)
VALUES
	('11dFghVXANMlKmJXsNCbNl001', 'A1b2C3d4E5f6G7h8I9j0'),
	('11dFghVXANMlKmJXsNCbNl002', 'K1L2M3N4O5P6Q7R8S9T0'),
	('11dFghVXANMlKmJXsNCbNl003', 'U1V2W3X4Y5Z6a7b8c9d0'),
	('11dFghVXANMlKmJXsNCbNl004', 'D1E2F3G4H5I6J7K8L9M0'),
	('11dFghVXANMlKmJXsNCbNl005', 'N1O2P3Q4R5S6T7U8V9W0'),
	('11dFghVXANMlKmJXsNCbNl006', 'X1Y2Z3A4B5C6D7E8F9G0'),
	('11dFghVXANMlKmJXsNCbNl007', 'H1I2J3K4L5M6N7O8P9Q0'),
	('11dFghVXANMlKmJXsNCbNl008', 'R1S2T3U4V5W6X7Y8Z9A0'),
	('11dFghVXANMlKmJXsNCbNl009', 'B1C2D3E4F5G6H7I8J9K0'),
	('11dFghVXANMlKmJXsNCbNl010', 'E1F2G3H4I5J6K7L8M9N0'),
	('11dFghVXANMlKmJXsNCbNl011', 'L1M2N3O4P5Q6R7S8T9U0'),
	('11dFghVXANMlKmJXsNCbNl012', 'G1H2I3J4K5L6M7N8O9P0'),
	('11dFghVXANMlKmJXsNCbNl013', 'P1Q2R3S4T5U6V7W8X9Y0'),
	('11dFghVXANMlKmJXsNCbNl014', 'Q1W2E3R4T5Y6U7I8O9'),
	('11dFghVXANMlKmJXsNCbNl015', 'Z1X2C3V4B5N6M7A8S9');

INSERT INTO upvote_album (user_name, album_id, date_time)
VALUES 
	('12345', 'TS123456789ABCDEFGHIJ', '2023-10-26 13:00:00'),
	('67890', 'BTSALBUM45678912345', '2023-10-26 13:10:00'),
	('11121', 'TAYLORSWIFTALBUM5678', '2023-10-26 13:20:00'), 
	('12345', 'BTS45678912345ALBUM', '2023-10-26 13:30:00'), 
	('67890', 'SWIFTTAYLORALBUM123', '2023-10-26 13:40:00'), 
	('11121', 'BTSALBUM1234567890', '2023-10-26 13:50:00'),
	('12345', 'TAYLORSWIFTALBUM5678', '2023-10-26 14:00:00'),
	('67890', 'TS123456789ABCDEFGHIJ', '2023-10-26 14:10:00'),
	('11121', 'BTS45678912345ALBUM', '2023-10-26 14:20:00'),
	('12345', 'BTSALBUM45678912345', '2023-10-26 14:30:00');

INSERT INTO upvote_post (upvoter, receiver, date_time)
VALUES
	('67890', '12345', '2023-10-26 13:00:00'),   
	('13141', '67890', '2023-10-26 13:05:25'), 
	('11121', '12345', '2023-10-26 13:10:10'),
	('12345', '13141', '2023-10-26 13:15:15'), 
	('11121', '67890', '2023-10-26 13:20:20'),
	('15161', '13141', '2023-10-26 13:25:25'),
	('12345', '67890', '2023-10-26 13:30:30'),
	('11121', '12345', '2023-10-26 13:00:00'),
	('15161', '12345', '2023-10-26 13:00:00');

INSERT INTO upvote_song (user_name, song_id, date_time)
VALUES
	('12345', '11dFghVXANMlKmJXsNCbNl007', '2023-10-26 10:10:00'), 
	('13141', '11dFghVXANMlKmJXsNCbNl009', '2023-10-26 10:20:00'),
	('13141', '11dFghVXANMlKmJXsNCbNl012', '2023-10-26 11:12:00'), 
	('12345', '11dFghVXANMlKmJXsNCbNl015', '2023-10-26 11:26:00'), 
	('11121', '11dFghVXANMlKmJXsNCbNl009', '2023-10-26 11:32:00'),
	('11121', '11dFghVXANMlKmJXsNCbNl006', '2023-10-26 11:42:00'),
	('67890', '11dFghVXANMlKmJXsNCbNl006', '2023-10-26 11:48:00'),
	('67890', '11dFghVXANMlKmJXsNCbNl011', '2023-10-26 11:53:00'),
	('67890', '11dFghVXANMlKmJXsNCbNl003', '2023-10-26 12:08:00'),
	('67890', '11dFghVXANMlKmJXsNCbNl009', '2023-10-26 12:28:00'),
	('12345', '11dFghVXANMlKmJXsNCbNl002', '2023-10-26 12:40:00'),
	('12345', '11dFghVXANMlKmJXsNCbNl012', '2023-10-26 12:46:00');

INSERT INTO user_login (user_name, password)
VALUES
	('12345', 'passwrd'),
	('67890','antoherpsswrd'),
	('11121', 'goodpassword'),
	('13141', 'anothergoodpasswrd'),
	('15161', '123');

