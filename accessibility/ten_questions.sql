USE PenguinWebsite;

# 1. what is the posted information by the user whose username is JinyuNa?
select user.username, post.*
from user
         inner join post
                    on user.userkey = post.userkeyfk
where user.username = 'JinyuNa';


# 2. What is the number of comments for each user?
select user.userkey, user.username, count(comment.commentkey) as comment_count
from user
         left outer join comment
                         on user.userkey = comment.userkeyfk
group by user.userkey, user.username;



# 3.what is the image count of each site and Date?
SELECT name, Date, COUNT_SITE
FROM Site INNER JOIN
     (
         SELECT siteID, COUNT(*) AS COUNT_SITE
         FROM Image
         GROUP BY siteID
         ORDER BY siteID ASC
     ) AS siteID_COUNT
     ON Site.idSite = siteID
ORDER BY name ASC;

# 4.what is the researchers' journey site and datetime?
SELECT  idParticipate AS journey, Site.name AS siteName, Date, FirstName AS reseacher_FirstName, LastName AS reseacher_LastName
FROM
    (Participate inner join Site
        ON Participate.idParticipate = site.idSite)
        INNER JOIN Researcher
                   ON Participate.researcherKeyFK = Researcher.ResearcherKey;

# 5.How many image is taken by camera "FC300X" ?
SELECT COUNT(*) AS COUNT_SITE
FROM Image INNER JOIN Camera
                      ON Image.camID = Camera.idCamera
WHERE Camera.name = "FC300X";

# 6. What is UAV of each Camera ?
SELECT name, model, weight
FROM Camera LEFT OUTER JOIN UAV
                            ON Camera.idCamera = UAV.camID
ORDER BY Camera.idCamera ASC;




# 7. What are the user names and disliked post titles and contents using "dislike"?
SELECT User.UserName,Title,PostContent
FROM Post INNER JOIN LikeOrDislike INNER JOIN User
                                              ON   Post.PostKey = LikeOrDislike.PostKeyFK
                                                  AND  User.UserKey = Post.UserKeyFK;


# 8. What are the top ten posts and its' content and author?
SELECT User.UserName,PostContent,COUNT(*) AS POPULARITY_POST
FROM  Share INNER JOIN Post INNER JOIN User
                                       ON    Share.PostKeyFK = Post.PostKey
                                           AND   Post.UserKeyFK = User.UserKey
GROUP BY PostKeyFK
ORDER BY POPULARITY_POST DESC
LIMIT 10;


# 9.What are the usernames with more posts than comments? What are their posts and comments?
SELECT UserName,
       IF(POST_.UserKeyFK IS NULL,0,NUM_POST) AS TOTAL_POST,
       IF(COMMENT_.UserKeyFK IS NULL,0,NUM_COMMENT) AS TOTAL_COMMENT
FROM User
         LEFT OUTER JOIN(
    SELECT UserKeyFK,COUNT(*) AS NUM_POST
    FROM Post
    GROUP BY UserKeyFK) AS POST_
                        ON User.UserKey = Post_.UserKeyFK
         LEFT OUTER JOIN(
    SELECT UserKeyFK, COUNT(*) AS NUM_COMMENT
    FROM Comment
    GROUP BY UserKeyFK) AS COMMENT_
                        ON User.UserKey = COMMENT_.UserKeyFK
HAVING TOTAL_POST > TOTAL_COMMENT;


# 10.What are the top 10 most popular posts in a week?
SELECT Title,User.UserName,COUNT(*) AS POPULARITY
FROM   Post INNER JOIN LikeOrDislike INNER JOIN User
                                                ON     Post.PostKey = LikeOrDislike.PostKeyFK
                                                    AND    User.UserKey = Post.UserKeyFK
WHERE  date_sub(curdate(),INTERVAL 7 DAY) <= DATE(LikeOrDislikeCreated)
GROUP  BY PostKeyFK
ORDER  BY POPULARITY
LIMIT  10;

/* 11. link each image to the weather record, where the weather station is closest and time matches best */
select idWeather, time as weather_time, Weather.longitude as weather_long, Weather.latitude as weather_latt, idImage, timestamp as image_time, the_image.longitude as image_long, the_image.latitude as image_latt,
       abs(round(6367000*2*asin(sqrt(pow(sin(((Weather.latitude * pi())/180-(the_image.latitude*pi())/180)/2),2) + cos((the_image.Latitude*pi())/180)*cos((Weather.latitude*pi())/180)*pow(sin(((Weather.longitude*pi())/180-(the_image.longitude * pi())/180)/2), 2))))) as distance
from Weather, (select * from Image where idImage = 5410) as the_image
where the_image.latitude is not null and
      the_image.longitude is not null and
      the_image.timestamp is not null
order by distance, abs(the_image.timestamp-Weather.time)
limit 1;

