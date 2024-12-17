#!/bin/bash

# Define colors for logging
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No color

# Helper function to display messages in color
log_message() {
    local COLOR=$1
    local MESSAGE=$2
    echo -e "${COLOR}${MESSAGE}${NC}"
}

log_message $CYAN "Step 1: Running data preprocessing..."
python ./preprocessing/1preproccess_data.py
if [ $? -ne 0 ]; then
    log_message $RED "Error in Step 1: Data preprocessing failed! Exiting."
    exit 1
fi
log_message $GREEN "Step 1: Data preprocessing completed."

log_message $CYAN "Step 2: Running feature extraction..."
python ./preprocessing/2extract_feature.py
if [ $? -ne 0 ]; then
    log_message $RED "Error in Step 2: Feature extraction failed! Exiting."
    exit 1
fi
log_message $GREEN "Step 2: Feature extraction completed."

log_message $CYAN "Step 3: Retrieving similar pairs..."
python ./preprocessing/3retrieve_similar_pair.py
if [ $? -ne 0 ]; then
    log_message $RED "Error in Step 3: Retrieving similar pairs failed! Exiting."
    exit 1
fi
log_message $GREEN "Step 3: Retrieval of similar pairs completed."

log_message $CYAN "Step 4: Running main pipeline..."
python ./main_basic.py --cfg ./config/iu_base.yml --expe_name "trying the whole pipeline with shell command" --gpu 0
if [ $? -ne 0 ]; then
    log_message $RED "Error in Step 4: Main pipeline execution failed! Exiting."
    exit 1
fi
log_message $GREEN "Step 4: Main pipeline executed successfully."

log_message $GREEN "All steps completed successfully!"
exit 0
