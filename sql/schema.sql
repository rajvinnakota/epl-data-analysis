CREATE DATABASE epl_db;
USE epl_db;

CREATE TABLE Team_Centric (
    Season VARCHAR(10),        
    Date DATE,                   
    Year SMALLINT,              
    Month TINYINT,              
    MonthName VARCHAR(10),       
    DoW VARCHAR(10),             
    Team VARCHAR(50),            
    Opponent VARCHAR(50),        
    HA ENUM('Home','Away'),     
    GF_Source INT,               
    GA_Source INT,             
    GD_Source INT,               
    RES ENUM('W','D','L'),      
    PTS_Source INT,             
    Home VARCHAR(50),            
    Away VARCHAR(50),            
    `Key` VARCHAR(100),          
    HA_Sort INT                 
);









