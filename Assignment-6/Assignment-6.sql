use [StackOverflowMini]

--Question 01 :
--● Write a query to retrieve the top 15 users with the highest reputation.
--● Display their DisplayName, Reputation, and Location.
--● Order the results by Reputation in descending order

select Top(15) Users.DisplayName, Users.Reputation , Users.Location
From Users
order by Users.Reputation Desc

--Question 02 :
--● Write a query to get the top 10 posts by score, but include
--● all posts that have the same score as the 10th post.
--● Use TOP WITH TIES. Display Title, Score, and ViewCount.

Select Top(10) with Ties Posts.Title , Posts.Score , Posts.ViewCount
From Posts
order by Posts.Score Desc

--Question 03 :
--● Write a query to implement pagination: skip the first 20 users
--● and retrieve the next 10 users when ordered by reputation.
--● Use OFFSET and FETCH. Display DisplayName and Reputation.

select Users.DisplayName , Users.Reputation
From Users
order by Users.Reputation Desc
OFFSET 20 Rows
FETCH Next 10 Rows only

--Question 04:
--● Write a query to assign a unique row number to each post
--● ordered by Score in descending order.
--● Use ROW_NUMBER(). Display the row number, Title, and Score.
--● Only include posts with non-null titles.

select Posts.Title, Posts.Score,
Row_Number() over (order by Posts.Score Desc) as [row number]
From Posts
where Posts.Title Is Not Null

--Question 05 :
--● Write a query to rank users by their reputation using RANK().
--● Display the rank, DisplayName, and Reputation.
--● Explain what happens when two users have the same reputation.

select Users.DisplayName , Users.Reputation,
Rank() over (order by Users.Reputation Desc) as [Rank]
From Users

--Question 06 :
--● Write a query to rank posts by score using DENSE_RANK().
--● Display the dense rank, Title, and Score.
--● Explain how DENSE_RANK differs from RANK.

select Posts.Title , Posts.Score,
Dense_Rank() over (order by Posts.Score Desc) as [ score in dense rank]
From Posts

--Question 07 :
--● Write a query to divide all users into 5 equal groups (quintiles)
--● based on their reputation. Use NTILE(5).
--● Display the quintile number, DisplayName, and Reputation.

select Users.DisplayName , Users.Reputation,
NTILE(5) over (order by Users.Reputation Desc) as [ NTILE Reptation]
From Users

--Question 08 :
--● Write a query to rank posts within each PostTypeId separately.
--● Use ROW_NUMBER() with PARTITION BY.
--● Display PostTypeId, rank within type, Title, and Score.
--● Order by Score descending within each partition.

select Posts.PostTypeId, Posts.Score , Posts.Title,
Row_Number() over (Partition by Posts.PostTypeId order by Posts.Score Desc) as [Row Number]
From Posts