-- 1. Finding five oldest users

SELECT * 
FROM users 
ORDER BY created_at 
limit 5;
-- This query will fetch the data of the first 5 users (ordered by their creation date) from the users table. 
-- Adjust the column names and table name as needed based on your database schema.

-- 2. What day of the week do users register on?

SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
  FROM users
  GROUP BY day
  ORDER BY total DESC
  LIMIT 2;
-- This query will give the two most common days when users signed up 

-- 3. Identify inactive users with no photos?

SELECT username, image_url
   FROM users LEFT JOIN photos on users.id = photos.user_id
   WHERE photos.id IS NULL;
-- This query will give a list of usernames with no photos

-- 4. Find out highest no of like along with username, image_Url and photo_id
SELECT username, photos.id, photos.image_url, 
    COUNT(*) AS total FROM photos
  INNER JOIN likes ON likes.photo_id = photos.id
  INNER JOIN users ON photos.user_id = users.id
  GROUP BY photos.id ORDER BY total DESC
  LIMIT 1;
-- This query will retrieve the username, photo ID, image URL, and total likes for the photo with the highest number of likes in the database

-- 5. Calculate average number of photos per user?

SELECT(SELECT count(*) FROM photos) / (SELECT count(*) FROM users) as average;
-- This query will give us average number of photos per user

-- 6. What are the 5 most commonly used hasgtags?

SELECT tags.tag_name, 
   count(*) AS total FROM photo_tags
   INNER JOIN tags ON photo_tags.tag_id = tags.id
   GROUP BY tags.id ORDER BY total DESC
   LIMIT 5;
-- This query will retrieve the top 5 most frequently used tags along with their respective counts from the photo_tags table.

-- 7. Find users who have liked every single photos?

SELECT username, COUNT(*) AS num_likes FROM users 
   INNER JOIN likes ON users.id = likes.user_id
   GROUP BY likes.user_id
   HAVING num_likes = (SELECT COUNT(*) FROM photos);
-- This SQL query will find users who have liked all photos in the database