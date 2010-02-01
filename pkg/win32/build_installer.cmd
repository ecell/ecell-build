@ECHO OFF
SETLOCAL
SET PLATFORM=%1
SET GENERATED_SAMPLE_EML_DIR=%TEMP%\$$%~n0.%RANDOM%$$
SET PYTHON=%PYTHONHOME%\python
IF NOT EXIST "%PYTHONHOME%" GOTO ERROR_SET_PYTHONHOME
SET TMPOUT=%TEMP%\tmp%RANDOM%
"%PYTHON%" -V 2>"%TMPOUT%"
FOR /F "usebackq tokens=2,3 delims=.\ " %%A IN ("%TMPOUT%") DO SET PY_VER=%%A.%%B
SET ECELL_STAGING_HOME=%ECELL_STAGE%\Python-%PY_VER%\%PLATFORM%\Release
SET PATH=%ECELL_STAGING_HOME%\bin;%PATH%
MKDIR "%GENERATED_SAMPLE_EML_DIR%"
"%COMSPEC%" /V:ON /C "FOR /D %%D IN ("%ECELL_STAGING_HOME%\doc\samples\*") DO @ECHO OFF && SET DIR=%GENERATED_SAMPLE_EML_DIR%\%%~nxD && IF NOT EXIST "!DIR!" MKDIR "!DIR!" && CD "!DIR!" && FOR %%F IN ("%%D\*.em") DO ECHO Converting %%~nxD\%%~nF.em to %%~nxD\%%~nF.eml ... && @call "%ECELL_STAGING_HOME%\bin\ecell3-em2eml.cmd" -o "%%~nF.eml" "%%F""
"%PYTHON%" -c "import sys, os; sys.path.append(os.environ['ECELL_STAGING_HOME']+'\lib\site-packages');import ecell.config;print ecell.config.version" > "%TMPOUT%"
FOR /F "usebackq" %%A IN ("%TMPOUT%") DO SET ECELL_VERSION_NUMBER=%%A
"%PYTHON%" -c "import sys, os;sys.path.append(os.environ['ECELL_STAGING_HOME']+'\lib\site-packages');import ecell.config;print ecell.config.per_app_dir_name" > "%TMPOUT%"
FOR /F "usebackq" %%A IN ("%TMPOUT%") DO SET PKGDIR=%%A
DEL "%TMPOUT%"
ECHO "%ECELL_STAGING_HOME%\doc\COPYING" 
IF "%PLATFORM%" == "x64" (
    SET ARCH_ALLOWED=x64
    SET ARCH64=x64
) ELSE (
    SET ARCH_ALLOWED=x86 x64
    SET ARCH64=
)
iscc /dPlatform=%PLATFORM% /dArchitecturesAllowed="%ARCH_ALLOWED%" /dArchitecturesInstallIn64BitMode=%ARCH64% /dPythonVersion=%PY_VER% /dNumpyVersion=1.0.1 /dGtkVersion=2.6 /dVersion=%ECELL_VERSION_NUMBER% /dPkgDir=%PKGDIR% /dGeneratedSampleEmlDir="%GENERATED_SAMPLE_EML_DIR%" ecell3-installer.iss

GOTO EXIT

:EXIT
RMDIR /Q /S "%GENERATED_SAMPLE_EML_DIR%"
GOTO :EOF

:USAGE
ECHO usage: build_installer.cmd platform
GOTO :EOF

:ERROR_SET_PYTHONHOME
ECHO %%PYTHONHOME%% appears not to be set correctly.
