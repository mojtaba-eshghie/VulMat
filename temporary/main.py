import os
import json


def process_json_file(json_file_path):
    with open(json_file_path, 'r') as file:
        data = json.load(file)

    # Dictionary to hold the processed information
    processed_info = {}

    # Loop through each file in the JSON
    for file_name, analysis_info in data.items():
        file_details = {}
        # Loop through each detector for the current file
        for detector, detector_info in analysis_info.items():
            # Check if the analysis was successful
            if detector_info.get("successfull_analysis", False):
                # Extract the vulnerability findings
                file_details[detector] = detector_info.get(
                    "vulnerability_findings", [])
        # If there are details for this file, add them to the processed_info dictionary
        if file_details:
            processed_info[file_name] = file_details

    # At this point, processed_info contains the extracted data
    # You can process this data further as needed
    print(f"Processed {json_file_path}: {processed_info}")

    # For demonstration, just returning the processed data
    return processed_info


def read_and_process_json_files(start_directory):
    for root, dirs, files in os.walk(start_directory):
        for file in files:
            if file == 'vulnerabilities.json':
                json_file_path = os.path.join(root, file)
                # Process the JSON file
                processed_data = process_json_file(json_file_path)
                # Add your processing code here, using the 'processed_data' variable


# Specify the start directory here
start_directory = '/path/to/your/folder'
read_and_process_json_files(start_directory)
