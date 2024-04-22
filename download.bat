@echo off
setlocal EnableDelayedExpansion

rem Function to clone repositories from a given file into a specified folder
:clone_repositories
set "folder_name=%~1" 
set "repos_file=%~2"

rem Check if the folder already exists
if exist "!folder_name!\*" (
    echo The folder !folder_name! already exists.
    exit /b 1
)

rem Create the folder
mkdir "!folder_name!"

rem Check if the file exists
if not exist "!repos_file!" (
    echo The file !repos_file! does not exist.
    exit /b 1
)

rem Read each URL from the file and clone the repository into the folder if it's not cloned yet
for /f "tokens=* delims=" %%url in (!repos_file!) do (
    set "url_http=%%url"
    set "url_http=!url_http:https://=http://!"
    for %%I in ("!url_http!") do (
        set "repo_name=%%~nxI"
        if exist "!folder_name!\!repo_name!" (
            echo The repository !repo_name! is already cloned.
        ) else (
            echo Cloning repository from !url_http! into !folder_name!...
            git clone "!url_http!" "!folder_name!\!repo_name!"
        )
    )
)
exit /b

rem Colors
set "green=[0;32m"
set "red_bg=[0;37;41m"
set "nc=[0m"

rem Call the function with the folder name and file name as arguments
call :clone_repositories "out\repos" "repos.txt"
call :clone_repositories "out\core" "core-repos.txt"
call :clone_repositories "out\core\template" "template-core-repos.txt"
