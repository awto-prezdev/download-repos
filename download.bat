@echo off
setlocal enabledelayedexpansion

rem Nombre del archivo que contiene las URLs de los repositorios
set repos_file=repos

rem Verifica si el archivo existe
if not exist %repos_file% (
    echo El archivo %repos_file% no existe.
    exit /b 1
)

rem Lee cada URL del archivo y clona el repositorio si no está clonado aún
for /f "tokens=*" %%a in (%repos_file%) do (
    rem Reemplaza "https://" con "http://"
    set "url_http=%%a"
    set "url_http=!url_http:https://=http://!"
    for %%F in ("!url_http!") do (
        set "repo_name=%%~nxF"
    )

    if exist !repo_name! (
        echo El repositorio !repo_name! ya está clonado.
    ) else (
        echo Clonando repositorio desde !url_http!...
        git clone !url_http!
    )
)
