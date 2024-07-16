@echo off
setlocal

rem Set the path to your Node.js executable
set "NODE_EXE=C:\Program Files\nodejs\node.exe"

rem Set the path to g++ compiler
set "GCC_PATH=C:\msys64\ucrt64\bin\g++"

rem Access the full path using ZED_FILE
set "full_path=%ZED_FILE%"

rem Extract filename with extension
for %%f in ("%full_path%") do set "filename_ext=%%~nxf"

rem Extract filename without extension and extension separately
for %%f in ("%filename_ext%") do (
    set "filename=%%~nf"
    set "extension=%%~xf"
)

rem Remove the leading dot from extension
set "extension=%extension:~1%"

echo [Running %filename_ext%]

if /I "%extension%" == "cpp" (
    echo Compiling and running C++ file...
    "%GCC_PATH%" -o "%filename%" "%full_path%" && "%filename%.exe"
) else if /I "%extension%" == "py" (
    echo Running Python file...
    python "%full_path%"
) else if /I "%extension%" == "c" (
    echo Compiling and running C file...
    gcc -o "%filename%" "%full_path%" && "%filename%.exe"
) else if /I "%extension%" == "js" (
    rem Run JavaScript file with Node.js
    echo Running JavaScript file...
    "%NODE_EXE%" "%full_path%"
) else (
    echo Unsupported file type: %extension%
)
pause

endlocal
