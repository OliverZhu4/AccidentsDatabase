/********************************************************
* Name: Qibang Zhu, Tianyu Han
* Email: qibang.zhu@vanderbilt.edu, tianyu.han@vanderbilt.edu
* Homework: Project 2
*********************************************************/

-- Create Database
DROP DATABASE IF EXISTS accidents;
CREATE DATABASE accidents;

-- Create Megatable
DROP TABLE IF EXISTS megatable;
CREATE TABLE IF NOT EXISTS megatable ( ID VARCHAR(15),
										sources VARCHAR(15),
										TMC decimal(10,1),
                                        Severity INT,
                                        Start_Time DATETIME,
                                        End_Time DATETIME,
                                        Start_Lat decimal(10,6),
                                        Start_Lng decimal(10,6),
                                        End_Lat decimal(10,6),
                                        End_Lng decimal(10,6),
                                        Distance decimal(10,2),
                                        Description text,
                                        Numbers decimal(10,1),
                                        Street VARCHAR(80),
                                        Side VARCHAR(3),
                                        City VARCHAR(30),
                                        County VARCHAR(30),
                                        State VARCHAR(5),
									    Zipcode VARCHAR(20),
                                        Country VARCHAR(10),
                                        Timezone VARCHAR(20),
                                        Airport_Code VARCHAR(10),
                                        Weather_Timestamp VARCHAR(30),
                                        Temperature DECIMAL(5,1),
                                        Wind_Chill DECIMAL(5,1),
                                        Humidity DECIMAL(5,1),
                                        Pressure DECIMAL(5,2),
                                        Visibility DECIMAL(10,5),
                                        Wind_Direction VARCHAR(10),
                                        Wind_Speed DECIMAL(5,1),
                                        Precipitation DECIMAL(5,2),
                                        Weather_Condition VARCHAR(50),
                                        Amenity VARCHAR(10),
                                        Bump VARCHAR(10),
                                        Crossing VARCHAR(10),
                                        Give_Way VARCHAR(10),
                                        Junction VARCHAR(10),
										No_Exit VARCHAR(10),
                                        Railway VARCHAR(10),
                                        Roundabout VARCHAR(10),
                                        Station VARCHAR(10),
                                        Stops VARCHAR(10),
                                        Traffic_Calming VARCHAR(10),
                                        Traffic_Signal VARCHAR(10),
                                        Turning_Loop VARCHAR(10),
                                        Sunrise_Sunset VARCHAR(10),
                                        Civil_Twilight VARCHAR(10),
                                        Nautical_Twilight VARCHAR(10),
                                        Astronomical_Twilight VARCHAR(10));
-- Load Data into megatable
LOAD DATA INFILE 'US_Accidents_June20.csv' 
INTO TABLE megatable
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ID,Sources,@vTMC,Severity,Start_Time,End_Time,@vStart_Lat,@vStart_Lng,@vEnd_Lat,@vEnd_Lng,
Distance,Description,@vNumbers,Street,Side,City,County,State,Zipcode,Country,Timezone,
Airport_Code,Weather_Timestamp,@vTemperature,@vWind_Chill,@vHumidity,@vPressure,@vVisibility,
Wind_Direction,@vWind_Speed,@vPrecipitation,Weather_Condition,Amenity,Bump,Crossing,Give_Way,
Junction,No_Exit,Railway,Roundabout,Station,Stops,Traffic_Calming,Traffic_Signal,
Turning_Loop,Sunrise_Sunset,Civil_Twilight,Nautical_Twilight,Astronomical_Twilight)
SET 
TMC = NULLIF(@vTMC,''),
Start_Lat = NULLIF(@vStart_Lat,''),
Start_Lng = NULLIF(@vStart_Lng,''),
End_Lat = NULLIF(@vEnd_Lat,''),
End_Lng = NULLIF(@vEnd_Lng,''),
Numbers = NULLIF(@vNumbers,''),
Temperature = NULLIF(@vTemperature,''),
Wind_Chill = NULLIF(@vWind_Chill,''),
Humidity = NULLIF(@vHumidity,''),
Pressure = NULLIF(@vPressure,''),
Visibility = NULLIF(@vVisibility,''),
Wind_Speed = NULLIF(@vWind_Speed,''),
Precipitation = NULLIF(@vPrecipitation,'');

-- Create small tables
# Table general_info
DROP TABLE IF EXISTS general_info;
CREATE TABLE IF NOT EXISTS general_info( 
	ID VARCHAR(15) PRIMARY KEY,
	Severity INT,
	Distance decimal(10,2),
    Description text);

# Table data_source
DROP TABLE IF EXISTS data_source;
CREATE TABLE data_source(
	ID VARCHAR(15) PRIMARY KEY,
    sources VARCHAR(15),
    TMC decimal(10,1),
    CONSTRAINT fk_id1 FOREIGN KEY(ID) REFERENCES generalInfo(ID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

# Table location
DROP TABLE IF EXISTS location;
CREATE TABLE IF NOT EXISTS location(	   
	ID VARCHAR(15) PRIMARY KEY,
	Start_Lat decimal(10,6),
	Start_Lng decimal(10,6),
	End_Lat decimal(10,6),
	End_Lng decimal(10,6),
	Distance decimal(10,2),
	Description text,
	Numbers decimal(10,1),
	Street VARCHAR(80),
	Side VARCHAR(3),
	City VARCHAR(30),
	County VARCHAR(30),
	State VARCHAR(5),
	Zipcode VARCHAR(20),
	Country VARCHAR(10),
	Timezone VARCHAR(20),
	Airport_Code VARCHAR(10),
	CONSTRAINT fk_id2 FOREIGN KEY(ID) REFERENCES general_Info(ID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

# Table weather
DROP TABLE IF EXISTS weather;
CREATE TABLE IF NOT EXISTS weather(     
	ID VARCHAR(15) PRIMARY KEY,
	Weather_Timestamp VARCHAR(30),
    Temperature DECIMAL(5,1),
	Wind_Chill DECIMAL(5,1),
	Humidity DECIMAL(5,1),
	Pressure DECIMAL(5,2),
	Visibility DECIMAL(10,5),
	Wind_Direction VARCHAR(10),
	Wind_Speed DECIMAL(5,1),
	Precipitation DECIMAL(5,2),
	Weather_Condition VARCHAR(50),
	CONSTRAINT fk_id3 FOREIGN KEY(ID) REFERENCES general_Info(ID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

# Table roadCondition
DROP TABLE IF EXISTS roadCondition;
CREATE TABLE roadCondition(
	ID VARCHAR(15) PRIMARY KEY,
    Amenity VARCHAR(10),
    Bump VARCHAR(10),
    Crossing VARCHAR(10),
    Give_Way VARCHAR(10),
    Junction VARCHAR(10),
    No_Exit VARCHAR(10),
    Railway VARCHAR(10),
    Roundabout VARCHAR(10),
    Station VARCHAR(10),
    Stops VARCHAR(10),
    Traffic_Calming VARCHAR(10),
    Traffic_Signal VARCHAR(10),
	Turning_Loop VARCHAR(10),
    CONSTRAINT fk_id4 FOREIGN KEY(ID) REFERENCES generalInfo(ID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

# Table acc_time
DROP TABLE IF EXISTS acc_time;
CREATE TABLE acc_time(
	ID VARCHAR(15) PRIMARY KEY,
    Start_Time DATETIME,
    End_Time DATETIME,
    Sunrise_Sunset VARCHAR(10),
    Civil_Twilight VARCHAR(10),
    Nautical_Twilight VARCHAR(10),
    Astronomical_Twilight VARCHAR(10),
    CONSTRAINT fk_id5 FOREIGN KEY(ID) REFERENCES generalInfo(ID)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

-- Insert Data into Decomposed Tables
# Table general_info
INSERT INTO general_info				
SELECT DISTINCT	ID,Severity,Distance,Description
FROM megatable;

# Table data_source
INSERT INTO data_source						
SELECT DISTINCT	ID, sources, TMC
FROM megatable;

# Table location
INSERT INTO location
SELECT DISTINCT ID,Start_Lat, Start_Lng, End_Lat, End_Lng, Distance, Description,
				Numbers, Street,Side, City, County, State, Zipcode, 
                Country, Timezone, Airport_Code
FROM megatable;

# Table weather
INSERT INTO weather 
SELECT DISTINCT ID, Weather_Timestamp, Temperature, Wind_Chill,
				Humidity, Pressure, Visibility, Wind_Direction, 
                Wind_Speed, Precipitation, Weather_Condition
FROM megatable;  

# Table roadCondition
INSERT INTO roadCondition
SELECT DISTINCT ID,Amenity,Bump,Crossing,Give_Way,Junction,No_Exit,
				Railway,Roundabout,Station,Stops,Traffic_Calming,
                Traffic_Signal,Turning_Loop
FROM megatable;  

# Table acc_time
INSERT INTO acc_time
SELECT DISTINCT ID,Start_Time,End_Time,Sunrise_Sunset,
				Civil_Twilight,Nautical_Twilight,Astronomical_Twilight
FROM megatable;                

-- stored procedures #1
# Search by ID					
DROP procedure IF EXISTS getById;

DELIMITER //

CREATE PROCEDURE getById (IN idNum VARCHAR(15))

BEGIN 

SELECT ID, City, State, Description, Severity, Start_Time
FROM megatable
WHERE ID = idNum;

END //

DELIMITER ;

-- stored procudure #2
# Search by City
DROP procedure IF EXISTS getByCity(IN cityName VARCHAR(30))

DELIMITER //

CREATE PROCEDURE getByCity (IN cityName VARCHAR(30))

BEGIN 

SELECT ID, City, State, Description, Severity, Start_Time
FROM megatable
WHERE City = cityName;

END //

DELIMITER ;


-- stored procudure #3
# Delete Accident by ID
DROP PROCEDURE IF EXISTS deleteAccident;

DELIMITER //

CREATE PROCEDURE deleteAccident(IN accID VARCHAR(15))
BEGIN

  DELETE FROM megatable
  WHERE ID = accID;

END//

DELIMITER ;

-- stored procudure #4
# Insert Accident
DROP PROCEDURE IF EXISTS insertAccident;

DELIMITER //

CREATE PROCEDURE insertAccident(IN inaccID VARCHAR(15),IN inCity VARCHAR(30), IN inState VARCHAR(5), IN inDescrip text, IN inSeverity INT,IN inStart DATETIME)
BEGIN

  INSERT INTO megatable
  VALUES(inaccID,NULL,NULL,inSeverity,inStart,NULL,NULL,NULL,NULL,NULL,
NULL,inDescrip,NULL,NULL,NULL,inCity,NULL,inState,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL);

END//

DELIMITER ;


-- stored procudre #5 
# Update database using severity
DROP PROCEDURE IF EXISTS updateSev;

DELIMITER //

CREATE PROCEDURE updateSev(IN upaccID VARCHAR(15), IN upSeverity INT)
BEGIN   
 IF upSeverity < 0 THEN
  SIGNAL SQLSTATE '22003'
  SET MESSAGE_TEXT = 'Severity must be a positive number.',
        MYSQL_ERRNO = 1264;
 END IF;
 UPDATE megatable
    SET Severity = upSeverity
 WHERE ID = upaccID;
 SELECT "Severity successfully updated";
END//
DELIMITER ;


-- Trigger severityCheck
# Severity should not be less than 1
DROP TRIGGER IF EXISTS severityCheck;
DELIMITER //
CREATE TRIGGER severityCheck
BEFORE INSERT
ON megatable
FOR EACH ROW
 IF NEW.Severity < 1 THEN
  SET NEW.Severity = 1;
 END IF;
//             

-- Trigger severityCheck2
# Severity should not be more than 5
DROP TRIGGER IF EXISTS severityCheck2;
DELIMITER //
CREATE TRIGGER severityCheck2
AFTER INSERT
ON megatable
FOR EACH ROW
 IF NEW.Severity > 5 THEN
  SET NEW.Severity = 5;
 END IF;
//                           
  
  
-- view #1 
# Summary report by state
DROP VIEW IF EXISTS state_summary;
CREATE VIEW state_summary AS
SELECT State,
       COUNT(ID) AS Count,
       AVG(severity) AS SeverityAverage
FROM megatable
GROUP BY state;

Select *
from state_summary
order by Count DESC;

-- view #2
# Summary report by city
DROP VIEW IF EXISTS city_summary;
CREATE VIEW city_summary AS
SELECT City,
       COUNT(ID) AS Count,
       AVG(severity) AS SeverityAverage
FROM megatable
GROUP BY city;  

Select *
from city_summary
order by Count DESC;


								