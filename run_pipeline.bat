@echo off
:: Define colors for logging
set "GREEN=0A"
set "CYAN=0B"
set "RED=0C"
set "NC=07"

:: Helper function to display messages in color
call :log_message "CYAN" "Step 1: Running data preprocessing..."
python .\preprocessing\1preproccess_data.py
if %ERRORLEVEL% neq 0 (
    call :log_message "RED" "Error in Step 1: Data preprocessing failed! Exiting."
    exit /b 1
)
call :log_message "GREEN" "Step 1: Data preprocessing completed."

call :log_message "CYAN" "Step 2: Running feature extraction..."
python .\preprocessing\2extract_feature.py
if %ERRORLEVEL% neq 0 (
    call :log_message "RED" "Error in Step 2: Feature extraction failed! Exiting."
    exit /b 1
)
call :log_message "GREEN" "Step 2: Feature extraction completed."

call :log_message "CYAN" "Step 3: Retrieving similar pairs..."
python .\preprocessing\3retrieve_similar_pair.py
if %ERRORLEVEL% neq 0 (
    call :log_message "RED" "Error in Step 3: Retrieving similar pairs failed! Exiting."
    exit /b 1
)
call :log_message "GREEN" "Step 3: Retrieval of similar pairs completed."

call :log_message "CYAN" "Step 4: Running main pipeline..."
python .\main_basic.py --cfg .\config\iu_base.yml --expe_name "trying the whole pipeline with shell command" --gpu 0
if %ERRORLEVEL% neq 0 (
    call :log_message "RED" "Error in Step 4: Main pipeline execution failed! Exiting."
    exit /b 1
)
call :log_message "GREEN" "Step 4: Main pipeline executed successfully."

call :log_message "GREEN" "All steps completed successfully!"
exit /b 0

:: Subroutine for logging messages with colors
:log_message
setlocal
set "COLOR=%~1"
set "MESSAGE=%~2"
echo.
echo %MESSAGE%
endlocal
goto :EOF