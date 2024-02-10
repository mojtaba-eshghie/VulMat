import os
import json


def process_json_file(json_file_path):
    # Placeholder function to process each JSON file
    # You can add your processing logic here
    print(f"Processing {json_file_path}")


def read_and_process_json_files(start_directory):
    for root, dirs, files in os.walk(start_directory):
        for file in files:
            if file == 'vulnerabilities.json':
                json_file_path = os.path.join(root, file)
                # Read the JSON file
                with open(json_file_path, 'r') as json_file:
                    data = json.load(json_file)
                    # Process the JSON file
                    process_json_file(json_file_path)
                    # Add your processing code here, using the 'data' variable


# Specify the start directory here
start_directory = '.'
read_and_process_json_files(start_directory)
