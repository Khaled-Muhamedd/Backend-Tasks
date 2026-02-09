 use [StackOverflowMini]

--Joining Tables 
--Note : Use StackOverflow Database 
--Question 01 : 
--● Write a query to display all users along with all post types
Select  u.Id, u.DisplayName , p.Title , p.Score
From Users u Cross join Posts p

--Question 02 : 
--● Write a query to retrieve all posts along with their owner's  
--display name and reputation. Only include posts that have an owner. 
Select P.OwnerUserId , U.DisplayName , U.Id
From Posts P inner join Users U
On U.Id = P.OwnerUserId

--Question 03 : 
--●  Write a query to show all comments with their associated post 
--titles. Display the comment text, comment score, and post title. 

Select C.Text , C.Score , P.Title
From Comments C Left join Posts P
On P.Id = C.PostId
where P.Title Is Not Null

--Question 04 : 
--●  Write a query to list all users and their badges (if any). 
--Include users even if they don't have badges. Show display name, 
--badge name, and badge date.

select U.DisplayName , B.Name as [badge name] ,B.Date
From Badges B Right join Users U
On U.Id = B.UserId

--Question 05 : 
--●  Write a query to display all posts along with their comments (if any).
--Include posts that have no comments. Show post title, post  ,score, comment text, and comment score.

select P.Title , P.Score as [post score] , C.Text ,C.Score as [comments score]
From Posts P Left join Comments C
On P.Id = C.PostId

--Question 06 : 
--●  Write a query to show all votes along with their corresponding 
--posts. Include all votes even if the post information is missing. 
--Display vote type ID, creation date, and post title.

select V.VoteTypeId , P.CreationDate , P.Title
From Votes V Left join Posts P
On P.Id = V.PostId

--Question 07 : 
--●  Write a query to find all answers (posts with ParentId) along with 
--their parent question. Show the answer title, answer score, 
--question title, and question score. 

select ChildPost.Title as [child post Title] ,ChildPost.Score as [child post score] 
,ParentPost.Title as [parent post Title] , ParentPost.Score as [parent post score]
From Posts ParentPost join Posts ChildPost
On ParentPost.Id = ChildPost.ParentId

--Question 08 :
--●  Write a query to display all related posts using the PostLinks table. 
--Show the original post title, related post title, and link type ID. 

select P.Title , PL.RelatedPostId , PL.LinkTypeId
From Posts P inner join PostLinks PL
On P.Id = PL.PostId

--Question 09 : 
--●  Write a query to show posts with their authors and the post type 
--name. Display post title, author display name, author reputation,  
--and post type. 

Select P.Title, U.DisplayName ,U.Reputation , PT.Id
From Posts P inner join Users U 
On P.OwnerUserId = U.Id
inner join PostTypes PT
On PT.Id = P.PostTypeId

--Question 10 :   Comments with Posts => comments with users
--●  Write a query to retrieve all comments along with the post title, 
--post author, and the commenter's display name.

select P.OwnerUserId , C.UserId , Users.DisplayName
From Comments C 
inner join Posts P --posts that have comments
On P.Id = C.PostId
inner join Users U --commenters
On U.Id = C.UserId
inner join Users -- Post Owner
On P.Id= P.OwnerUserId

--Question 11 : 
--●  Write a query to display all votes with post information and vote 
--type name. Show post title, vote type name, creation date, and bounty amount.

select P.Title , VT.Name , V.CreationDate , V.BountyAmount
From Votes V inner join Posts P 
On P.Id =V.PostId
inner join VoteTypes VT
On VT.Id = V.VoteTypeId


--Question 12 : 
--● Write a query to show all users along with their posts and 
--comments on those posts. Include users even if they have no 
--posts or comments. Display user name, post title, and comment text.

select U.DisplayName, P.Title, C.Text
From Users U Left join Posts P
On U.Id= P.OwnerUserId
Left join Comments C
On U.Id = C.UserId


--Question 13 : 
--●  Write a query to retrieve posts with their authors, post types, and 
--any badges the author has earned. Show post title, author name, 
--post type, and badge name.

select P.Title, U.DisplayName,PT.Type, B.Name
From Posts P Inner join Users U
On U.Id= P.OwnerUserId
inner join PostTypes PT
On PT.Id = P.PostTypeId
Left join Badges B
On U.Id = B.UserId

--Question 14 : 
--●  Write a query to create a comprehensive report showing:  
--post title, post author name, author reputation, comment text, 
--commenter name, vote type, and vote creation date. Include 
--posts even if they don't have comments or votes. Filter to only 
--show posts with a score greater than 5.

select P.Title , Author.DisplayName as[ author name] , Author.Reputation , C.Text as [comment] , Commenter.DisplayName as[commenter] ,VT.Name as[ vote Type Name]
From Posts P inner join Users Author
On Author.Id=P.OwnerUserId
Left join Comments C
On P.Id= C.PostId
Left join Users Commenter
On Commenter.Id = C.UserId
Left join Votes V
On V.PostId = P.Id
Left join VoteTypes VT
On VT.Id = V.VoteTypeId
where P.Score>5;

