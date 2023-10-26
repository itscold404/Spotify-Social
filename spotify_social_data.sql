-- spotifySocial is the name of the database on google cloud
USE spotifySocial;

INSERT INTO user_profile (user_name, number_of_posts, school, area_of_study, computing_id, bio)
VALUES
	('12345', 5, 'UVA', 'Computer Science', 'jd12345', NULL),
	('67890', 12, 'UVA', 'Mechanical Engineering', 'js67890', NULL),
	('11121', 7, 'UVA', 'Biology', 'aw11121', NULL),
	('13141', 10, 'UVA', 'Mathematics', 'bb13141', NULL),
	('15161', 3, 'UVA', 'Chemical Engineering', 'cc15161', NULL);

INSERT INTO user_login (user_name, password)
VALUES
	('12345', 'passwrd'),
	('67890','antoherpsswrd'),
	('11121', 'goodpassword'),
	('13141', 'anothergoodpasswrd'),
	('15161', '123');

INSERT INTO artist (artist_id, follower_count, name, popularity)
VALUES
	('A1b2C3d4E5f6G7h8I9j0', 75000000, 'Taylor Swift', 10),
	('K1L2M3N4O5P6Q7R8S9T0', 90000000, 'Beyoncé', 20),
	('U1V2W3X4Y5Z6a7b8c9d0', 80000000, 'BTS', 50),
	('D1E2F3G4H5I6J7K8L9M0', 55000000, 'Adele', 12),
	('N1O2P3Q4R5S6T7U8V9W0', 60000000, 'Ed Sheeran', 86),
	('X1Y2Z3A4B5C6D7E8F9G0', 85000000, 'Ariana Grande', 92),
	('H1I2J3K4L5M6N7O8P9Q0', 20000000, 'Shawn Mendes', 72),
	('R1S2T3U4V5W6X7Y8Z9A0', 30000000, 'Billie Eilish', 54),
	('B1C2D3E4F5G6H7I8J9K0', 40000000, 'AKMU', 88),
	('E1F2G3H4I5J6K7L8M9N0', 12000000, 'Conan Gray', 96),
	('L1M2N3O4P5Q6R7S8T9U0', 95000000, 'Post Malone', 93),
	('G1H2I3J4K5L6M7N8O9P0', 8000000, 'Penomeco', 68),
	('P1Q2R3S4T5U6V7W8X9Y0', 65000000, 'Coldplay', 77),
	('Q1W2E3R4T5Y6U7I8O9', 22000000, 'Katy Perry', 78), ('Z1X2C3V4B5N6M7A8S9', 78000000, 'Justin Bieber', 100), ('F1D2S3A4J5K6L7F8J9', 33000000, 'Miley Cyrus', 76), ('B1E2T3S4Y5E6J7S8D9', 90000000, 'Eminem', 94), 
	('R1O2N3E4D5I6R7N8K9', 58000000, 'Rihanna', 83), ('A1R2T3I4S5T6G7A8R9', 2000000, 'U2', 33), 
	('L1O2V3E4S5H6A7C8M9', 45000000, 'The Weeknd', 89), ('S1T2I3N4G5K6U7I8L9', 68000000, 'Alicia Keys', 82), ('N1O2L3T4O5Y6I7T8S9', 6000000, 'Norah Jones', 69), ('C1H2R3I4S5B6R7O8W9', 12000000, 'New Jeans', 85);

INSERT INTO artist_genre (artist_id, genre)
VALUES
	('A1b2C3d4E5f6G7h8I9j0', 'Pop'),
	('K1L2M3N4O5P6Q7R8S9T0', 'Pop'),
	('U1V2W3X4Y5Z6a7b8c9d0', 'Hip-Hop'),
	('X1Y2Z3A4B5C6D7E8F9G0', 'Country'),
	('R1O2N3E4D5I6R7N8K9', 'Pop'),
	('B1E2T3S4Y5E6J7S8D9', 'Dance'),
	('L1O2V3E4S5H6A7C8M9', 'K-Pop'),
	('N1O2L3T4O5Y6I7T8S9', 'Electronic'),
	('P1Q2R3S4T5U6V7W8X9Y0', 'Rap'),
	('C1H2R3I4S5B6R7O8W9', 'Alternative');

INSERT INTO album (album_id, title, popularity, album_type, total_tracks, release_date)
VALUES
	('TS123456789ABCDEFGHIJ', 'Dawn FM', 8000, 'Studio', 12, '2023-01-15 00:00:00'), 
	('BTSALBUM45678912345', 'Proof', 7500, 'Live', 10, '2022-11-20 18:06:20'), 
	('NEWJEANS567891234567', 'Ditto', 9000, 'Studio', 15, '2023-03-05 01:03:50'), 
	('KENSHI1234567890ALBM', 'The War', 7200, 'Studio', 14, '2023-02-10 09:00:00'), 
	('TAYLORSWIFTALBUM5678', 'Speak Now', 8500, 'Live', 9, '2022-09-28 10:20:30'), 
	('BTS45678912345ALBUM', 'Wings', 7600, 'Studio', 11, '2023-04-02 06:44:55'), 
	('JEANSNEWALBUM567891', 'OMG', 9400, 'Live', 8, '2022-12-20 00:08:10'), 
	('KENSHI567890ALBUM123', 'Eyes on You', 9200, 'Studio', 13, '2023-01-30 08:07:09'), 
	('SWIFTTAYLORALBUM123', 'Fearless', 7800, 'Live', 10, '2022-10-10 00:00:00'), 
	('BTSALBUM1234567890', 'Map of the Soul: Persona', 8700, 'Studio', 15, '2023-05-15 16:26:00'), 
	('NEWALBUM4567890JEANS', 'NewJeans 1st EP - New Jeans', 8200, 'Studio', 12, '2022-12-10 12:11:05'), 
	('KENSHIALBUM5678901', 'Nectar', 6800, 'Live', 10, '2022-11-30 00:00:00'), 
	('TAYLORALBUM12345678', 'Lover', 9500, 'Studio', 14, '2023-04-20 00:00:00'), 
	('BTSALBUM45678901', 'BE', 8900, 'Live', 9, '2022-08-15 10:03:02'), ('JEANSNEW45678ALBUM', 'Zero', 8600, 'Studio', 11, '2023-02-28 03:19:56'), 
	('KENSHI12345ALBUM67', 'Pink Friday', 7200, 'Live', 8, '2022-12-15 17:28:08'), 
	('SWIFTALBUM56789012', 'reputation', 9000, 'Studio', 13, '2023-03-10 23:34:10'), 
	('BTSALBUM56789123', 'Map of the Soul: 7', 7800, 'Live', 12, '2022-09-25 00:00:00'),
	('JEANSNEW40121ALBUM', 'NewJeans 2nd EP - Get Up', 8500, 'Studio', 14, '2023-04-05 09:18:45'), 
	('KENSHI567890ALBUM', 'Bootleg', 7600, 'Live', 11, '2022-11-12 14:20:13');

INSERT INTO follows_artist (user_name, artist_id)
Values
	('12345', 'A1b2C3d4E5f6G7h8I9j0'),
	('67890', 'A1b2C3d4E5f6G7h8I9j0'),
	('11121','R1O2N3E4D5I6R7N8K9'),
	('13141', 'N1O2P3Q4R5S6T7U8V9W0'),
	('15161', 'F1D2S3A4J5K6L7F8J9'),
	('15161', 'E1F2G3H4I5J6K7L8M9N0'),
	('15161', 'L1O2V3E4S5H6A7C8M9');

INSERT INTO song (song_id, duration_ms, name, popularity)
VALUES
    ('11dFghVXANMlKmJXsNCbNl001', 228500, 'No Tears Left To Cry', 100),
    ('11dFghVXANMlKmJXsNCbNl002', 205800, 'DDU-DU DDU-DU', 90),
    ('11dFghVXANMlKmJXsNCbNl003', 219700, 'Barbie World (with Aqua)', 85),
    ('11dFghVXANMlKmJXsNCbNl004', 212400, 'Paint the Town Red', 80),
    ('11dFghVXANMlKmJXsNCbNl005', 198200, '7rings', 95),
    ('11dFghVXANMlKmJXsNCbNl006', 226100, 'Love Dive', 88),
    ('11dFghVXANMlKmJXsNCbNl007', 207500, 'Rockstar (feat. 21 Savage)', 75),
    ('11dFghVXANMlKmJXsNCbNl008', 214800, 'Just Wanna Rock', 78),
    ('11dFghVXANMlKmJXsNCbNl009', 197600, 'I Did Something Bad', 92),
    ('11dFghVXANMlKmJXsNCbNl010', 222300, 'I Will Go To You Like the First Snow', 89),
    ('11dFghVXANMlKmJXsNCbNl011', 218700, 'Where She Goes', 82),
    ('11dFghVXANMlKmJXsNCbNl012', 211900, 'How You Like That', 79),
    ('11dFghVXANMlKmJXsNCbNl013', 206500, 'Blinding Lights', 97),
    ('11dFghVXANMlKmJXsNCbNl014', 199300, 'The Night Is Still Young', 91),
    ('11dFghVXANMlKmJXsNCbNl015', 223400, 'Heartless', 84);

INSERT INTO post (user_name, date_time, content) 
VALUES 
	('12345', '2023-10-26 13:00:00', 'just listened to "bohemian rhapsody" again. timeless classic!'),
	('67890', '2023-10-26 13:05:25', 'anyone else love the beat drop in "on the floor"?’'), ('12345', '2023-10-26 13:10:10', 'been on a jazz spree. coltrane is pure magic.'), 
	('13141', '2023-10-26 13:15:15', 'recommendations for indie rock bands? need new tunes!'), ('67890', '2023-10-26 13:20:20', 'the harmonies in "hallelujah" give me chills every time.'), ('13141', '2023-10-26 13:25:25', 'i cannot get the chorus of "shape of you" out of my head! #catchy'),
	('67890', '2023-10-26 13:30:30', 'just discovered "fleetwood mac". why did i wait so long?!'), ('13141', '2023-10-26 13:35:35', 'the lyrics of "imagine" by john lennon always make me ponder.'),
	('67890', '2023-10-26 13:40:40', 'on a reggae journey. bob marley vibes all day long.'), ('67890', '2023-10-26 13:45:45', 'there is something hauntingly beautiful about "sound of silence" by simon & garfunkel.');

INSERT INTO song_by (song_id, artist_id)
VALUES
	('11dFghVXANMlKmJXsNCbNl001', 'X1Y2Z3A4B5C6D7E8F9G0'),
	('11dFghVXANMlKmJXsNCbNl002', 'H1I2J3K4L5M6N7O8P9Q0'),
	('11dFghVXANMlKmJXsNCbNl003', 'F1D2S3A4J5K6L7F8J9'),
	('11dFghVXANMlKmJXsNCbNl004', 'N1O2P3Q4R5S6T7U8V9W0'),
	('11dFghVXANMlKmJXsNCbNl005', 'X1Y2Z3A4B5C6D7E8F9G0'),
	('11dFghVXANMlKmJXsNCbNl006', 'B1E2T3S4Y5E6J7S8D9'),
	('11dFghVXANMlKmJXsNCbNl007', 'G1H2I3J4K5L6M7N8O9P0'),
	('11dFghVXANMlKmJXsNCbNl008', 'B1C2D3E4F5G6H7I8J9K0'),
	('11dFghVXANMlKmJXsNCbNl009', 'E1F2G3H4I5J6K7L8M9N0'),
	('11dFghVXANMlKmJXsNCbNl010', 'R1O2N3E4D5I6R7N8K9'),
	('11dFghVXANMlKmJXsNCbNl011', 'Z1X2C3V4B5N6M7A8S9'),
	('11dFghVXANMlKmJXsNCbNl012', 'P1Q2R3S4T5U6V7W8X9Y0'),
	('11dFghVXANMlKmJXsNCbNl013', 'P1Q2R3S4T5U6V7W8X9Y0'),
	('11dFghVXANMlKmJXsNCbNl014', 'L1M2N3O4P5Q6R7S8T9U0'),
	('11dFghVXANMlKmJXsNCbNl015', 'R1O2N3E4D5I6R7N8K9');

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

INSERT INTO album_by (album_id, artist_id)
VALUES
	('TS123456789ABCDEFGHIJ', 'A1b2C3d4E5f6G7h8I9j0'), 
	('BTSALBUM45678912345', 'U1V2W3X4Y5Z6a7b8c9d0'), 
	('NEWJEANS567891234567', 'C1H2R3I4S5B6R7O8W9'), 
	('KENSHI1234567890ALBM', 'K1L2M3N4O5P6Q7R8S9T0'), 
	('TAYLORSWIFTALBUM5678', 'P1Q2R3S4T5U6V7W8X9Y0'), 
	('BTS45678912345ALBUM', 'N1O2P3Q4R5S6T7U8V9W0'), 
	('JEANSNEWALBUM567891', 'R1S2T3U4V5W6X7Y8Z9A0'), 
	('KENSHI567890ALBUM123', 'Z1X2C3V4B5N6M7A8S9'), 
	('SWIFTTAYLORALBUM123', 'P1Q2R3S4T5U6V7W8X9Y0'), 
	('BTSALBUM1234567890', 'S1T2I3N4G5K6U7I8L9'), 
	('NEWALBUM4567890JEANS', 'S1T2I3N4G5K6U7I8L9'), 
	('KENSHIALBUM5678901', 'R1S2T3U4V5W6X7Y8Z9A0'), 
	('TAYLORALBUM12345678', 'L1O2V3E4S5H6A7C8M9'), 
	('BTSALBUM45678901', 'Q1W2E3R4T5Y6U7I8O9'), 
	('JEANSNEW45678ALBUM', 'A1b2C3d4E5f6G7h8I9j0'), 
	('KENSHI12345ALBUM67', 'N1O2L3T4O5Y6I7T8S9'), 
	('SWIFTALBUM56789012', 'B1E2T3S4Y5E6J7S8D9'), 
	('BTSALBUM56789123', 'A1R2T3I4S5T6G7A8R9'), 
	('JEANSNEW40121ALBUM', '1H2I3J4K5L6M7N8O9P0'), 
	('KENSHI567890ALBUM', 'N1O2L3T4O5Y6I7T8S9');

INSERT INTO album_genre (album_id, genre)
VALUES
	('TS123456789ABCDEFGHIJ', 'Electronic'), 
	('BTSALBUM45678912345', 'Rap'), 
	('NEWJEANS567891234567', 'K-Pop'), 
	('KENSHI1234567890ALBM', 'Pop'), 
	('TAYLORSWIFTALBUM5678', 'Country'), 
	('BTS45678912345ALBUM', 'K-Pop'), 
	('JEANSNEWALBUM567891', 'Pop'), 
	('KENSHI567890ALBUM123', 'Dance'), 
	('SWIFTTAYLORALBUM123', 'Alternative'), 
	('BTSALBUM1234567890', 'Dance'), 
	('NEWALBUM4567890JEANS', 'Rap'), 
	('KENSHIALBUM5678901', 'Alternative'), 
	('TAYLORALBUM12345678', 'Pop'), 
	('BTSALBUM45678901', 'K-Pop'), 
	('JEANSNEW45678ALBUM', 'Hip-Hop'), 
	('KENSHI12345ALBUM67', 'Rock'), 
	('SWIFTALBUM56789012', 'Alternative'), 
	('BTSALBUM56789123', 'Rap'), 
	('JEANSNEW40121ALBUM', 'K-Pop'),
	('KENSHI567890ALBUM', 'Pop');

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


INSERT INTO follows_profile (user_name_follower, user_name_following)
VALUES 
	('12345', '67890'), 
	('12345', '11121'),
	('67890', '15161'),
	('11121', '13141'),
	('13141', '15161'), 
	('15161', '67890');

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

INSERT INTO school_song_chart (school_name, rank, song_id)
VALUES 
	('engineering', 1, '11dFghVXANMlKmJXsNCbNl003'),
	('engineering', 2, '11dFghVXANMlKmJXsNCbNl007'),
	('engineering', 3, '11dFghVXANMlKmJXsNCbNl015'), 
	('engineering', 4, '11dFghVXANMlKmJXsNCbNl013'), 
	('engineering', 5, '11dFghVXANMlKmJXsNCbNl005');