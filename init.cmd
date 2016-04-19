@if "%_echo%"=="" echo off
GOTO :Start
#
#  Corext Environment Initialization
#
#    Setup the environment to be responsive and contained to the commandline
#    https://microsoft.sharepoint.com/teams/corext/LivingDocs/CorextInitialization.aspx
#
:Start

@REM -----------------------------------------------------------------------------------
@REM -- RepoConfig - minimal tool config [anything of size should be packed/shared]
@REM -----------------------------------------------------------------------------------

@REM -- Product being built
SET CorextProduct=[Your Product]

@REM -- Pull packages and setup the enlistment
CALL :ConfigureCorext
IF ERRORLEVEL 1 GOTO :EOF

@REM -- Configure purger with our preferences
SET PURGER=%PURGER% -si -norecycle -i %PackageAddressGenDir:\=\\%.*

@REM -- Corext-Repo-Specific.  You do not want this. Separate file keeps corext-repo info mostly isolated across fork/clone operations
IF EXIST %ROOT%\src\config\corext.init.cmd call %ROOT%\src\config\corext.init.cmd

@REM -----------------------------------------------------------------------------------
GOTO :EOF





@REM -----------------------------------------------------------------------------------
@REM -----------------------------------------------------------------------------------
:ConfigureCorext
@REM -- Standard Corext Bootstrapper
FOR %%I IN (%~dp0\.corext\..) DO @SET ROOT=%%~fI
SET BaseDir=%ROOT%
SET OBJECT_ROOT=%ROOT%\out\obj
SET OBJECT_ROOT=%ROOT%
SET CoreXTConfig=%ROOT%\.corext
SET PackageAddressGenDir=%CoreXTConfig%\gen
IF DEFINED CorextBranch (SET _BUILDBRANCH=%CorextBranch%) ELSE (SET _BUILDBRANCH=%CorextProduct%)
IF NOT DEFINED CoreXTConfigFile SET CoreXTConfigFile=%CoreXTConfig%\corext.config
IF NOT DEFINED PackageAddressGenDir SET PackageAddressGenDir=%ROOT%\out\gen

%CoreXTConfig%\corextBoot.exe init -bootstrap
IF ERRORLEVEL 1 ECHO [Error] CoreXT could not be properly initialized.  This enlistment window will not work. & EXIT /B 1
CALL %PackageAddressGenDir%\init.cmd -recurse
GOTO :EOF
