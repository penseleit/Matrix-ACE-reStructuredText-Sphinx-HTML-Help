@ECHO OFF

pushd %~dp0

REM Command file for Sphinx documentation

if "%SPHINXBUILD%" == "" (
	set SPHINXBUILD=sphinx-build
)
set SOURCEDIR=.
set VER=1.0.0
set BUILDDIR=docs
set SPHINXOPTS=-c gettingstarted
set PDFFILE="Matrix ACE User Guide.pdf"
set USERGUIDE=Matrix_ACE_User_Guide
set SPHINXPROJ=Matrix ACE
set ZIPSUBFOLDER=zip
set BUILDSUBFOLDER=pdf

if "%1" == "" goto help

%SPHINXBUILD% >NUL 2>NUL
if errorlevel 9009 (
	echo.
	echo.The 'sphinx-build' command was not found. Make sure you have Sphinx
	echo.installed, then set the SPHINXBUILD environment variable to point
	echo.to the full path of the 'sphinx-build' executable. Alternatively you
	echo.may add the Sphinx directory to PATH.
	echo.
	echo.If you don't have Sphinx installed, grab it from
	echo.http://sphinx-doc.org/
	exit /b 1
)


rem Reset SPHNXOPTS to null
set SPHINXOPTS=

rem Build to appropriate subfolder
set BUILDSUBFOLDER=

if "%1" == "rinoh" (
	set BUILDSUBFOLDER=pdf
)

rem Set other Sphinx parameters
if NOT "%2" == "" (
	set SPHINXOPTS=%2
)

echo.Building Sphinx %SPHINXPROJ% project with %1 parameter - output to %BUILDDIR%\%BUILDSUBFOLDER% folder
echo.%SPHINXBUILD% -b %1 %SOURCEDIR% %BUILDDIR%\%BUILDSUBFOLDER% %SPHINXOPTS%

%SPHINXBUILD% -b %1 %SOURCEDIR% %BUILDDIR%\%BUILDSUBFOLDER% %SPHINXOPTS%

rem Zip html files
if "%1" == "html" (
	echo. Zip html files - output to %BUILDDIR%\%ZIPSUBFOLDER% folder
	echo. Test for %BUILDDIR%\%ZIPSUBFOLDER% folder
	if NOT EXIST "%BUILDDIR%\%ZIPSUBFOLDER%\" (
		mkdir %BUILDDIR%\%ZIPSUBFOLDER%
		echo. %BUILDDIR%\%ZIPSUBFOLDER% folder created
	)

	echo. Call PowerShell to zip html files
	PowerShell Compress-Archive -Path "%BUILDDIR%\%BUILDSUBFOLDER%" -DestinationPath "%BUILDDIR%\%ZIPSUBFOLDER%\%USERGUIDE%_%VER%_%1.zip" -Force
)
goto end


:help
echo.
echo.Usage:
echo.Use 'make.bat html' to output multi-page HTML User Guide
echo.Use 'make.bat rinoh' to output the PDF User Guide
echo.Use 'make.bat gettingstarted' to output the PDF Getting Started Guide
echo.
%SPHINXBUILD% -M help

:end
popd
