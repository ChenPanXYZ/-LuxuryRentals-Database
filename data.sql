-- client_id, name, address, birthday
INSERT INTO Guest VALUES
(1, 'Darth Vader', 'Death Star', '1985-12-06'),
(2, 'Leia, Princess', 'Alderaan', '2001-10-05'),
(3, 'Romeo Montague', 'Verona', '1988-05-11'),
(4, 'Juliet Capulet', 'Verona', '1991-07-24'),
(5, 'Mercutio', 'Verona', '1988-03-03'),
(6, 'Chewbacca', 'Kashyyyk', '1998-09-15');


-- creditcard_num, client_id
INSERT INTO CreditCard VALUES
('3466704824219330', 1),
('6011253896008199', 2),
('5446447451075463', 3),
('4666153163329984', 5),
('6011624297465933', 6);


-- host_id, email_address
INSERT INTO Host VALUES
(1, 'luke@gmail.com'),
(2, 'leia@gmail.com'),
(3, 'han@gmail.com');


-- property_id, host_id, bedroom_num, bathroom_num, capacity, address, 
-- hot_tub, sauna, laundry_service, daily_cleaning, daily_breakfast_delivery, 
-- concierge_service
INSERT INTO Property VALUES
(1, 1, 3, 1, 6, 'Tatooine', true, false, false, true, false, false),
(2, 2, 1, 1, 2, 'Alderaan', true, true, false, true, false, false),
(3, 3, 2, 1, 3, 'Corellia', false, false, false, false, true, true),
(4, 2, 2, 1, 2, 'Verona', false, false, true, false, false, false),
(5, 3, 2, 2, 4, 'Florence', true, false, false, false, false, false),
(6, 1, 1, 1, 2, 'Toronto', true, true, true, true, false, true);

-- property_id, walkability_score, transit_type
INSERT INTO CityProperty VALUES
(3, 20, 'bus');


-- property_id, water_type, lifeguarding
INSERT INTO WaterProperty VALUES
(2, 'lake', false);


-- rental_id, property_id, renter_id, creditcard_num
INSERT INTO Rental VALUES
(1, 2, 1, '3466704824219330'),
(2, 3, 2, '6011253896008199'),
(3, 2, 3, '5446447451075463'),
(4, 5, 5, '4666153163329984'),
(5, 5, 6, '6011624297465933');


-- rental_id, guest_id
INSERT INTO Stay VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(2, 4),
(3, 3),
(3, 4),
(4, 5),
(4, 3),
(4, 1),
(5, 6),
(5, 2);


-- start_date: timestamp, rental_id, price
INSERT INTO Week VALUES
('2019-01-05', 1, 580.0),
('2019-01-12', 2, 750.0),
('2019-01-19', 2, 750.0),
('2019-01-12', 3, 600.0),
('2019-01-05', 4, 1000.0),
('2019-01-12', 5, 1220.0);


-- rental_id, client_id, rating
INSERT INTO HostRating VALUES
(1, 1, 2),
(2, 2, 5),
(3, 3, 3),
(4, 5, 4),
(5, 6, 4);

-- rental_id, client_id, rating
INSERT INTO PropertyRating VALUES
(1, 2, 5),
(1, 1, 2),
(2, 2, 1),
(2, 3, 5),
(2, 4, 5),
(3, 4, 5),
(4, 5, 1),
(4, 3, 1),
(5, 6, 3);


-- rental_id, client_id, comment_content
INSERT INTO Comment VALUES
(1, 1, 'Looks like she hides rebel scum here.'),
(2, 2, 'A bit scruffy, could do with more regular housekeeping'),
(5, 6, 'Fantastic, arggg');
