-- spotifySocial is the name of the database on google cloud
USE spotifySocial;

--
-- Adding dummy data to album_genre as test
--
INSERT INTO user_profile (user_name, number_of_posts, school, area_of_study, computing_id, bio) 
VALUES 
('12345', 5, 'UVA', 'Computer Science', 'jd12345', NULL),
('67890', 12, 'UVA', 'Mechanical Engineering', 'js67890', NULL),
('11121', 7, 'UVA', 'Biology', 'aw11121', NULL),
('13141', 10, 'UVA', 'Mathematics', 'bb13141', NULL),
('15161', 3, 'UVA', 'Chemical Engineering', 'cc15161', NULL);
