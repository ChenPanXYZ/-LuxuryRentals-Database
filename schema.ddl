-- 1. What constraints from the domain could not be enforced, if any?
-- 	a. We can not make sure that the same property is not on multiple 
--     rentals during a period.
--	b. We can not make sure the rentals have weeks that are consecutive.
-- 2. What constraints that could have been enforced were not enforced, 
--    if any? Why not?
-- 	a. The renter for a rental appears in the stay. We did not enforce this 
--     because we already included renter in rental table, so technically
--     we could have natural join Rental with Stay to get this, but that
--     would require too much computation each time, so we hope the one 
--     inserting the data would always insert renter into Stay..
-- 	b. We can not make sure that by the time of rental the renter 
--     is at least 18 years old. This is because it involves cross 
--     table check and can only be realized with assertion or 
--     trigger.
-- 	c. We can not make sure that the number of guests are bounded by 
--     capacity. This is because it involves cross 
--     table check and can only be realized with assertion or 
--     trigger.



drop schema if exists vacationschema cascade;
create schema vacationschema;
set search_path to vacationschema;

-- The client information, including name, address, birthday and id 
-- assigned to them.
CREATE TABLE Guest(
client_id integer  PRIMARY KEY,
name text NOT NULL,
address text NOT NULL,
birthday date NOT NULL
) ;


-- The credit card number and the owner of the card.
CREATE TABLE CreditCard (
	creditcard_num varchar(16) NOT NULL CHECK (creditcard_num ~* '^[0-9]*'),
	client_id integer NOT NULL REFERENCES Guest,
	PRIMARY KEY (creditcard_num, client_id)
) ;


-- The email address of each host and an id assigned to them.
CREATE TABLE Host (
	host_id integer PRIMARY KEY,
	email_address text NOT NULL
) ;


-- The property information including an id assigned to each property,
-- the host id, bedroom number, bathroom number, capacity, address, 
-- and whether each type of luxury is included.
CREATE TABLE Property(
	property_id integer PRIMARY KEY,
	host_id integer NOT NULL,
	bedroom_num integer NOT NULL CHECK(bedroom_num >=0),
	bathroom_num integer NOT NULL CHECK(bathroom_num >=0),
	capacity integer NOT NULL,
	address text  NOT NULL,
	hot_tub boolean NOT NULL,
	sauna boolean NOT NULL,
	laundry_service boolean NOT NULL,
	daily_cleaning boolean NOT NULL,
	daily_breakfast_delivery boolean NOT NULL,
	concierge_service boolean NOT NULL,
	CHECK (capacity >= bedroom_num),
	CHECK (hot_tub OR sauna OR laundry_service OR daily_cleaning 
OR daily_breakfast_delivery OR concierge_service)
) ;


-- The city property information including the walkability score 
-- and transit type.
CREATE TABLE CityProperty (
	property_id integer PRIMARY KEY REFERENCES Property,
	walkability_score integer NOT NULL
CHECK(walkability_score >=0 AND walkability_score <=100) ,
	transit_type text NOT NULL CHECK(transit_type = 'bus' OR 
	transit_type = 'LRT' 
OR transit_type = 'subway' OR transit_type = 'none')
) ;


-- The water property information including the water type and whether there 
-- is life guarding or not.
CREATE TABLE WaterProperty(
property_id integer NOT NULL REFERENCES Property,
water_type text NOT NULL 
CHECK (water_type = 'beach' OR water_type = 'lake' OR water_type = 'pool'),
lifeguarding boolean NOT NULL,
PRIMARY KEY(property_id, water_type)
) ;


-- Each rental event, including an id assigned to this rental, the property, 
-- renter id, and credit card number.
CREATE TABLE Rental (
	rental_id integer NOT NULL UNIQUE,
	property_id integer NOT NULL REFERENCES Property,
	renter_id integer NOT NULL,
	creditcard_num varchar(16) NOT NULL CHECK (creditcard_num ~* '^[0-9]*'),
	FOREIGN KEY (renter_id, creditcard_num) 
REFERENCES CreditCard(client_id, creditcard_num),
	PRIMARY KEY (rental_id, renter_id)
) ;


-- The guests stayed, including the renter.
CREATE TABLE Stay(
	rental_id integer NOT NULL REFERENCES Rental(rental_id),
	guest_id integer NOT NULL REFERENCES Guest,
	PRIMARY KEY (rental_id, guest_id)
) ;


-- The week of renting, for each renting having more than 1 week, 
-- we record one row for each week.
CREATE TABLE Week (
	start_date date NOT NULL 
CHECK((EXTRACT (ISODOW FROM start_date)) = 6),
	rental_id integer NOT NULL REFERENCES Rental(rental_id),
	price float NOT NULL CHECK(price >=0),
	PRIMARY KEY (rental_id, start_date)
) ;


-- The rating for host given by the renter for each rental.
CREATE TABLE HostRating (
	rental_id integer NOT NULL,
	client_id integer NOT NULL,
	rating integer NOT NULL CHECK(rating >=0 AND rating <= 5),
	FOREIGN KEY (rental_id, client_id) REFERENCES 
	Rental(rental_id, renter_id),
	PRIMARY KEY (rental_id)
) ;


-- The rating for property given by the guests for each rental.
CREATE TABLE PropertyRating (
	rental_id integer NOT NULL,
	client_id integer NOT NULL,
	rating integer NOT NULL CHECK(rating >=0 AND rating <= 5),
	FOREIGN KEY (rental_id, client_id) REFERENCES Stay(rental_id, guest_id),
	PRIMARY KEY (rental_id, client_id)
) ;


-- The comment given by the guests who rated for each rental.
CREATE TABLE Comment (
	rental_id integer NOT NULL,
	client_id integer NOT NULL,
	comment_content text NOT NULL,
	FOREIGN KEY (rental_id, client_id) 
REFERENCES PropertyRating(rental_id, client_id),
	PRIMARY KEY (rental_id, client_id)
) ;
