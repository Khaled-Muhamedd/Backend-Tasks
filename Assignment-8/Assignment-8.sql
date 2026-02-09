use [StackOverflowMini]

--Question 01 :
--Retrieve a list of users who meet at least one of these criteria:
--1. Reputation greater than 8000
--2. Created more than 15 posts
--Display UserId, DisplayName, and Reputation.
--Ensure that each user appears only once in the results.

SELECT U.Id ,U.DisplayName ,U.Reputation
FROM Users U
WHERE U.Reputation > 8000
UNION
SELECT P.Id ,U.DisplayName ,COUNT(P.Id) , U.Reputation
FROM Posts P INNER JOIN Users U 
ON U.Id = P.OwnerUserId
GROUP BY P.OwnerUserId
HAVING COUNT(P.Id) > 15

/*Question 02 :
Find users who satisfy BOTH of these conditions simultaneously:
1. Have reputation greater than 3000
2. Have earned at least 5 badges
Display.*/
SELECT U.Id , U.DisplayName , U.Reputation
FROM Users U INNER JOIN Badges B
ON U.Id = B.UserId
WHERE U.Reputation > 3000
GROUP BY B.UserId
HAVING COUNT(*) > 5

/*Question 03 :
Identify posts that have a score greater than 20 but have never received any comments. Display PostId, Title, and Score.*/
SELECT P.Id , P.Title, P.Score
FROM Posts P LEFT JOIN Comments C
ON P.Id = C.PostId
WHERE P.Score > 20 AND C.Id IS NULL
GROUP BY P.Id

/*Question 04 :
Create a new permanent table called Posts_Backup that stores all posts with a score greater than 10.
The new table should include: Id, Title, Score, ViewCount, CreationDate, OwnerUserId.*/

SELECT Id, Title, Score, ViewCount, CreationDate, OwnerUserId
INTO Posts_Backup
FROM Posts
WHERE Score > 10

/*Question 05 :
Create a new table called ActiveUsers containing users who meet the following criteria:
Reputation greater than 1000
Have created at least one post
 The table should include: UserId, DisplayName, Reputation, Location, and PostCount (calculated).
*/
SELECT U.Id , DisplayName, Reputation, Location , COUNT (P.Id) AS [Total Posts]
FROM Users U INNER JOIN Posts P
ON U.Id = P.OwnerUserId
WHERE U.Reputation > 1000
GROUP BY U.Id ,DisplayName, Reputation, Location
HAVING COUNT(P.Id) > 1

/*Question 06 :
Create a new empty table called Comments_Template that has the exact same structure as the Comments table but contains no data rows.*/

SELECT *
INTO Comments_BackUp
FROM Comments
Where 1 = 4


/*Question 07 :
Create a summary table called PostEngagementSummary that combines data from Posts, Users, and Comments tables.
The table should include:  PostId, Title, AuthorName, Score, ViewCount CommentCount (calculated), TotalCommentScore (calculated)
Include only posts that have received at least 3 comments.*/

SELECT P.Id , P.Title , U.DisplayName , P.Score , P.ViewCount , COUNT(C.Id) AS [Total Comments] , SUM(C.Score) AS[Sum OF Comment Score]
INTO PostEngagementSummary
FROM Posts P INNER JOIN Users U
ON U.Id = P.OwnerUserId
INNER JOIN Comments C
ON P.Id = C.PostId
GROUP BY P.Id , P.Title , U.DisplayName , P.Score , P.ViewCount 
HAVING COUNT(C.Id) >= 3

/*Question 08 :
Develop a reusable calculation that determines the age of a post in days based on its creation date.
Input: CreationDate (DATETIME)
Output: Age in days (INTEGER)
Test your solution by displaying posts with their calculated ages.*/
GO
CREATE OR ALTER FUNCTION CALCDATE(@CreationDate DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Days INT
    SET @Days = DATEDIFF(DAY, @CreationDate, GETDATE())
    RETURN @Days
END
GO

-- Test the function
SELECT 
    Title, 
    CreationDate, 
    dbo.CALCDATE(CreationDate) AS AgeInDays
FROM Posts
WHERE Title IS NOT NULL;
GO

/*Question 09 :
Develop a reusable calculation that assigns a badge level to users based on their reputation and post activity.
Inputs: Reputation (INT), PostCount (INT)
Output: Badge level (VARCHAR)
Logic:
'Gold' if reputation > 10000 AND posts > 50
'Silver' if reputation > 5000 AND posts > 20
'Bronze' if reputation > 1000 AND posts > 5
'None' otherwise */
GO
CREATE OR ALTER FUNCTION IdenRep(@Reputation INT, @PostActivity INT)
RETURNS VARCHAR(40)
AS
BEGIN
    DECLARE @LEVEL VARCHAR(40)

    IF (@Reputation > 10000 AND @PostActivity > 50)
        SET @LEVEL = 'Gold'
    ELSE IF (@Reputation > 5000 AND @PostActivity > 20)
        SET @LEVEL = 'Silver'
    ELSE IF (@Reputation > 1000 AND @PostActivity > 5)
        SET @LEVEL = 'Bronze'
    ELSE
        SET @LEVEL = 'None'

    RETURN @LEVEL
END
GO
--Test
Select U.DisplayName , U.Reputation , P.Score , dbo.IdenRep(U.Reputation , P.Score)
FROM Posts P INNER JOIN Users U 
ON U.Id = P.OwnerUserId

/*Question 10 :
Develop a reusable query that retrieves posts created within a specified number of days from today.
Input: @DaysBack (INT) - number of days to look back
Output: Table with PostId, Title, Score, ViewCount, CreationDate
Test with different day ranges (e.g., 30 days, 90 days).*/
GO

CREATE OR ALTER FUNCTION dbo.PostsWithinDays(@DaysBack INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        Id AS PostId,
        Title,
        Score,
        ViewCount,
        CreationDate
    FROM Posts
    WHERE CreationDate >= DATEADD(DAY, -@DaysBack, GETDATE())
);
GO

-- Test the function for last 30 days
SELECT *
FROM dbo.PostsWithinDays(30)
ORDER BY CreationDate DESC;

-- Test the function for last 90 days
SELECT *
FROM dbo.PostsWithinDays(90)
ORDER BY CreationDate DESC;
GO


/*Question 11 :
Develop a reusable query that finds top users from a specific location or all locations based on reputation threshold.
Inputs: @MinReputation (INT), @Location (VARCHAR)
Output: Table with UserId, DisplayName, Reputation, Location, CreationDate
If @Location is NULL, return users from all locations.
Test with different parameters.*/

GO
CREATE OR ALTER FUNCTION dbo.TopUsersByReputation
(
    @MinReputation INT,
    @Location VARCHAR(100) = NULL  -- Default NULL means all locations
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        Id AS UserId,
        DisplayName,
        Reputation,
        Location,
        CreationDate
    FROM Users
    WHERE Reputation >= @MinReputation
      AND (@Location IS NULL OR Location = @Location)
    ORDER BY Reputation DESC
);
GO

-- Test 1: Users with reputation >= 5000 from all locations
SELECT *
FROM dbo.TopUsersByReputation(5000, NULL);

-- Test 2: Users with reputation >= 3000 from 'Egypt'
SELECT *
FROM dbo.TopUsersByReputation(3000, 'Egypt');
GO


/*Question 12 :
Write a query to find the top 3 highest scoring posts for each PostTypeId.
Use a subquery or CTE with ROW_NUMBER() and PARTITION BY.
Display PostTypeId, Title, Score, and the rank.*/

WITH TopScoring AS
(
SELECT PostTypeId, Title, Score,
ROW_NUMBER() OVER (PARTITION BY PostTypeId ORDER BY Score DESC) AS [Rank]
FROM Posts 
)
SELECT *
FROM TopScoring
WHERE [Rank] > 3

/*Question 13 :
Write a query using a CTE to find all users whose reputation is above the average reputation. The CTE should calculate 
the average reputation first.
Display DisplayName, Reputation, and the average reputation.*/

WITH AvgRep AS
(
SELECT AVG(Reputation) AS [average Reputation]
FROM Users
)
SELECT U.DisplayName, U.Reputation , AP.[average Reputation]
FROM Users U CROSS JOIN AvgRep AP
WHERE U.Reputation > AP.[average Reputation]

/*Question 14 :
Write a query using a CTE to calculate the total number of posts and average score for each user. Then join with the Users table to display: DisplayName, Reputation, TotalPosts, and AvgScore.
Only include users with more than 5 posts*/

WITH UserInfo AS
(
SELECT OwnerUserId , COUNT(Id) AS [Total Posts] ,AVG(Score) AS [Avg score]
FROM Posts
)
SELECT U.DisplayName , U.Reputation , UI.[Total Posts] , UI.[Avg score]
FROM Users U INNER JOIN UserInfo UI
ON U.Id =UI.OwnerUserId
GROUP BY U.Id , U.DisplayName , U.Reputation
HAVING UI.[Total Posts] > 5

/*Question 15 :
Write a query using multiple CTEs:
First CTE: Calculate post count per user
Second CTE: Calculate badge count per user
Then join both CTEs with Users table to show:
DisplayName, Reputation, PostCount, and BadgeCount.
Handle NULL values by replacing them with 0.*/

WITH UserPosts AS
(
SELECT OwnerUserId, COUNT(*) AS[Total Posts]
FROM Posts
),
UserBadges AS
(
SELECT Id , UserId , COUNT(*) AS [Total Badges]
FROM Badges
)
SELECT U.DisplayName , U.Reputation , UP.[Total Posts] , UB.[Total Badges]
FROM Users U INNER JOIN UserPosts UP
ON U.Id = UP.OwnerUserId
INNER JOIN UserBadges UB
ON U.Id = UB.UserId

/*
Question 16 :
Write a recursive CTE to generate a sequence of numbers from 1 to 20. Display the generated numbers.
*/
WITH NumbersCTE AS (
    -- Anchor Member: ????? 1
    SELECT 1 AS Number
    UNION ALL
    -- Recursive Member: ???? ????? ?????? 1
    SELECT Number + 1
    FROM NumbersCTE
    WHERE Number < 20
)
SELECT Number
FROM NumbersCTE;


