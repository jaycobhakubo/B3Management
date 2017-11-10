
--==========================
--==========================
-- AUTHOR: Karlo Camacho
-- DATE: 10/16/2014
-- DESCRIPTION: 
-- This SP accept 3 input from UI (Username ,CurrentPassword, NewPassword).
-- It will return a result-set  of @status and a number of days remaining before it expires.
-- @Status -> (0) SUCCESSFUL
--         -> (1) UNSUCCESSFUL
--		   -> (2) PREVIOUS PASSWORD REUSE
--         -> (3) PASSWORD COMPLEXITY DID NOT MET
-- NOTE:	The password complexity   wil be handle in the Coding. 
--			So Newpassword should already met the all the requirements
--==========================
--=============================

declare 
        @UserName varchar(25),
        @NewPassword varchar(25),
        @Status int 
           


        select @Status = 0, @UserName = 'e', @Newpassword = 'rruu'

		--select * from b3_login
		--select * from [dbo].[B3_PasswordStaff]
		--select * from [dbo].[B3_SecuritySettings]



         --============================================
                                --Let us check if the password met all the required policy.
                                -- Lest us check if the password complexity is on or not
                                declare @IsComplexPasswordIsOn bit , @PasswordLength int
                                set @IsComplexPasswordIsOn = (select UsePasswordComplexity from [dbo].[B3_SecuritySettings])
                                if (@IsComplexPasswordIsOn = 1 and @Status = 0)
	                                begin 
		                                -- Lenght
 
		                                set @PasswordLength = (select MinPasswordLength from [dbo].[B3_SecuritySettings])
		                                if (Len(@NewPassword) < @PasswordLength)
			                                begin
			                                    set @Status = 3
			                                end
		                                --1 Uppercase
		                                else if (@NewPassword = LOWER(@NewPassword) COLLATE Latin1_General_CS_AI  )
			                                begin
				                                set @Status = 3
			                                end
		                                else if (@NewPassword = UPPER(@NewPassword) COLLATE Latin1_General_CS_AI  )
			                                begin
				                                set @Status = 3
			                                end
		                                else if (PATINDEX('%[0-9]%',@NewPassword) = 0)
			                            and (PATINDEX('%[@!#$%&*=_?,./]%', @NewPassword) = 0)
			                            and (charindex('+', @NewPassword) = 0)
			                            and (charindex('-', @NewPassword) = 0)
			                            and (charindex('\', @NewPassword) = 0)
                                            begin
				                                set @Status = 3
			                                end		
	                                end
                                else if (@IsComplexPasswordIsOn = 0 and @Status = 0)
	                                begin

		                                set @PasswordLength = (select MinPasswordLength from [dbo].[B3_SecuritySettings])
		                                if (Len(@NewPassword) < @PasswordLength)
			                                begin
			                                    set @Status = 3
			                                end
	                                end

                                --============================================
                                --Let us check if the password can be reused
                                declare @LoginID int
                                set @LoginID = (Select LoginID from dbo.B3_Login where UserName = @UserName) --Username shoould be unique if not then we have an issue

                                declare @IsPasswordReusable bit; --1 YES 0 NO
                                set @IsPasswordReusable = (select dbo.b3_fnCheckReusepassword(@LoginID, @NewPassword))
                                if (@IsPasswordReusable = 0 and @Status = 0)
	                                begin
		                                set @Status = 2
	                                end

                                --==================================
                                --Let us update the table 
                                if (@Status = 0)
                                begin
	                                update dbo.B3_Login
	                                set UserPassword = @NewPassword
	                                ,ChangePasswordActualDate =  getdate()--record the datetime it was changed.
	                                where LoginID = @LoginID

	                                update B3_PasswordStaff
	                                set IsCurrent = 0
	                                where LoginId = @LoginID

                                 --It wil not record a duplicate password
	                                    if not  exists (select PasswordUsed from B3_PasswordStaff where LoginID = @LoginID and PasswordUsed = @NewPassword )
	                                    begin
		                                    insert into B3_PasswordStaff (LoginID, PasswordUsed, IsCurrent, DateUsed)
		                                    values (@LoginID, @NewPassword, 1, getdate())
		                                    end
	                                    else
	                                    begin
		                                    update B3_PasswordStaff
		                                    set IsCurrent = 1
		                                    ,DateUsed = getdate()
		                                    where LoginId = @LoginID
		                                    and PasswordUsed = @NewPassword
	                                    end

                                end