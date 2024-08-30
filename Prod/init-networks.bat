@echo off
setlocal

:: Set default environment if not defined
if "%ENVIRONMENT%"=="" set ENVIRONMENT=dev

:: Define network based on environment
set NETWORK_NAME=
if "%ENVIRONMENT%"=="dev" set NETWORK_NAME=dev_network
if "%ENVIRONMENT%"=="accept" set NETWORK_NAME=accept_network
if "%ENVIRONMENT%"=="prod" set NETWORK_NAME=prod_network

:: Check for unknown environment
if "%NETWORK_NAME%"=="" (
    echo Unknown environment: %ENVIRONMENT%
    exit /b 1
)

set ENVIRONMENT=%NETWORK_NAME%

:: Create the network if it doesn't already exist
docker network ls | findstr /R /C:"%NETWORK_NAME%" >nul 2>&1 || docker network create %NETWORK_NAME%

:: Start Docker Compose
@REM docker-compose up --build 
docker-compose -p deploy-solution-%ENVIRONMENT% up --build -d

endlocal
