--==============================
--TEST on usp_sales_b3_Login_EX
--=============================

--==========================
--==========================
-- AUTHOR: Karlo Camacho
-- DATE: 10/16/2014
-- DESCRIPTION: 
-- This SP will accept 8 input from UI (Username and Password).
-- It will return @status ,number of days remaining before it expires and LoginID.
-- @Status -> (0) LOGIN
--         -> (1) UNSUCCESSFUL
--		   -> (2) PASSWORD EXPIRED
--         -> (3) ACCOOUNT LOCKED
--		   -> (4) INACTIVE ACCOUNT
--==========================

USE B3
GO
DECLARE
                        @cClientMac char(12),
                        @cClientName varchar(11),
                        @UserName varchar(25),
                        @Password varchar(25),
                        @cLoginClientName varchar(10),
                        @LoginID int
                        ,@Status int 
                        ,@NofDaysBeforeExp int 

	select 
	   @cClientMac = '',
        @cClientName = '',
        @UserName = 'e',
        @Password = 'rrRR\',
        @cLoginClientName = ''
        --@LoginID int OUTPUT
        --,@Status int output
        --,@NofDaysBeforeExp int output

	--Set variable default
	select @Status = 0
	    , @NofDaysBeforeExp = 0
	    , @LoginID = 0
	
	--Let us set the tempLoginID since we are going to use this a lot
	declare @tempLoginID int;
	set @tempLoginID = (select LoginID from dbo.b3_Login where UserName = @UserName)

	
	
	--Let us check if the user is active
	if exists
		(
		select 1
		from dbo.B3_Login 
		where UserName = @UserName  and EnableUser = 'F'
		) and @Status = 0
		begin 
	
			set @status = 4
		end
	
	--Let us check if the account is locked
	if exists
		(
		select 1
		from dbo.B3_Login 
		where UserName = @UserName  and Locked = 'T' 
		) and @Status = 0
		begin
			--Let us check if its lock due to failed attempt login 
			if exists
			(
			select 1
			from dbo.B3_Login 
			where UserName = @UserName  and Locked = 'T' and LockedDueToLoginFailedAttempt = 'T'  
			)
			begin
				--Let us check if it passed 30 min so we can unlock this user
				declare @IsUnlockeable bit; set  @IsUnlockeable = (select dbo.b3_fnAutoUnlockUser( @tempLoginID))

				if (@IsUnlockeable = 1)
				begin
				    Update b3_Login set lockedDueToLoginFailedAttempt = 'F', Locked = 'F'  where loginID = @tempLoginID
				end
				else
				begin
		
					set @status = 3
				end
			end
			else -- if its lock in security center 
			begin
			    set @status = 3
			end
		end
	
	
	
    --Lets us get the setting for how many days before expiration		
    declare @CurrentDate datetime
    set @CurrentDate = getdate()

    declare @NdaysBeforeExp int;
    set @NdaysBeforeExp = (Select isnull(NPasswordsExpireDays,0) from dbo.B3_SecuritySettings)
	
    declare @PasswordLastTimeChange datetime
    set @PasswordLastTimeChange =  (select ChangePasswordActualDate from [dbo].[B3_Login] where /*LoginID = @LoginID*/ username = @username)
	
 

--Let us check if the username or password is correct if not then 1
	if not exists
		(
		select 1
		from dbo.B3_Login 
		where UserName = @UserName and 
		[UserPassword] COLLATE SQL_Latin1_General_CP1_CS_AS = @Password
		)  and @Status = 0
		begin
			--set @status = 1		

			-- Let us check if its lock due to attemptLogin
			declare @IsLockDueToAttemptLogin varchar(1)
			set @IsLockDueToAttemptLogin = (select isnull(LockedDueToLoginFailedAttempt, 'F') from b3_Login where LoginID = @tempLoginID)
			if (@IsLockDueToAttemptLogin = 'F')
				begin
				
					set @status = 1

				--If not correct let us work on Login attempt 
				--First let us get the NAttamptLogin
				declare @NAttemptLogin int
				set @NAttemptLogin = (select [dbo].[B3_fnGetNAttemptLogin](@tempLoginID)) + 1

				update [dbo].[B3_Login]
				set NofLoginAttempt = @NAttemptLogin
				,LockedDueToAttemptTime = getdate()
				where LoginID =  @tempLoginID

				--Let us check if it reach the max N attemptLogin
				declare @NAttemptBeforeLogout int
				set @NAttemptBeforeLogout = (select PasswordLockoutAttempts from [dbo].[B3_SecuritySettings])
				if (@NAttemptBeforeLogout <= @NAttemptLogin) --If it reach the login attempt then lets lock it 
					begin
						
			
						update [dbo].[B3_Login]
                        set Locked = 'T'
                        ,NofLoginAttempt = 0
                        ,LockedDueToLoginFailedAttempt = 'T'
                        , LockedDueToAttemptTime = getdate()
                        where LoginID = @tempLoginID
					end
				end
				else
					begin
					
						set @status = 3
					end 			
		end


		   --Let us check if ithe paswords is expired	
    if (@NdaysBeforeExp != 0 and @status = 0)
    begin
	    declare @IsPasswordExpired bit
	    set @IsPasswordExpired = (select dbo.b3_fnCheckPassordExpDate(@UserName))
	    if (@IsPasswordExpired = 1)
	    begin 
		    set @status = 2			    
	    end
		set @NofDaysBeforeExp = datediff(day,@CurrentDate, @PasswordLastTimeChange) + @NdaysBeforeExp
    end



    --If Everything passed then lets get the remaining days before expiration

    if(@status = 0)
    begin    	
	    --Exec original SP
	    exec [dbo].[usp_sales_b3_Login]
	    @cClientMac = @cClientMac
	    ,@cClientName = @cClientName  
	    ,@cName = @UserName 
	    ,@cPassword = @Password 
	    ,@cLoginClientName =  @cLoginClientName
	    ,@nLoginID = @LoginID OUTPUT
	end

	select 
@LoginID as LoginID
,@Status as [status]
,@NofDaysBeforeExp as [number of days before expire]

	--set @LoginID = (select LoginID from [dbo].[B3_Login] where /*LoginID = @LoginID*/ username = @username)
	--select @status as [Status], @NofDaysBeforeExp as NofDaysBeforeExp-- I could set the number of days to NULL if its more easier to handle in C++

--=============================
----TEST
--declare @spLoginID int 
--declare @spStatus int
--declare @spNDaysBeforeExp int

--exec usp_sales_b3_Login_EX @UserName = 'a', @Password = 'a', @LoginID = @spLoginID output, @Status = @spStatus  output, @NofDaysBeforeExp = @spNDaysBeforeExp output
--select @spLoginID 
--=============================





GO


