@echo off
setlocal enabledelayedexpansion

:: Define file names
set "CONTAINER_ID_FILE=container_ids.txt"
set "NETWORK_DETAILS_FILE=container_network_details.txt"


:: Retrieve all container IDs and store them in the file
docker ps -q > "%CONTAINER_ID_FILE%"

:: Read container IDs from the file
for /f "tokens=*" %%i in (%CONTAINER_ID_FILE%) do (
    set "CONTAINER_ID=%%i"
    if not "!CONTAINER_ID!"=="" (
        echo Inspecting container: !CONTAINER_ID!

        :: Fetch network details for the container
        for /f "tokens=*" %%j in ('docker inspect --format "{{range.NetworkSettings.Networks}}{{.NetworkID}}: {{.IPAddress}}{{println}}{{end}}" !CONTAINER_ID!') do (
            echo Container ID: !CONTAINER_ID! >> "%NETWORK_DETAILS_FILE%"
            docker inspect --format "Netwok : {{.HostConfig.NetworkMode}} Created:{{.Created}}  Status:{{.State.Status}} Name:{{.Name}}" !CONTAINER_ID! >> "%NETWORK_DETAILS_FILE%"
            @REM echo %%j >> "%NETWORK_DETAILS_FILE%"
        )
        echo --------------------------------- >> "%NETWORK_DETAILS_FILE%"
    )
)

echo Network details have been written to %NETWORK_DETAILS_FILE%

endlocal

