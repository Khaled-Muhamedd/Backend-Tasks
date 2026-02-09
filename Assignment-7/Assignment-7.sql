Use StackOverflowMini

--Question 01 :
--Write a query to display all user display names in uppercase 
--along with the length of their display name.
SELECT DisplayName , UPPER(DisplayName) , LEN(DisplayName)
FROM Users

--Question 02 :
--Write a query to show all posts with their titles and calculate 
--how many days have passed since each post was created.
--Use DATEDIFF to calculate the difference from CreationDate to today

SELECT P.Title , DATEDIFF( DAY,P.CreationDate , GETDATE() )
FROM Posts P
WHERE Title IS NOT NULL

--Question 03 :
--Write a query to count the total number of posts for each user.
--Display the OwnerUserId and the count of their posts.
--Only include users who have created posts.

SELECT U.DisplayName , P.OwnerUserId , COUNT(P.Id)
FROM Users U INNER JOIN Posts P 
ON U.Id = P.OwnerUserId 
GROUP BY U.Id

--Solving with partition by

--Question 04:
--Write a query to find users whose reputation is greater than 
--the average reputation of all users. Display their DisplayName 
--and Reputation. Use a subquery in the WHERE clause.

SELECT DisplayName , Reputation
FROM Users
WHERE Reputation >(SELECT AVG(Reputation) FROM Users)

--Question 05 :
--Write a query to display each post title along with the first 
--50 characters of the title. If the title is NULL, replace it 
--with 'No Title'. Use SUBSTRING and ISNULL functions.

SELECT P.Title , SUBSTRING(P.Title , 1 , 50) AS [ST 50 Char OF Titles] , ISNULL(P.Title , 'NO Title') AS IS_NULL 
FROM Posts P

--Question 06 :
--Write a query to calculate the total score and average score 
--for each PostTypeId. Also show the count of posts for each type.
--Only include post types that have more than 100 posts.

SELECT P.PostTypeId , COUNT(*) AS [Total post] , AVG(P.Score) , SUM(P.Score)
FROM Posts P
GROUP BY P.PostTypeId
HAVING COUNT(*) > 100

--Question 07 :
--Write a query to show each user's DisplayName along with 
--the total number of badges they have earned. Use a subquery 
--in the SELECT clause to count badges for each user.

SELECT U.DisplayName , U.Reputation , 
(
SELECT COUNT(*)
FROM Badges B
WHERE U.Id = B.UserId
)
FROM Users U

--Question 08 :
--Write a query to find all posts where the title contains the word 'SQL'. Display the title, score, and format the CreationDate as 'Mon DD, YYYY'. Use CHARINDEX and FORMAT functions.

SELECT P.Title , P.Score , FORMAT(CreationDate ,'dd-MMM-yyyy')
FROM Posts P
WHERE CHARINDEX('SQL' , P.Title) > 0

--Question 09 :
--Write a query to group comments by PostId and calculate:
--Total number of comments
--Sum of comment scores
--Average comment score
--Only show posts that have more than 5 comments.

SELECT PostId , COUNT(*) , SUM(Score) ,AVG(Score)
FROM Comments
GROUP BY PostId
HAVING COUNT(*) > 5




--Question 10 :
--Write a query to find all users whose location is not NULL.
--Display their DisplayName, Location, and calculate their 
--reputation level using IIF: 'High' if reputation > 5000, 
--otherwise 'Normal'.

SELECT U.Reputation , U.DisplayName ,U.Location ,
IIF(U.Reputation > 5000 , 'High' ,'Normal') 
FROM Users U
WHERE U.Location IS NOT NULL

-- Question 11 :
--Write a query using a derived table (subquery in FROM) to:
--. First, calculate total posts and average score per user
--. Then, join with Users table to show DisplayName
--. Only include users with more than 3 posts
--The derived table must have an alias.

SELECT 
U.DisplayName,
PStats.TotalPosts,
PStats.AvgScore
FROM Users U
INNER JOIN(SELECT OwnerUserId,COUNT(*) AS TotalPosts,AVG(Score) AS AvgScore
FROM Posts
GROUP BY OwnerUserId
HAVING COUNT(*) > 3
) AS PStats
ON U.Id = PStats.OwnerUserId;

--Question 12 :
--Write a query to group badges by UserId and badge Name.
--Count how many times each user earned each specific badge.
--Display UserId, badge Name, and the count.
--Only show combinations where a user earned the same badge 
--more than once
SELECT B.UserId , B.Name , COUNT(*)
FROM Badges B
GROUP BY B.UserId
HAVING COUNT(*) > 1

--Question 13 :
--Write a query to display user information along with their 
--account age in years. Use DATEDIFF to calculate years between 
--CreationDate and current date. Round the result to 2 decimal places.
--Also show the absolute value of their DownVotes.
SELECT Id , DisplayName, ROUND(DATEDIFF(DAY, CreationDate, GETDATE()) / 365.0,2) AS AccountAgeYears, ABS(DownVotes) AS DownVotesAbs
FROM Users;

--Question 14 :
--Write a complex query that:
--. Uses a derived table to calculate comment statistics per post
--. Joins with Posts and Users tables
--. Shows: Post Title, Author Name, Author Reputation, 
--Comment Count, and Total Comment Score
--. Filters to only show posts with more than 3 comments 
--and post score greater than 10
--. Uses COALESCE to replace NULL author names with 'Anonymous'

SELECT P.Title , COALESCE(U.DisplayName, 'Anonymous') AS AuthorName,U.Reputation AS AuthorReputation, CStats.CommentCount, CStats.TotalCommentScore
FROM Posts P
INNER JOIN
(
SELECT PostId, COUNT(*) AS CommentCount , SUM(Score) AS TotalCommentScore
FROM Comments
GROUP BY PostId
HAVING COUNT(*) > 3
) AS CStats
ON P.Id = CStats.PostId
LEFT JOIN Users U
ON P.OwnerUserId = U.Id
WHERE P.Score > 10;



