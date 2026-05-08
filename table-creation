CREATE DATABASE IF NOT EXISTS MovieTicketDB;
USE MovieTicketDB;

-- table 1 

CREATE TABLE genres (
    genre_id   INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL UNIQUE
);

select * from genres ;

-- TABLE 2

CREATE TABLE movies (
    movie_id     INT AUTO_INCREMENT PRIMARY KEY,
    title        VARCHAR(100) NOT NULL,
    genre_id     INT NOT NULL,
    language     VARCHAR(30) NOT NULL DEFAULT 'English',
    duration_min INT NOT NULL,
    rating       DECIMAL(3,1),
    release_date DATE,
    CONSTRAINT fk_movie_genre FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

desc movies;


-- TABLE 3

CREATE TABLE theaters (
    theater_id    INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    city          VARCHAR(60)  NOT NULL,
    state         VARCHAR(60)  NOT NULL,
    total_screens INT NOT NULL DEFAULT 1
);


-- TABLE 4

CREATE TABLE screens (
    screen_id   INT AUTO_INCREMENT PRIMARY KEY,
    theater_id  INT NOT NULL,
    screen_name VARCHAR(20) NOT NULL,
    total_seats INT NOT NULL,
    screen_type ENUM('2D','3D','IMAX') NOT NULL DEFAULT '2D',
    CONSTRAINT fk_screen_theater FOREIGN KEY (theater_id) REFERENCES theaters(theater_id)
);


-- TABLE 5

CREATE TABLE seats (
    seat_id     INT AUTO_INCREMENT PRIMARY KEY,
    screen_id   INT NOT NULL,
    row_label   CHAR(1) NOT NULL,
    seat_number INT NOT NULL,
    seat_type   ENUM('Standard','Premium','Recliner') NOT NULL DEFAULT 'Standard',
    CONSTRAINT fk_seat_screen FOREIGN KEY (screen_id) REFERENCES screens(screen_id),
    CONSTRAINT uq_seat UNIQUE (screen_id, row_label, seat_number)
);


-- TABLE 6

CREATE TABLE shows (
    show_id      INT AUTO_INCREMENT PRIMARY KEY,
    movie_id     INT NOT NULL,
    screen_id    INT NOT NULL,
    show_date    DATE NOT NULL,
    show_time    TIME NOT NULL,
    ticket_price DECIMAL(8,2) NOT NULL,
    CONSTRAINT fk_show_movie  FOREIGN KEY (movie_id)  REFERENCES movies(movie_id),
    CONSTRAINT fk_show_screen FOREIGN KEY (screen_id) REFERENCES screens(screen_id)
);

 
-- TABLE 7

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(100) NOT NULL UNIQUE,
    phone       VARCHAR(15),
    dob         DATE,
    joined_on   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- TABLE 8

CREATE TABLE bookings (
    booking_id   INT AUTO_INCREMENT PRIMARY KEY,
    customer_id  INT NOT NULL,
    show_id      INT NOT NULL,
    booked_on    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    status       ENUM('Confirmed','Cancelled','Pending') NOT NULL DEFAULT 'Pending',
    CONSTRAINT fk_booking_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_booking_show     FOREIGN KEY (show_id)     REFERENCES shows(show_id)
);


-- TABLE 9

CREATE TABLE booking_seats (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    seat_id    INT NOT NULL,
    CONSTRAINT fk_bs_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    CONSTRAINT fk_bs_seat    FOREIGN KEY (seat_id)    REFERENCES seats(seat_id),
    CONSTRAINT uq_bs         UNIQUE (booking_id, seat_id)
);


-- TABLE 10: payments

CREATE TABLE payments (
    payment_id      INT AUTO_INCREMENT PRIMARY KEY,
    booking_id      INT NOT NULL UNIQUE,
    payment_method  ENUM('Credit Card','Debit Card','UPI','Net Banking','Wallet') NOT NULL,
    payment_status  ENUM('Success','Failed','Refunded','Pending') NOT NULL DEFAULT 'Pending',
    paid_amount     DECIMAL(10,2) NOT NULL,
    paid_on         DATETIME,
    transaction_ref VARCHAR(50),
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);


--  INSERT DATA 


-- ── TABLE 1
INSERT INTO genres (genre_name) VALUES
('Action'),('Romance'),('Comedy'),('Horror'),('Drama'),
('Sci-Fi'),('Thriller'),('Animation'),('Fantasy'),('Mystery'),
('Adventure'),('Musical'),('Biography'),('History'),('Documentary'),
('Sport'),('War'),('Western'),('Crime'),('Family'),
('Superhero'),('Psychological'),('Noir'),('Satire'),('Dystopian'),
('Mythology'),('Supernatural'),('Espionage'),('Road Movie'),('Coming-of-Age'),
('Political'),('Heist'),('Survival'),('Romantic Comedy'),('Dark Comedy'),
('Martial Arts'),('Zombie'),('Disaster'),('Space Opera'),('Teen'),
('Legal Drama'),('Medical'),('Religious'),('Slice of Life'),('Erotic Thriller'),
('Mockumentary'),('Anthology'),('Experimental'),('Silent'),('Short Film');

-- ── TABLE 2
INSERT INTO movies (title, genre_id, language, duration_min, rating, release_date) VALUES
('Blaze of Glory',        1,  'English', 140, 8.2, '2024-01-15'),
('Hearts Collide',        2,  'English', 115, 7.5, '2024-02-10'),
('Laugh Out Loud',        3,  'Hindi',   120, 7.8, '2024-03-05'),
('Dark Shadows',          4,  'English', 105, 6.9, '2024-04-20'),
('The Last Witness',      5,  'Tamil',   150, 8.5, '2024-05-11'),
('Galactic War',          6,  'English', 160, 8.9, '2024-06-01'),
('Silent Betrayal',       7,  'English', 130, 7.2, '2024-07-18'),
('Crazy Family',          3,  'Hindi',   110, 7.0, '2024-08-09'),
('Echoes of Time',        6,  'English', 145, 8.1, '2024-09-22'),
('Crimson Coast',         1,  'Tamil',   135, 7.6, '2024-10-30'),
('Dragon Realm',          9,  'English', 155, 8.4, '2024-11-05'),
('Love in Tokyo',         2,  'English', 118, 7.3, '2024-11-20'),
('The Haunting Hour',     4,  'Hindi',   100, 6.5, '2024-12-01'),
('Code Red',              7,  'English', 125, 7.9, '2024-12-15'),
('Space Frontier',        39, 'English', 165, 9.0, '2025-01-10'),
('Jungle Run',            11, 'English', 112, 7.1, '2025-01-25'),
('Rise of Heroes',        21, 'English', 148, 8.7, '2025-02-14'),
('Lost in Paris',         34, 'French',  108, 7.4, '2025-02-28'),
('The Iron Throne',       14, 'Hindi',   170, 8.6, '2025-03-07'),
('Phantom Signal',        28, 'English', 132, 7.8, '2025-03-21'),
('Mumbai Nights',         19, 'Hindi',   140, 7.5, '2025-04-04'),
('Whispers in the Dark',  12, 'Tamil',    95, 6.7, '2025-04-18'),
('Battle Beyond Stars',   6,  'English', 158, 8.3, '2025-05-02'),
('The Forgotten Map',     10, 'English', 122, 7.6, '2025-05-16'),
('Neon City',             6,  'English', 138, 8.0, '2025-05-30'),
('Desi Tadka',            3,  'Hindi',   105, 7.2, '2024-01-28'),
('Storm Chasers',         38, 'English', 130, 7.0, '2024-02-22'),
('The Royal Secret',      31, 'English', 145, 7.9, '2024-03-18'),
('Zombie Dawn',           37, 'Hindi',   115, 6.8, '2024-04-05'),
('Mountain High',         33, 'Tamil',   128, 7.5, '2024-05-25'),
('Time Loop',             6,  'English', 142, 8.2, '2024-06-14'),
('Mask of Justice',       21, 'English', 152, 8.8, '2024-07-04'),
('Pyaar Ka Safar',        2,  'Hindi',   118, 7.4, '2024-08-22'),
('Virus X',               4,  'English', 108, 6.6, '2024-09-09'),
('The Last Train',        5,  'Tamil',   135, 8.1, '2024-10-18'),
('Cyber Siege',           7,  'English', 140, 7.7, '2024-11-11'),
('Miracles Happen',       13, 'Hindi',   155, 8.3, '2024-12-05'),
('Wild West Glory',       18, 'English', 148, 7.9, '2025-01-08'),
('The Oracle',            22, 'English', 130, 8.0, '2025-02-01'),
('Grand Theft City',      32, 'English', 122, 7.6, '2025-03-14'),
('Aurora',                5,  'Tamil',   160, 8.5, '2025-04-01'),
('Little Stars',          8,  'English',  90, 7.8, '2025-04-15'),
('Detective Rao',         10, 'Tamil',   138, 8.2, '2025-05-01'),
('Broken Wings',          5,  'Hindi',   125, 7.7, '2025-05-10'),
('Fury Road II',          1,  'English', 150, 8.4, '2025-05-20'),
('Cloud Nine',            34, 'English', 110, 7.3, '2025-05-25'),
('Shadow Protocol',       28, 'English', 145, 8.1, '2024-03-30'),
('Parallel Lives',        6,  'English', 135, 7.9, '2024-07-12'),
('Dynasty Falls',         14, 'Hindi',   162, 8.6, '2024-09-30'),
('Echo Chamber',          22, 'English', 128, 7.5, '2024-11-28');

-- ── TABLE 3: theaters 
INSERT INTO theaters (name, city, state, total_screens) VALUES
('PVR Cinemas - Velachery',          'Chennai',            'Tamil Nadu',         5),
('INOX - Lower Parel',               'Mumbai',             'Maharashtra',        6),
('Cinepolis - Koramangala',          'Bangalore',          'Karnataka',          4),
('Miraj Cinemas - Anna Nagar',       'Chennai',            'Tamil Nadu',         3),
('PVR - Saket',                      'Delhi',              'Delhi',              7),
('Carnival Cinemas - Sion',          'Mumbai',             'Maharashtra',        4),
('SPI Cinemas - Rajajinagar',        'Bangalore',          'Karnataka',          5),
('INOX - Hyderabad',                 'Hyderabad',          'Telangana',          6),
('PVR - Banjara Hills',              'Hyderabad',          'Telangana',          4),
('Cinepolis - Chandigarh',           'Chandigarh',         'Punjab',             3),
('INOX - Jaipur',                    'Jaipur',             'Rajasthan',          5),
('PVR - Pune',                       'Pune',               'Maharashtra',        6),
('Carnival - Ahmedabad',             'Ahmedabad',          'Gujarat',            4),
('Miraj - Surat',                    'Surat',              'Gujarat',            3),
('INOX - Kolkata',                   'Kolkata',            'West Bengal',        5),
('PVR - Salt Lake',                  'Kolkata',            'West Bengal',        4),
('Cinepolis - Bhopal',               'Bhopal',             'Madhya Pradesh',     3),
('SPI - Coimbatore',                 'Coimbatore',         'Tamil Nadu',         4),
('INOX - Lucknow',                   'Lucknow',            'Uttar Pradesh',      5),
('PVR - Noida',                      'Noida',              'Uttar Pradesh',      6),
('Carnival - Nagpur',                'Nagpur',             'Maharashtra',        3),
('Cinepolis - Indore',               'Indore',             'Madhya Pradesh',     4),
('INOX - Kochi',                     'Kochi',              'Kerala',             5),
('PVR - Thiruvananthapuram',         'Thiruvananthapuram', 'Kerala',             3),
('Miraj - Mysore',                   'Mysore',             'Karnataka',          2),
('INOX - Vadodara',                  'Vadodara',           'Gujarat',            4),
('PVR - Rajkot',                     'Rajkot',             'Gujarat',            3),
('Cinepolis - Guwahati',             'Guwahati',           'Assam',              2),
('SPI - Madurai',                    'Madurai',            'Tamil Nadu',         3),
('INOX - Vizag',                     'Visakhapatnam',      'Andhra Pradesh',     4),
('PVR - Vijayawada',                 'Vijayawada',         'Andhra Pradesh',     3),
('Carnival - Patna',                 'Patna',              'Bihar',              2),
('Cinepolis - Ranchi',               'Ranchi',             'Jharkhand',          2),
('INOX - Raipur',                    'Raipur',             'Chhattisgarh',       3),
('PVR - Bhubaneswar',                'Bhubaneswar',        'Odisha',             4),
('SPI - Trichy',                     'Tiruchirappalli',    'Tamil Nadu',         2),
('Miraj - Salem',                    'Salem',              'Tamil Nadu',         2),
('INOX - Amritsar',                  'Amritsar',           'Punjab',             3),
('Cinepolis - Ludhiana',             'Ludhiana',           'Punjab',             3),
('PVR - Agra',                       'Agra',               'Uttar Pradesh',      2),
('Carnival - Varanasi',              'Varanasi',           'Uttar Pradesh',      2),
('INOX - Nashik',                    'Nashik',             'Maharashtra',        3),
('Cinepolis - Aurangabad',           'Aurangabad',         'Maharashtra',        3),
('SPI - Pondicherry',                'Pondicherry',        'Pondicherry',        2),
('PVR - Manali Mall',                'Manali',             'Himachal Pradesh',   1),
('INOX - Dehradun',                  'Dehradun',           'Uttarakhand',        3),
('Cinepolis - Shimla',               'Shimla',             'Himachal Pradesh',   2),
('PVR - Jodhpur',                    'Jodhpur',            'Rajasthan',          3),
('INOX - Udaipur',                   'Udaipur',            'Rajasthan',          2),
('Carnival - Mangalore',             'Mangalore',          'Karnataka',          3);
select * from theaters;
-- ── TABLE 4
INSERT INTO screens (theater_id, screen_name, total_seats, screen_type) VALUES
(1,  'Screen 1', 120, '2D'),
(1,  'Screen 2', 100, '3D'),
(1,  'Screen 3', 150, 'IMAX'),
(2,  'Screen 1', 130, '2D'),
(2,  'Screen 2', 110, '3D'),
(2,  'Screen 3', 160, 'IMAX'),
(3,  'Screen 1', 120, '2D'),
(3,  'Screen 2', 100, '3D'),
(4,  'Screen 1', 110, '2D'),
(4,  'Screen 2',  90, '3D'),
(5,  'Screen 1', 140, '2D'),
(5,  'Screen 2', 120, '3D'),
(5,  'Screen 3', 180, 'IMAX'),
(6,  'Screen 1', 100, '2D'),
(6,  'Screen 2',  80, '3D'),
(7,  'Screen 1', 130, '2D'),
(7,  'Screen 2', 110, '3D'),
(7,  'Screen 3', 170, 'IMAX'),
(8,  'Screen 1', 120, '2D'),
(8,  'Screen 2', 100, '3D'),
(9,  'Screen 1', 110, '2D'),
(9,  'Screen 2',  95, '3D'),
(10, 'Screen 1', 100, '2D'),
(10, 'Screen 2',  85, '3D'),
(11, 'Screen 1', 130, '2D'),
(11, 'Screen 2', 115, '3D'),
(12, 'Screen 1', 145, '2D'),
(12, 'Screen 2', 120, '3D'),
(12, 'Screen 3', 175, 'IMAX'),
(13, 'Screen 1', 100, '2D'),
(13, 'Screen 2',  90, '3D'),
(14, 'Screen 1',  95, '2D'),
(14, 'Screen 2',  80, '3D'),
(15, 'Screen 1', 130, '2D'),
(15, 'Screen 2', 110, '3D'),
(16, 'Screen 1', 120, '2D'),
(16, 'Screen 2', 100, '3D'),
(17, 'Screen 1',  90, '2D'),
(17, 'Screen 2',  80, '3D'),
(18, 'Screen 1', 100, '2D'),
(18, 'Screen 2',  85, '3D'),
(19, 'Screen 1', 125, '2D'),
(19, 'Screen 2', 110, '3D'),
(20, 'Screen 1', 140, '2D'),
(20, 'Screen 2', 120, '3D'),
(20, 'Screen 3', 165, 'IMAX'),
(21, 'Screen 1',  95, '2D'),
(22, 'Screen 1', 105, '2D'),
(23, 'Screen 1', 130, '2D'),
(24, 'Screen 1',  90, '2D');

-- ── TABLE 5	

INSERT INTO seats (screen_id, row_label, seat_number, seat_type) VALUES
(1,'A',1,'Standard'),(1,'A',2,'Standard'),(1,'B',1,'Premium'),(1,'B',2,'Premium'),(1,'C',1,'Recliner'),
(2,'A',1,'Standard'),(2,'A',2,'Standard'),(2,'B',1,'Premium'),(2,'B',2,'Premium'),(2,'C',1,'Recliner'),
(3,'A',1,'Standard'),(3,'A',2,'Standard'),(3,'B',1,'Premium'),(3,'B',2,'Premium'),(3,'C',1,'Recliner'),
(4,'A',1,'Standard'),(4,'A',2,'Standard'),(4,'B',1,'Premium'),(4,'B',2,'Premium'),(4,'C',1,'Recliner'),
(5,'A',1,'Standard'),(5,'A',2,'Standard'),(5,'B',1,'Premium'),(5,'B',2,'Premium'),(5,'C',1,'Recliner'),
(6,'A',1,'Standard'),(6,'A',2,'Standard'),(6,'B',1,'Premium'),(6,'B',2,'Premium'),(6,'C',1,'Recliner'),
(7,'A',1,'Standard'),(7,'A',2,'Standard'),(7,'B',1,'Premium'),(7,'B',2,'Premium'),(7,'C',1,'Recliner'),
(8,'A',1,'Standard'),(8,'A',2,'Standard'),(8,'B',1,'Premium'),(8,'B',2,'Premium'),(8,'C',1,'Recliner'),
(9,'A',1,'Standard'),(9,'A',2,'Standard'),(9,'B',1,'Premium'),(9,'B',2,'Premium'),(9,'C',1,'Recliner'),
(10,'A',1,'Standard'),(10,'A',2,'Standard'),(10,'B',1,'Premium'),(10,'B',2,'Premium'),(10,'C',1,'Recliner');

-- ── TABLE 6
INSERT INTO shows (movie_id, screen_id, show_date, show_time, ticket_price) VALUES
(1,  1,  '2025-06-01', '10:00:00', 220.00),
(2,  2,  '2025-06-01', '13:00:00', 280.00),
(3,  3,  '2025-06-02', '16:00:00', 350.00),
(4,  4,  '2025-06-02', '19:00:00', 260.00),
(5,  5,  '2025-06-03', '11:00:00', 200.00),
(6,  6,  '2025-06-03', '14:30:00', 400.00),
(7,  7,  '2025-06-04', '17:00:00', 180.00),
(8,  8,  '2025-06-04', '20:00:00', 210.00),
(9,  1,  '2025-06-05', '10:30:00', 300.00),
(10, 2,  '2025-06-05', '15:00:00', 240.00),
(11, 3,  '2025-06-06', '09:00:00', 370.00),
(12, 4,  '2025-06-06', '12:00:00', 250.00),
(13, 5,  '2025-06-07', '18:00:00', 190.00),
(14, 6,  '2025-06-07', '21:00:00', 310.00),
(15, 7,  '2025-06-08', '10:00:00', 450.00),
(16, 8,  '2025-06-08', '13:30:00', 220.00),
(17, 9,  '2025-06-09', '16:00:00', 380.00),
(18, 10, '2025-06-09', '19:30:00', 230.00),
(19, 1,  '2025-06-10', '11:00:00', 270.00),
(20, 2,  '2025-06-10', '14:00:00', 290.00),
(21, 3,  '2025-06-11', '10:30:00', 260.00),
(22, 4,  '2025-06-11', '13:00:00', 200.00),
(23, 5,  '2025-06-12', '16:30:00', 420.00),
(24, 6,  '2025-06-12', '20:00:00', 240.00),
(25, 7,  '2025-06-13', '11:00:00', 330.00),
(26, 8,  '2025-06-13', '14:30:00', 210.00),
(27, 9,  '2025-06-14', '09:30:00', 250.00),
(28, 10, '2025-06-14', '12:30:00', 290.00),
(29, 1,  '2025-06-15', '15:00:00', 220.00),
(30, 2,  '2025-06-15', '18:30:00', 260.00),
(31, 3,  '2025-06-16', '10:00:00', 310.00),
(32, 4,  '2025-06-16', '13:00:00', 400.00),
(33, 5,  '2025-06-17', '16:00:00', 230.00),
(34, 6,  '2025-06-17', '19:00:00', 200.00),
(35, 7,  '2025-06-18', '11:30:00', 280.00),
(36, 8,  '2025-06-18', '14:30:00', 310.00),
(37, 9,  '2025-06-19', '09:00:00', 270.00),
(38, 10, '2025-06-19', '12:00:00', 240.00),
(39, 1,  '2025-06-20', '15:30:00', 360.00),
(40, 2,  '2025-06-20', '19:00:00', 290.00),
(41, 3,  '2025-06-21', '10:00:00', 350.00),
(42, 4,  '2025-06-21', '13:30:00', 210.00),
(43, 5,  '2025-06-22', '16:00:00', 320.00),
(44, 6,  '2025-06-22', '20:00:00', 260.00),
(45, 7,  '2025-06-23', '11:00:00', 190.00),
(46, 8,  '2025-06-23', '14:00:00', 280.00),
(47, 9,  '2025-06-24', '09:30:00', 300.00),
(48, 10, '2025-06-24', '12:30:00', 230.00),
(49, 1,  '2025-06-25', '15:00:00', 270.00),
(50, 2,  '2025-06-25', '18:00:00', 340.00);

-- ── TABLE 7
INSERT INTO customers (full_name, email, phone, dob, joined_on) VALUES
('Arjun Sharma',       'arjun.sharma@email.com',       '9876543210', '1995-03-12', '2023-01-10 10:00:00'),
('Priya Nair',         'priya.nair@email.com',         '9123456780', '1998-07-24', '2023-02-15 11:30:00'),
('Rahul Verma',        'rahul.verma@email.com',        '9988776655', '1993-11-05', '2023-03-20 09:00:00'),
('Sneha Patel',        'sneha.patel@email.com',        '9871234560', '2000-01-30', '2023-04-05 14:00:00'),
('Karthik Raja',       'karthik.raja@email.com',       '9345678901', '1997-06-18', '2023-05-12 16:00:00'),
('Divya Menon',        'divya.menon@email.com',        '9456789012', '1996-09-14', '2023-06-18 12:00:00'),
('Vikram Singh',       'vikram.singh@email.com',       '9567890123', '1990-12-22', '2023-07-22 08:30:00'),
('Ananya Das',         'ananya.das@email.com',         '9678901234', '2001-04-08', '2023-08-30 17:00:00'),
('Rohit Gupta',        'rohit.gupta@email.com',        '9789012345', '1994-08-16', '2023-09-14 13:00:00'),
('Meera Krishnan',     'meera.krishnan@email.com',     '9890123456', '1999-02-27', '2023-10-01 10:30:00'),
('Aditya Joshi',       'aditya.joshi@email.com',       '9012345678', '1992-05-19', '2023-10-15 09:45:00'),
('Kavya Reddy',        'kavya.reddy@email.com',        '9111222333', '2002-10-11', '2023-11-01 11:00:00'),
('Siddharth Roy',      'siddharth.roy@email.com',      '9222333444', '1988-03-25', '2023-11-20 15:30:00'),
('Lakshmi Iyer',       'lakshmi.iyer@email.com',       '9333444555', '1991-07-07', '2023-12-05 10:00:00'),
('Nikhil Bose',        'nikhil.bose@email.com',        '9444555666', '2003-11-30', '2024-01-08 14:00:00'),
('Pooja Agarwal',      'pooja.agarwal@email.com',      '9555666777', '1996-04-15', '2024-01-25 16:30:00'),
('Suresh Kumar',       'suresh.kumar@email.com',       '9666777888', '1985-08-09', '2024-02-10 09:00:00'),
('Riya Malhotra',      'riya.malhotra@email.com',      '9777888999', '2000-06-20', '2024-02-28 12:00:00'),
('Tushar Desai',       'tushar.desai@email.com',       '9888999000', '1993-12-01', '2024-03-15 11:00:00'),
('Nandini Rao',        'nandini.rao@email.com',        '9000111222', '1998-09-18', '2024-03-30 17:00:00'),
('Harish Pillai',      'harish.pillai@email.com',      '9101112131', '1987-02-14', '2024-04-10 08:00:00'),
('Swati Pandey',       'swati.pandey@email.com',       '9211223344', '2001-05-23', '2024-04-25 13:30:00'),
('Ajay Mehta',         'ajay.mehta@email.com',         '9312233445', '1994-10-10', '2024-05-05 10:00:00'),
('Preethi Suresh',     'preethi.suresh@email.com',     '9413344556', '1999-03-03', '2024-05-20 15:00:00'),
('Manish Tiwari',      'manish.tiwari@email.com',      '9514455667', '1990-07-28', '2024-06-01 09:30:00'),
('Shruti Kapoor',      'shruti.kapoor@email.com',      '9615566778', '2002-01-17', '2024-06-18 14:00:00'),
('Deepak Nambiar',     'deepak.nambiar@email.com',     '9716677889', '1986-11-05', '2024-07-02 11:30:00'),
('Aarti Shah',         'aarti.shah@email.com',         '9817788990', '1997-04-22', '2024-07-20 16:00:00'),
('Vivek Chatterjee',   'vivek.chatterjee@email.com',   '9918899001', '1992-08-31', '2024-08-05 10:00:00'),
('Rekha Pillai',       'rekha.pillai@email.com',       '9019900112', '2000-12-15', '2024-08-22 12:00:00'),
('Ganesh Murthy',      'ganesh.murthy@email.com',      '9120011223', '1989-06-06', '2024-09-01 08:30:00'),
('Indu Prasad',        'indu.prasad@email.com',        '9221122334', '1995-02-19', '2024-09-18 14:30:00'),
('Rajan Bhat',         'rajan.bhat@email.com',         '9322233445', '1983-09-12', '2024-10-01 10:00:00'),
('Vinitha George',     'vinitha.george@email.com',     '9423344556', '2003-07-04', '2024-10-15 16:00:00'),
('Sanjay Kulkarni',    'sanjay.kulkarni@email.com',    '9524455667', '1991-11-20', '2024-10-30 13:00:00'),
('Tanya Srivastava',   'tanya.srivastava@email.com',   '9625566778', '1998-05-08', '2024-11-12 09:00:00'),
('Praveen Nair',       'praveen.nair@email.com',       '9726677889', '1986-03-17', '2024-11-28 11:00:00'),
('Geetha Balaji',      'geetha.balaji@email.com',      '9827788990', '2001-08-25', '2024-12-10 15:00:00'),
('Ramesh Choudhary',   'ramesh.choudhary@email.com',   '9928899001', '1994-01-01', '2024-12-25 10:30:00'),
('Bhavana Nair',       'bhavana.nair@email.com',       '9029900112', '1999-09-09', '2025-01-05 12:00:00'),
('Santosh Hegde',      'santosh.hegde@email.com',      '9130011223', '1988-04-30', '2025-01-20 08:00:00'),
('Mythili Varma',      'mythili.varma@email.com',      '9231122334', '2002-12-12', '2025-02-03 14:00:00'),
('Dinesh Babu',        'dinesh.babu@email.com',        '9332233445', '1993-06-27', '2025-02-18 10:00:00'),
('Chandana Menon',     'chandana.menon@email.com',     '9433344556', '1996-10-03', '2025-03-01 16:30:00'),
('Lokesh Reddy',       'lokesh.reddy@email.com',       '9534455667', '1984-02-14', '2025-03-15 09:00:00'),
('Hema Krishnakumar',  'hema.krishnakumar@email.com',  '9635566778', '2000-07-19', '2025-03-30 13:00:00'),
('Arun Venkatesan',    'arun.venkatesan@email.com',    '9736677889', '1990-11-11', '2025-04-10 11:30:00'),
('Nalini Subramaniam', 'nalini.subramaniam@email.com', '9837788990', '1997-03-28', '2025-04-25 15:00:00'),
('Raghav Pillai',      'raghav.pillai@email.com',      '9938899001', '1985-08-16', '2025-05-05 09:30:00'),
('Saranya Balan',      'saranya.balan@email.com',      '9039900112', '2001-06-30', '2025-05-15 14:30:00');

-- ── TABLE 8
INSERT INTO bookings (customer_id, show_id, booked_on, total_amount, status) VALUES
(1,  1,  '2025-05-28 09:15:00', 440.00, 'Confirmed'),
(2,  2,  '2025-05-28 10:30:00', 560.00, 'Confirmed'),
(3,  3,  '2025-05-29 11:00:00', 700.00, 'Confirmed'),
(4,  4,  '2025-05-29 12:45:00', 260.00, 'Cancelled'),
(5,  5,  '2025-05-30 08:20:00', 400.00, 'Confirmed'),
(6,  6,  '2025-05-30 14:00:00', 800.00, 'Confirmed'),
(7,  7,  '2025-05-31 16:30:00', 360.00, 'Pending'),
(8,  8,  '2025-05-31 18:00:00', 420.00, 'Confirmed'),
(9,  9,  '2025-06-01 09:00:00', 600.00, 'Confirmed'),
(10, 10, '2025-06-01 11:30:00', 480.00, 'Pending'),
(11, 11, '2025-06-01 14:00:00', 740.00, 'Confirmed'),
(12, 12, '2025-06-02 09:30:00', 500.00, 'Confirmed'),
(13, 13, '2025-06-02 11:00:00', 380.00, 'Cancelled'),
(14, 14, '2025-06-02 15:00:00', 620.00, 'Confirmed'),
(15, 15, '2025-06-03 10:00:00', 900.00, 'Confirmed'),
(16, 16, '2025-06-03 12:30:00', 440.00, 'Pending'),
(17, 17, '2025-06-03 14:00:00', 760.00, 'Confirmed'),
(18, 18, '2025-06-04 09:00:00', 460.00, 'Confirmed'),
(19, 19, '2025-06-04 11:00:00', 540.00, 'Confirmed'),
(20, 20, '2025-06-04 14:30:00', 580.00, 'Cancelled'),
(21, 21, '2025-06-05 09:15:00', 520.00, 'Confirmed'),
(22, 22, '2025-06-05 11:30:00', 400.00, 'Confirmed'),
(23, 23, '2025-06-05 14:00:00', 840.00, 'Confirmed'),
(24, 24, '2025-06-06 09:00:00', 480.00, 'Pending'),
(25, 25, '2025-06-06 11:00:00', 660.00, 'Confirmed'),
(26, 26, '2025-06-06 14:30:00', 420.00, 'Confirmed'),
(27, 27, '2025-06-07 09:30:00', 500.00, 'Cancelled'),
(28, 28, '2025-06-07 12:00:00', 580.00, 'Confirmed'),
(29, 29, '2025-06-07 15:00:00', 440.00, 'Confirmed'),
(30, 30, '2025-06-08 09:15:00', 520.00, 'Confirmed'),
(31, 31, '2025-06-08 11:30:00', 620.00, 'Confirmed'),
(32, 32, '2025-06-08 14:00:00', 800.00, 'Pending'),
(33, 33, '2025-06-09 09:00:00', 460.00, 'Confirmed'),
(34, 34, '2025-06-09 11:15:00', 400.00, 'Confirmed'),
(35, 35, '2025-06-09 14:00:00', 560.00, 'Cancelled'),
(36, 36, '2025-06-10 09:30:00', 620.00, 'Confirmed'),
(37, 37, '2025-06-10 12:00:00', 540.00, 'Confirmed'),
(38, 38, '2025-06-10 15:00:00', 480.00, 'Confirmed'),
(39, 39, '2025-06-11 09:15:00', 720.00, 'Pending'),
(40, 40, '2025-06-11 11:30:00', 580.00, 'Confirmed'),
(41, 41, '2025-06-11 14:00:00', 700.00, 'Confirmed'),
(42, 42, '2025-06-12 09:00:00', 420.00, 'Confirmed'),
(43, 43, '2025-06-12 11:15:00', 640.00, 'Cancelled'),
(44, 44, '2025-06-12 14:30:00', 520.00, 'Confirmed'),
(45, 45, '2025-06-13 09:00:00', 380.00, 'Confirmed'),
(46, 46, '2025-06-13 11:30:00', 560.00, 'Confirmed'),
(47, 47, '2025-06-13 14:00:00', 600.00, 'Pending'),
(48, 48, '2025-06-14 09:15:00', 460.00, 'Confirmed'),
(49, 49, '2025-06-14 11:30:00', 540.00, 'Confirmed'),
(50, 50, '2025-06-14 14:00:00', 680.00, 'Confirmed');

-- ── TABLE 9
INSERT INTO booking_seats (booking_id, seat_id) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10),
(11,11),(12,12),(13,13),(14,14),(15,15),
(16,16),(17,17),(18,18),(19,19),(20,20),
(21,21),(22,22),(23,23),(24,24),(25,25),
(26,26),(27,27),(28,28),(29,29),(30,30),
(31,31),(32,32),(33,33),(34,34),(35,35),
(36,36),(37,37),(38,38),(39,39),(40,40),
(41,41),(42,42),(43,43),(44,44),(45,45),
(46,46),(47,47),(48,48),(49,49),(50,50);

-- ── TABLE 10: payments — 50 rows ─────────────────────────────
INSERT INTO payments (booking_id, payment_method, payment_status, paid_amount, paid_on, transaction_ref) VALUES
(1,  'UPI',         'Success',  440.00, '2025-05-28 09:16:00', 'TXN10001'),
(2,  'Credit Card', 'Success',  560.00, '2025-05-28 10:31:00', 'TXN10002'),
(3,  'Debit Card',  'Success',  700.00, '2025-05-29 11:01:00', 'TXN10003'),
(4,  'Wallet',      'Refunded', 260.00, '2025-05-29 13:10:00', 'TXN10004'),
(5,  'Net Banking', 'Success',  400.00, '2025-05-30 08:21:00', 'TXN10005'),
(6,  'UPI',         'Success',  800.00, '2025-05-30 14:01:00', 'TXN10006'),
(7,  'Debit Card',  'Pending',    0.00,  NULL,                  NULL),
(8,  'Credit Card', 'Success',  420.00, '2025-05-31 18:01:00', 'TXN10008'),
(9,  'UPI',         'Success',  600.00, '2025-06-01 09:01:00', 'TXN10009'),
(10, 'Wallet',      'Pending',    0.00,  NULL,                  NULL),
(11, 'Net Banking', 'Success',  740.00, '2025-06-01 14:01:00', 'TXN10011'),
(12, 'UPI',         'Success',  500.00, '2025-06-02 09:31:00', 'TXN10012'),
(13, 'Credit Card', 'Refunded', 380.00, '2025-06-02 11:30:00', 'TXN10013'),
(14, 'Debit Card',  'Success',  620.00, '2025-06-02 15:01:00', 'TXN10014'),
(15, 'UPI',         'Success',  900.00, '2025-06-03 10:01:00', 'TXN10015'),
(16, 'Wallet',      'Pending',    0.00,  NULL,                  NULL),
(17, 'Net Banking', 'Success',  760.00, '2025-06-03 14:01:00', 'TXN10017'),
(18, 'UPI',         'Success',  460.00, '2025-06-04 09:01:00', 'TXN10018'),
(19, 'Credit Card', 'Success',  540.00, '2025-06-04 11:01:00', 'TXN10019'),
(20, 'Debit Card',  'Refunded', 580.00, '2025-06-04 15:00:00', 'TXN10020'),
(21, 'UPI',         'Success',  520.00, '2025-06-05 09:16:00', 'TXN10021'),
(22, 'Wallet',      'Success',  400.00, '2025-06-05 11:31:00', 'TXN10022'),
(23, 'Net Banking', 'Success',  840.00, '2025-06-05 14:01:00', 'TXN10023'),
(24, 'UPI',         'Pending',    0.00,  NULL,                  NULL),
(25, 'Credit Card', 'Success',  660.00, '2025-06-06 11:01:00', 'TXN10025'),
(26, 'Debit Card',  'Success',  420.00, '2025-06-06 14:31:00', 'TXN10026'),
(27, 'Wallet',      'Refunded', 500.00, '2025-06-07 10:00:00', 'TXN10027'),
(28, 'UPI',         'Success',  580.00, '2025-06-07 12:01:00', 'TXN10028'),
(29, 'Net Banking', 'Success',  440.00, '2025-06-07 15:01:00', 'TXN10029'),
(30, 'Credit Card', 'Success',  520.00, '2025-06-08 09:16:00', 'TXN10030'),
(31, 'UPI',         'Success',  620.00, '2025-06-08 11:31:00', 'TXN10031'),
(32, 'Debit Card',  'Pending',    0.00,  NULL,                  NULL),
(33, 'Wallet',      'Success',  460.00, '2025-06-09 09:01:00', 'TXN10033'),
(34, 'Net Banking', 'Success',  400.00, '2025-06-09 11:16:00', 'TXN10034'),
(35, 'UPI',         'Refunded', 560.00, '2025-06-09 14:30:00', 'TXN10035'),
(36, 'Credit Card', 'Success',  620.00, '2025-06-10 09:31:00', 'TXN10036'),
(37, 'Debit Card',  'Success',  540.00, '2025-06-10 12:01:00', 'TXN10037'),
(38, 'UPI',         'Success',  480.00, '2025-06-10 15:01:00', 'TXN10038'),
(39, 'Wallet',      'Pending',    0.00,  NULL,                  NULL),
(40, 'Net Banking', 'Success',  580.00, '2025-06-11 11:31:00', 'TXN10040'),
(41, 'UPI',         'Success',  700.00, '2025-06-11 14:01:00', 'TXN10041'),
(42, 'Credit Card', 'Success',  420.00, '2025-06-12 09:01:00', 'TXN10042'),
(43, 'Debit Card',  'Refunded', 640.00, '2025-06-12 12:00:00', 'TXN10043'),
(44, 'UPI',         'Success',  520.00, '2025-06-12 14:31:00', 'TXN10044'),
(45, 'Wallet',      'Success',  380.00, '2025-06-13 09:01:00', 'TXN10045'),
(46, 'Net Banking', 'Success',  560.00, '2025-06-13 11:31:00', 'TXN10046'),
(47, 'UPI',         'Pending',    0.00,  NULL,                  NULL),
(48, 'Credit Card', 'Success',  460.00, '2025-06-14 09:16:00', 'TXN10048'),
(49, 'Debit Card',  'Success',  540.00, '2025-06-14 11:31:00', 'TXN10049'),
(50, 'UPI',         'Success',  680.00, '2025-06-14 14:01:00', 'TXN10050');

