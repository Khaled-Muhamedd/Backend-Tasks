use [StackOverflow2010]
--Assignment 11 Stored procedure

/*QUESTION 1
Create a stored procedure named sp_GetRecentBadges that retrieves all badges earned by
users within the last N days.
The procedure should accept one input parameter @DaysBack (INT) to determine how many
days back to search.
Test the procedure using different values for the number of days.*/
GO
CREATE OR ALTER PROCEDURE sp_GetRecentBadges @DaysBack INT
AS 
BEGIN
     SELECT U.Id , U.DisplayName , COUNT(B.Name) AS [Badges Count]
	 FROM Badges B INNER JOIN Users U
	 ON U.Id = B.UserId
	 WHERE B.Date >= DATEDIFF(Day , @DaysBack , GETDATE())
	 GROUP BY U.Id , U.DisplayName
END
GO
--Test execution
sp_GetRecentBadges @DaysBack = 5

/*QUESTION 2
Create a stored procedure named sp_GetUserSummary that retrieves summary statistics for a
specific user.
The procedure should accept @UserId as an input parameter and return the following values
as output parameters:
● Total number of posts created by the user
● Total number of badges earned by the user
● Average score of the user’s posts*/
GO
CREATE OR ALTER PROCEDURE sp_GetUserSummary @UserId INT
AS 
BEGIN
--● Total number of posts created by the user
     SELECT U.DisplayName , P.Title , COUNT(P.Id) , AVG(CAST(P.Score AS DECIMAL(5,2)))
	 FROM Posts P INNER JOIN Users U 
	 ON U.Id = P.OwnerUserId 
	 WHERE U.Id =@UserId
	 GROUP BY U.Id ,U.DisplayName , P.Title
--● Total number of badges earned by the user
     SELECT U.Id , U.DisplayName , B.Name , COUNT(B.Name)
	 FROM Badges B INNER JOIN Users U
	 ON U.Id = B.UserId
	 WHERE B.UserId = @UserId
	 GROUP BY U.Id ,U.DisplayName , B.Name
END
GO
--execution
EXEC sp_GetUserSummary @UserId = 1000

/*QUESTION 3
Create a stored procedure named sp_SearchPosts that searches for posts based on:
● A keyword found in the post title
● A minimum post score*/

GO

CREATE OR ALTER PROCEDURE sp_SearchPosts @KeyWord VARCHAR(100) , @MinScore INT
AS
BEGIN
    SELECT Title , Score
	FROM Posts
	WHERE Title Like '%' + @KeyWord + '%' AND Score>=@MinScore
END
--Execution
GO

/*QUESTION 3
Create a stored procedure named sp_GetUserOrError that retrieves user details by user ID.
If the specified user does not exist, the procedure should raise a meaningful error.
Use TRY...CATCH for proper error handling.*/

CREATE OR ALTER PROCEDURE sp_GetUserOrError @UserId INT
AS
BEGIN
    -- IF ID DOES NOT EXIST
    BEGIN TRY
	IF NOT EXISTS (SELECT 1 FROM Users WHERE id = @UserId)
	  BEGIN 
	  RAISERROR('User With Id %d Does Not Exist', 16 , @UserId)
	  END
	--ELSE
	ELSE
	  SELECT Id , DisplayName 
	  FROM Users 
	  WHERE Id = @UserId
	END TRY

	BEGIN CATCH
	SELECT ERROR_NUMBER() AS [Error code] ,ERROR_MESSAGE() AS [Error Message] , ERROR_SEVERITY() AS [Error severity]
	PRINT 'ERROR HAS OCCURED DURING RETREVING USER'
	END CATCH
END

Go
--Exection


/*QUESTION 4
Create a stored procedure named sp_AnalyzeUserActivity that:
● Calculates an Activity Score for a user using the formula:
Reputation + (Number of Posts × 10)
● Returns the calculated Activity Score as an output parameter
● Returns a result set showing the user’s top 5 posts ordered by score*/

CREATE OR ALTER PROCEDURE sp_AnalyzeUserActivity @Activity INT  , @ActvityScore INT OUTPUT
AS
BEGIN
     -- Activity Calculation 
     SELECT @Activity = U.Reputation + ISNULL( ( COUNT(P.Id) * 10) , 0 )
	 FROM Users U INNER JOIN Posts P
	 ON U.Id = P.OwnerUserId
	 -- Returning top 5 posts
	 SELECT TOP 5 P.Score
	 FROM Users U INNER JOIN Posts P
	 ON U.Id = P.OwnerUserId 
	 ORDER BY Score DESC
END

--Declare Variable 
DECLARE @Scores INT
--Exection

/*QUESTION 5
Create a stored procedure named sp_GetReputationInOut that uses a single input/output
parameter.
The parameter should initially contain a UserId as input and return the corresponding user
reputation as output.*/
GO
CREATE OR ALTER PROCEDURE sp_GetReputationInOut @UserInfo INT OUTPUT
AS
BEGIN
    SELECT Id , Reputation =@UserInfo
	FROM Users
	WHERE Id = @UserInfo
END

GO
--declaration
DECLARE @Info INT
--Execution


/*QUESTION 6
Create a stored procedure named sp_UpdatePostScore that updates the score of a post.
The procedure should:
● Accept a post ID and a new score as input
● Validate that the post exists
● Use transactions and TRY...CATCH to ensure safe updates
● Roll back changes if an error occurs*/
GO

CREATE OR ALTER PROCEDURE sp_UpdatePostScore @PostId INT , @PostScore INT
AS
BEGIN
     BEGIN TRY
	 BEGIN TRANSACTION 
	 -- IF Id Does Not Exists
	   IF NOT EXISTS (SELECT @PostId FROM Posts WHERE Id = @PostId)
	     BEGIN
		   RAISERROR('POST WIHT ID %d DOES NOT EXIST', 16 , @PostId)
		 END
     --ELSE
	 ELSE
	    UPDATE Posts
	    SET Score = @PostScore
	 COMMIT TRANSACTION;
	 END TRY
	 BEGIN CATCH
	    PRINT 'ERROR ' + ERROR_MESSAGE()
	    ROLLBACK;
	 END CATCH
END

GO
--Execution


/*QUESTION 7
Create a stored procedure named sp_GetTopUsersByReputation that retrieves the top N
users whose reputation is above a specified minimum value.
Then create a permanent table named TopUsersArchive and insert the results returned by the
procedure into this table.*/

CREATE OR ALTER PROCEDURE sp_GetTopUsersByReputation @MinReputation INT
AS
BEGIN
    SELECT Id, DisplayName , Reputation
	FROM Users
	WHERE Reputation >= @MinReputation
END

-- Create destination table
CREATE TABLE TopUsers
(
    UserId INT,
    UserName NVARCHAR(40),
    UserReputation INT,
);
INSERT INTO TopUsers(UserId ,UserName ,UserReputation)
EXEC sp_GetTopUsersByReputation @MinReputation = 5000


/*QUESTION 8
Create a stored procedure named sp_InsertUserLog that inserts a new record into a UserLog table.
The procedure should:
● Accept user ID, action, and details as input
● Return the newly created log ID using an output parameter*/
GO
CREATE OR ALTER PROCEDURE sp_InsertUserLog @UserId INT , @UserDetalis VARCHAR(100) ,@LogId INT OUTPUT
AS 
BEGIN
    INSERT INTO UserLogs(UserId,Details)
	VALUES(@UserId ,@UserDetalis)
	SET @LogId = SCOPE_IDENTITY()
END
--craete destination table
CREATE TABLE UserLog (
    LogId INT IDENTITY(1,1) PRIMARY KEY, 
	UserId INT NOT NULL,                 
    Details NVARCHAR(500) NULL,            
	LogDate DATETIME DEFAULT GETDATE()     
);
--Declaration 
DECLARE @NewLog INT
EXEC sp_InsertUserLog @UserId = 1000 , @UserDetalis = 'user loged in from mobile' , @LogId = @NewLog


/*QUESTION 9
Create a stored procedure named sp_UpdateUserReputation that updates a user’s reputation.
The procedure should:
● Validate that the reputation value is not negative
● Validate that the user exists
● Return the number of rows affected
● Handle errors appropriately*/
GO
CREATE OR ALTER PROCEDURE sp_UpdateUserReputation @UserId INT , @NewReputation INT , @RowAffected INT OUTPUT
AS
BEGIN
     BEGIN TRY
	 --check reputation > 0
	 IF @NewReputation < 0
	   BEGIN
	   RAISERROR('Reputation Is Negtive value please enter postive ', 16 , @NewReputation)
	   RETURN
	   END
	  --check if user exist
	  IF NOT EXISTS (Select 1 FROM Users WHERE Id = @UserId)
	    BEGIN
		RAISERROR('User With Id %d Does Not Exists',16 , @UserId)
		RETURN
		END
	--update
	  UPDATE Users
	  Set Reputation = @NewReputation
	  WHERE Id = @UserId
	  SET @RowAffected =@@ROWCOUNT
	  END TRY

	 BEGIN CATCH
	 PRINT 'Error occurred: ' + ERROR_MESSAGE();
	 SET @RowAffected = 0
	 END CATCH

END
--انا مش عايز احفظ عدد الصفوف ف متغير عشان مملاش الرام 

--execution
EXEC sp_UpdateUserReputation @UserId=200 , @NewReputation =5000 , @RowAffected =@@ROWCOUNT


/*QUESTION 10
Create a stored procedure named sp_DeleteLowScorePosts that deletes all posts with a score
less than or equal to a given value.
The procedure should:
● Use transactions
● Return the number of deleted records as an output parameter
● Roll back changes if an error occurs*/
GO
CREATE OR ALTER PROCEDURE sp_DeleteLowScorePosts @PostId INT , @MinScore INT , @RowCount INT OUTPUT
AS
BEGIN
    BEGIN TRY
	    BEGIN TRANSACTION 
		--if post doesn't exist
	    IF NOT EXISTS (SELECT 1 FROM Posts WHERE Id =@PostId)
		  BEGIN
		  RAISERROR('Post With Id %d Does Not Exists' , 16 , @PostId)
		  RETURN
		  END
	    --deletion min scores
		DELETE FROM Posts
		WHERE Score <= @MinScore
        SET @RowCount =@@ROWCOUNT
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT > 0
	ROLLBACK TRANSACTION;
	SET @RowCount = 0 
	PRINT 'NO Transaction happend please check Score Value'
	END CATCH
END
GO
--execution
EXEC sp_DeleteLowScorePosts @PostId = 100 , @MinScore = 400 , @RowCount =@@ROWCOUNT


/*QUESTION 11
Create a stored procedure named sp_BulkInsertBadges that inserts multiple badge records for
a user.
The procedure should:
● Accept a user ID
● Accept a badge count indicating how many badges to insert
● Insert multiple related records in a single operation*/
GO
CREATE OR ALTER PROCEDURE sp_BulkInsertBadges @UserId INT, @BadgeName VARCHAR(100), @LogId INT OUTPUT
AS
BEGIN
    INSERT INTO Badges(UserId, Name, Date)
    VALUES(@UserId, @BadgeName, GETDATE());
    SET @LogId = SCOPE_IDENTITY();
END
--execution 
DECLARE @NewId INT
EXEC sp_BulkInsertBadges @UserId = 200 , @BadgeName = '', @LogId = @NewId


/*QUESTION 12
Create a stored procedure named sp_GenerateUserReport that generates a complete user report.
The procedure should:
➢ Call another stored procedure internally to retrieve user statistics
➢ Combine user profile data and statistics
➢ Return a formatted report including a calculated user level*/
GO
CREATE OR ALTER PROCEDURE sp_GenerateUserReport
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Users WHERE Id = @UserId)
    BEGIN
        RAISERROR('User with Id %d does not exist.', 16, 1, @UserId);
        RETURN;
    END

    DECLARE @Stats TABLE (
        UserId INT,
        QuestionsCount INT,
        AnswersCount INT,
        BadgesCount INT
    );

    INSERT INTO @Stats (UserId, QuestionsCount, AnswersCount, BadgesCount)
    EXEC sp_GetUserStatistics @UserId;

    SELECT 
        u.Id AS UserId,
        u.Name,
        u.Email,
        u.JoinDate,
        s.QuestionsCount,
        s.AnswersCount,
        s.BadgesCount,
        CASE 
            WHEN (s.QuestionsCount + s.AnswersCount + s.BadgesCount) >= 100 THEN 'Expert'
            WHEN (s.QuestionsCount + s.AnswersCount + s.BadgesCount) >= 50 THEN 'Intermediate'
            ELSE 'Beginner'
        END AS UserLevel
    FROM Users u
    INNER JOIN @Stats s ON u.Id = s.UserId
    WHERE u.Id = @UserId;
END

--------------------------- [ Trrigers ] -----------------------------
/*QUESTION 1
Create an AFTER INSERT trigger on the Posts table that logs every new post creation into a
ChangeLog table.
The log should include:
● Table name
● Action type
● User ID of the post owner
● Post title stored as new data*/

CREATE TABLE AuditLog (
    AuditId INT IDENTITY(1,1) PRIMARY KEY,
    TableName VARCHAR(100),
    OperationType VARCHAR(20),
    UserId INT,
    ChangeDate DATETIME DEFAULT GETDATE(),
    OldValue NVARCHAR(MAX),
    NewValue NVARCHAR(MAX),
    Details NVARCHAR(500)
);
GO
CREATE OR ALTER TRIGGER TRG_AfterInsert
ON Posts
AFTER INSERT
AS BEGIN  
      SET NOCOUNT ON
      INSERT INTO AuditLog(TableName , OperationType , UserId , Details )
	  SELECT 'Posts' , 'insertion' , i.OwnerUserId , 'new insertion happend to posts table'
	  FROM inserted i
END

/*QUESTION 2
Create an AFTER UPDATE trigger on the Users table that tracks changes to the Reputation
column.
The trigger should:
● Log changes only when the reputation value actually changes
● Store both the old and new reputation values in the ChangeLog table*/
GO
CREATE OR ALTER TRIGGER TRG_AfterUpdate
ON Users
AFTER UPDATE
AS BEGIN
     SET NOCOUNT ON
    IF UPDATE (Reputation)
	  BEGIN
	  INSERT INTO AuditLog (TableName ,OperationType ,UserId ,OldValue , NewValue ,Details)
	  SELECT 'Users' , 'Update' , i.Id , CAST(d.Reputation AS VARCHAR(MAX)) , CAST(i.Reputation AS VARCHAR(MAX)) , 'new update happend to users table'
	  FROM INSERTED i JOIN DELETED d
	  ON i.Id = d.Id
	  WHERE i.Reputation <> d.Reputation
	  END
END

/*QUESTION 3
Create an AFTER DELETE trigger on the Posts table that archives deleted posts into a
DeletedPosts table.
All relevant post information should be stored before the post is removed.*/
GO
CREATE OR ALTER TRIGGER TRG_AfterDeletion
ON Posts
AFTER DELETION
AS BEGIN
    SET NOCOUNT ON
	INSERT INTO AuditLog(TableName , OperationType, OldValue ,Details)
	SELECT 'Posts', 'deletion' , d.OwnerUserId , 'new deletion at posts Table happend'
	FROM DELETED d
END

/*QUESTION 4
Create an INSTEAD OF INSERT trigger on a view named vw_NewUsers (based on the Users table).
The trigger should:
● Validate incoming data
● Prevent insertion if the DisplayName is NULL or empty*/

--[1] create View for trigger
GO
CREATE OR ALTER VIEW vw_NewUsers
AS
SELECT DisplayName , Reputation , Age
FROM Users u
GO
--[2] Create tirrger => instead of insert at view
CREATE OR ALTER TRIGGER TRG_insteadOfInsertAtView
ON vw_NewUsers
INSTEAD OF INSERT
AS BEGIN
   SET NOCOUNT ON
     --[A] Check if there data => Validate incoming data
	 IF NOT EXISTS (SELECT 1 FROM Inserted)
	     BEGIN 
		   RAISERROR( 'The Data Is not Exist' , 16 , 1 )
		   RETURN
		 END
     --[B] Prevent insertion if the DisplayName is NULL or empty
	 IF EXISTS (SELECT 1 FROM Inserted WHERE DisplayName = NULL)
	     BEGIN 
		   BEGIN TRANSACTION
		   RAISERROR( 'Name Can Not Be NuLL', 16 , 1 )
		   ROLLBACK TRAN
		 END
	 --[C] If Validation were true
      INSERT INTO vw_NewUsers( DisplayName , Reputation , Age )
	  SELECT i.DisplayName , i.Reputation , i.Age
	  FROM inserted i

END
GO

/*QUESTION 5
Create an INSTEAD OF UPDATE trigger on the Posts table that prevents updates to the Id column.
Any attempt to update the Id column should be:
● Blocked
● Logged in the ChangeLog table*/

GO
CREATE OR ALTER TRIGGER TRG_InsteadOfUpdatePosts
ON Posts
INSTEAD OF UPDATE
AS BEGIN
   SET NOCOUNT ON
 -- [A]  Prevention if there is updating to id Colunm
     IF UPDATE (Id)
	   BEGIN
	       INSERT INTO AuditLog(TableName , OperationType , OldValue ,NewValue)
	       Select 'Posts' , 'insert' , d.Id , i.Id
	       FROM Inserted i JOIN Deleted d
	       ON i.Id = d.Id
		   RAISERROR('There Is Not Allowed to Update Id Colunm', 16 , 1)
		   RETURN
       END

--[b] Else
   ELSE
       UPDATE Posts
	   SET Title = i.Title , Body = i.Body , OwnerUserId = i.OwnerUserId
	   FROM Posts p INNER JOIN inserted i
	   ON p.Id = i.Id

END
GO

/*QUESTION 6
Create an INSTEAD OF DELETE trigger on the Comments table that implements a soft
delete mechanism.
Instead of deleting records:
● Add an IsDeleted flag
● Mark records as deleted
● Log the soft delete operation*/

--[1] first alter table comments
ALTER TABLE Comments
ADD IsDeleted BIT DEFAULT 0;
GO
--[2] second Creation the Trigger
CREATE OR ALTER TRIGGER TRG_InsteadOfDeleteComments
ON Comments
INSTEAD OF DELETE
AS BEGIN
    SET NOCOUNT ON
	--[1] 1st Changing the Colunm IsDeleted Make It = 1 and recording it at AuditLog Table 
	 UPDATE Comments
	 SET IsDeleted = 1
	 FROM Comments c INNER JOIN deleted d
	 ON c.Id = d.Id
	--[2] 2nd recording it at auditLog Table
	INSERT INTO AuditLog(TableName , NewValue)
	SELECT 'Comments' , 1  
	FROM deleted
END



/*QUESTION 7
Create a DDL trigger at the database level that prevents any table from being dropped.
All drop table attempts should be logged in the ChangeLog table.*/
GO
--[1] First Create Table to Track Events
CREATE TABLE DDLAuditLog (
    EventId INT IDENTITY(1,1) PRIMARY KEY,
    EventType VARCHAR(100),
    EventDate DATETIME DEFAULT GETDATE(),
    LoginName VARCHAR(100),
    TSQLCommand NVARCHAR(MAX),
    DatabaseName VARCHAR(100)
);
Go
--[2] Create Trigger TO Prevent Dropping Tables
CREATE OR ALTER TRIGGER TRG_PreventDropTables
ON DATABASE
FOR DROP_TABLE
AS BEGIN
   --[1] Declare Variables To catch It And Putting Values at it 
   DECLARE @EventData XML = EVENTDATA()
   DECLARE @EventType VARCHAR(MAX) = @EventData.value('(/EVENT_INSTANCE/EventType)[1]','VARCHAR(MAX)')
   DECLARE @TSQLCommand VARCHAR(MAX)=@EventData.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','VARCAHR(MAX)')
  --[2] INSERT INTO Table To track the events
  INSERT INTO DDLAuditLog(EventType , LoginName ,TSQLCommand ,DatabaseName)
  VALUES(@EventType ,SYSTEM_USER , @TSQLCommand ,DB_NAME())
  --[3] RAISERROR IF THERE IS DROPPING
  BEGIN TRAN
  RAISERROR( 'THERE IS NOT ALLOWED TO DROP TABLES' , 16 , 1)
  ROLLBACK
END
GO
/*QUESTION 8
Create a DDL trigger that logs all CREATE TABLE operations.
The trigger should record:
● The action type
● The full SQL command used to create the table*/
GO
CREATE OR ALTER TRIGGER TRG_trackEvents
ON DATABASE
FOR CREATE_TABLE
AS BEGIN
   SET NOCOUNT ON
   --[1] Declare Variables to catch the it and putting values at it 
   DECLARE @EventData XML = EVENTDATA()
   DECLARE @EventType VARCHAR(MAX) = @EventData.value('(/EVENT_INSTANCE/EventType[1])','VARCAHR(MAX)')
   DECLARE @TSQLCommand VARCHAR(MAX) = @EventData.value('(EVENT_INSTANCE/TSQLCommand/CommandText)[1]','VARCHAR(MAX)')
   --[2] inserting into DDLAuditLog Table To track All Events
   INSERT INTO DDLAuditLog(EventType , LoginName ,TSQLCommand ,DatabaseName)
   VALUES(@EventType ,SYSTEM_USER , @TSQLCommand ,DB_NAME())
END
GO

/*QUESTION 9
Create a DDL trigger that prevents any ALTER TABLE statement that attempts to drop a
column.
All blocked attempts should be logged.*/
GO
CREATE OR ALTER TRIGGER TRG_PreventDropCol
ON DATABASE
FOR ALTER_TABLE
AS BEGIN
   SET NOCOUNT ON
      --[1] Declare Variables to catch the it and putting values at it 
       DECLARE @EventData XML = EVENTDATA()
	   DECLARE @EventType VARCHAR(MAX) = @EventData.value('(/EVENT_INSTANCE/EventType)[1]','VARCAHR(MAX)')
	   DECLARE @TSQLCommand VARCHAR(MAX) = @EventData.value('(EVENT_INSTANCE/TSQLCommand/CommandText)[1]','VARCAHR(MAX)') 
	  --[2] Check IF TSQLCommad Inclues Drop Colunm
	  IF(@TSQLCommand LIKE '%Drop%')
	    BEGIN
		  --if yes => insert into DDLAuditLog Table
		  INSERT INTO DDLAuditLog(EventType ,TSQLCommand ,DatabaseName)
		  VALUES(@EventType ,@TSQLCommand , DB_NAME())
		  --[3] preventing dropping
		  RAISERROR('Dropping columns via ALTER TABLE is not allowed.', 16, 1);
        ROLLBACK;
		END
END
GO
/*QUESTION 10
Create a single trigger on the Badges table that tracks INSERT, UPDATE, and DELETE
operations.
The trigger should:
● Detect the operation type using INSERTED and DELETED tables
● Log the action appropriately in the ChangeLog table*/

CREATE OR ALTER TRIGGER TRG_TrackEventsOnBadges
ON Badges
AFTER INSERT , UPDATE, Delete
AS BEGIN
    --[1] if there is insertion => Log it at auditLog Table
	IF EXISTS (Select 1 From inserted)
	   BEGIN 
	      INSERT INTO AuditLog(TableName ,OperationType , NewValue , Details )
		  SELECT 'Badges' , 'insert' , i.Name , 'There is inserted new value to Name'
		  FROM inserted i
	   END
	 
     --[2] if there is updating => Log it at auditLog Tabl
	 IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 From deleted)
	   BEGIN
          INSERT INTO AuditLog(TableName ,OperationType , OldValue , NewValue , Details)
		  SELECT 'Badges' , 'update' , i.Name , d.Name , 'There exist updating '
		  FROM inserted i INNER JOIN deleted d
		  ON i.Id = d.Id
	   END

	 --[3] if there is updating => Log it at auditLog Tabl
	 IF EXISTS (SELECT 1 From deleted)
	   BEGIN
          INSERT INTO AuditLog(TableName ,OperationType , OldValue , Details)
		  SELECT 'Badges' , 'delete' , d.Name  ,'A New Value Of Name Is Deletd'
		  FROM deleted d
	   END
END

/*QUESTION 11
Create a trigger that maintains summary statistics in a PostStatistics table whenever posts are
inserted, updated, or deleted.
The trigger should update:
● Total number of posts
● Total score
● Average score
for the affected users.*/

--[1] Create Table First
CREATE TABLE PostStatistics
(
    UserId INT PRIMARY KEY,         
    TotalPosts INT DEFAULT 0,     
    TotalScore INT DEFAULT 0,         
    AvgScore DECIMAL(10,2) DEFAULT 0,
    LastUpdated DATETIME DEFAULT GETDATE()
);
--[2] CREATE TRIGGER
GO
CREATE OR ALTER TRIGGER TRG_TrackPostStats
ON Posts
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    --[1] INSERT
    IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO PostStatistics (UserId, TotalPosts, TotalScore, AvgScore)
        SELECT 
            i.OwnerUserId,
            COUNT(*) AS TotalPosts,
            SUM(i.Score) AS TotalScore,
            AVG(CAST(i.Score AS DECIMAL(10,2))) AS AvgScore
        FROM Posts i
        WHERE i.OwnerUserId IN (SELECT DISTINCT OwnerUserId FROM inserted)
        GROUP BY i.OwnerUserId
    END

    --[2] UPDATE
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        UPDATE ps
        SET 
            TotalPosts = sub.TotalPosts,
            TotalScore = sub.TotalScore,
            AvgScore = sub.AvgScore
        FROM PostStatistics ps
        INNER JOIN (
            SELECT 
                p.OwnerUserId,
                COUNT(*) AS TotalPosts,
                SUM(p.Score) AS TotalScore,
                AVG(CAST(p.Score AS DECIMAL(10,2))) AS AvgScore
            FROM Posts p
            WHERE p.OwnerUserId IN (
                SELECT OwnerUserId FROM inserted
                UNION
                SELECT OwnerUserId FROM deleted
            )
            GROUP BY p.OwnerUserId
        ) sub ON ps.UserId = sub.OwnerUserId
    END

    --[3] DELETE
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
       
        UPDATE ps
        SET 
            TotalPosts = sub.TotalPosts,
            TotalScore = sub.TotalScore,
            AvgScore = sub.AvgScore
        FROM PostStatistics ps
        INNER JOIN (
            SELECT 
                p.OwnerUserId,
                COUNT(*) AS TotalPosts,
                SUM(p.Score) AS TotalScore,
                AVG(CAST(p.Score AS DECIMAL(10,2))) AS AvgScore
            FROM Posts p
            WHERE p.OwnerUserId IN (SELECT DISTINCT OwnerUserId FROM deleted)
            GROUP BY p.OwnerUserId
        ) sub ON ps.UserId = sub.OwnerUserId
    END
END;

GO

/*QUESTION 12
Create an INSTEAD OF DELETE trigger on the Posts table that prevents deletion of posts with
a score greater than 100.
Any prevented deletion should be logged.*/
CREATE OR ALTER TRIGGER TRG_PreventDelete
ON Posts
INSTEAD OF DELETE
AS BEGIN 
      --[1] IF the value of score > 100
      IF EXISTS(SELECT 1 FROM Posts WHERE Score > 100)
	     BEGIN
		    INSERT INTO AuditLog(TableName , OperationType , NewValue)
		    SELECT 'Posts' , 'insert' , i.Score
		    FROM inserted i Join Posts p
		    ON i.Id = p.Id
		 END
      --[2] else Prevention by raisError
	  Else
	    BEGIN
		   RAISERROR('can not insert scores smaller than 100', 16 , 1)
	    END
END
