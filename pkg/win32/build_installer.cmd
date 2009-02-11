@ECHO OFF
SETLOCAL
SET PLATFORM=%1
SET STAGE=%ECELL_STAGING_HOME%\%PLATFORM%\Release
SET PATH=%STAGE%\bin;%PATH%
SET GENERATED_SAMPLE_EML_DIR=%TEMP%\$$%~n0.%RANDOM%$$

MKDIR "%GENERATED_SAMPLE_EML_DIR%"

"%COMSPEC%" /V:ON /C "FOR /D %%D IN ("%STAGE%\doc\samples\*") DO @ECHO OFF && SET DIR=%GENERATED_SAMPLE_EML_DIR%\%%~nxD && IF NOT EXIST "!DIR!" MKDIR "!DIR!" && CD "!DIR!" && FOR %%F IN ("%%D\*.em") DO ECHO Converting %%~nxD\%%~nF.em to %%~nxD\%%~nF.eml ... && @call "%STAGE%\bin\ecell3-em2eml.cmd" -o "%%~nF.eml" "%%F"" 
FOR /F "usebackq" %%A IN (`""%PYTHONHOME%\python" -c import" "sys;import" "os;sys.path.append(os.environ['STAGE']+'\lib\site-packages');import" "ecell.config;print" "ecell.config.version"`) DO SET ECELL_VERSION_NUMBER=%%A
FOR /F "usebackq" %%A IN (`""%PYTHONHOME%\python" -c import" "sys;import" "os;sys.path.append(os.environ['STAGE']+'\lib\site-packages');import" "ecell.config;print" "ecell.config.per_app_dir_name"`) DO SET PKGLIBDIR=%%A

iscc /dPlatform=%PLATFORM% /dPythonVersion=2.4 /dNumpyVersion=1.0.1 /dGtkVersion=2.6 /dVersion=%ECELL_VERSION_NUMBER% /dPkgLibDir=%PKGLIBDIR% /dGeneratedSampleEmlDir=%GENERATED_SAMPLE_EML_DIR% ecell3-installer.iss

GOTO EXIT

:EXIT
RMDIR /Q /S "%GENERATED_SAMPLE_EML_DIR%"
