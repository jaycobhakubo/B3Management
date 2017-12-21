USE [B3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[b3_fnCheckCardIfWin]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[b3_fnCheckCardIfWin]
GO

USE [B3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE function [dbo].[b3_fnCheckCardIfWin]
(
@fnDubbedN varchar(500),
@fnPattern varchar(100)
)
returns bit
as
begin
	declare @count int set @count = 1
	declare @result bit set @result = 0

	while (charindex(',',@fnPattern,2) > 1)
	begin 

		declare @pos int 
		set @pos =  charindex(',',@fnPattern,2)
		
		declare @CNumber varchar(5)
		set @CNumber = (substring(@fnPattern,1,@pos))
			
		if (charindex(@CNumber, @fnDubbedN) = 0 )
		begin
			set @result = 0
			break
		end
		
		set @fnPattern = substring(@fnPattern, @pos, len(@fnPattern))
		
			
			if (((len(@fnPattern) - 1)/2) = 0  )
		begin set /*@resultstring = 'youre a winner'*/ @result = 1 end
		set @count = @count + 1
		
	end
	
return @result
end


GO


