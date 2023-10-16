-- Use the albums_db database.
USE albums_db;

-- What is the primary key for the albums table?
DESCRIBE albums;
#The primary key is ID

-- What does the column named 'name' represent?
SELECT name 
FROM albums;

#The name column represents names of albums in the database

-- What do you think the sales column represents?
#I think it represents the amount of albums sold
SELECT sales, name 
FROM albums;

-- Find the name of all albums by Pink Floyd.
SELECT * 
FROM albums 
WHERE artist = 'Pink Floyd';

-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT release_date 
FROM albums 
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

-- What is the genre for the album Nevermind?
SELECT genre 
FROM albums 
WHERE name = "Nevermind";

-- Which albums were released in the 1990s?
SELECT name, release_date 
FROM albums 
WHERE release_date > 1989 AND release_date < 2000;

-- Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT name, sales as low_selling_albums 
FROM albums 
WHERE sales < 20;
