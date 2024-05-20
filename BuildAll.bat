SET msbuild=""

for /f "usebackq tokens=1* delims=: " %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -requires Microsoft.Component.MSBuild`) do (
  if /i "%%i"=="installationPath" set InstallDir=%%j
)

if exist "%ProgramFiles%\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" (
  SET "msbuild=%ProgramFiles%\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
)

if exist "%msbuild%" goto msbuildok
ECHO.
ECHO.
echo Visual Studio 2017 required.
ECHO.
ECHO.
goto error

:msbuildok

"%msbuild%" .\Rampastring.XNAUI.sln /t:Rebuild /p:Platform=Windows /p:Configuration=Release
"%msbuild%" .\Rampastring.XNAUI.sln /t:Rebuild /p:Platform=WindowsGL /p:Configuration=Release
"%msbuild%" .\Rampastring.XNAUI.sln /t:Rebuild /p:Platform=XNAFramework /p:Configuration=Release

:error
exit /B 1