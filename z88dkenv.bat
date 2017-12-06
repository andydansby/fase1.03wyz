@echo off
rem *********************************
rem ** z88dk environment variables **
rem *********************************
rem
rem **************************************************
rem ** You can call this file from the command line **
rem ** before running the compiler executables; or  **
rem ** from inside another .bat file using the CALL **
rem ** statement.                                   **
rem **************************************************

IF NOT "%Z88DK_ENV_id074741%"=="" GOTO exit_without_settings
SET PATH=%PATH%;c:\z88dk10
SET Z80_OZFILES=C:\z88dk10\lib
SET ZCCCFG=C:\z88dk10\lib\config
SET PATH=C:\z88dk10\bin;%PATH%
SET Z88DK_ENV_id074741=true
GOTO the_end

:exit_without_settings
rem echo Nothing to set :-)
:the_end