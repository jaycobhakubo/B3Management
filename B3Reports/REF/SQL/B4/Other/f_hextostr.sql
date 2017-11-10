USE [B3]
GO

/****** Object:  UserDefinedFunction [dbo].[f_hextostr]    Script Date: 11/4/2014 2:05:16 PM ******/
DROP FUNCTION [dbo].[f_hextostr]
GO

/****** Object:  UserDefinedFunction [dbo].[f_hextostr]    Script Date: 11/4/2014 2:05:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[f_hextostr] (@hexstring VARCHAR(max))
RETURNS VARCHAR(max)

AS

begin
 declare @char1 char(1), @char2 char(1), @strlen int, @currpos int, @result varchar(max)
 set @strlen=len(@hexstring)
 set @currpos=1
 set @result=''
 while @currpos<@strlen
  begin
   set @char1=substring(@hexstring,@currpos,1)
   set @char2=substring(@hexstring,@currpos+1,1)
   if (@char1 between '0' and '9' or @char1 between 'A' and 'F')
    and (@char2 between '0' and '9' or @char2 between 'A' and 'F')
    set @result=@result+
     char((ascii(@char1)-case when @char1 between '0' and '9' then 48 else 55 end)*16+
     ascii(@char2)-case when @char2 between '0' and '9' then 48 else 55 end)
   set @currpos = @currpos+2
  end
 return @result
end

GO


