#!/usr/bin/env python
# -*- coding: utf-8 -*-
# app/gen_clex_uuid.py

"""
This script generates a UUID for a given plain text file.
It can generate both UUIDv4 and UUIDv5.
"""

# Import Standard Library Modules
import uuid  # UUID generation
import requests  # HTTP requests to fetch the file
import argparse  # Command-line argument parsing
import hashlib  # Hashing for UUIDv5
import os  # To check if the path is a file

# Define the namespace for UUIDv5
STIX_NAMESPACE = uuid.UUID("00abedb4-aa42-466c-9c01-fed23315a9b7")

# Function to generate UUIDv4
def generate_uuid_v4() -> str:
    """
    Generate a UUIDv4.

    Returns:
        str: The generated UUIDv4 as a string.
    """
    return str(uuid.uuid4())

# Function to generate UUIDv5
def generate_uuid_v5(name: str) -> str:
    """
    Generate a UUIDv5 based on STIX namespace and the given name.

    Args:
        name (str): The name to be hashed.

    Returns:
        str: The generated UUIDv5 as a string.
    """
    return str(uuid.uuid5(STIX_NAMESPACE, name))

# Function to fetch the file content
def fetch_file_content(path: str) -> str:
    """
    Fetch the content of a file from the given path.
    The path can be a URL or a local file.

    Args:
        path (str): The URL or file path of the file to fetch.

    Returns:
        str: The content of the file.
    """
    if os.path.isfile(path):
        with open(path, 'r', encoding='utf-8') as file:
            return file.read()
    else:
        response = requests.get(path)
        response.raise_for_status()
        return response.text

# Function to generate STIX UUID
def generate_stix_uuid(uuid_version: int, object_type: str, path: str) -> str:
    """
    Generate a STIX UUID for the given file path or URL.

    Args:
        uuid_version (int): UUID version (4 or 5).
        object_type (str): Object type.
        path (str): File path or URL to the text file.

    Returns:
        str: The generated STIX identifier.
    """
    file_content = fetch_file_content(path)

    if uuid_version == 5:
        # Generate UUIDv5
        uuid_str = generate_uuid_v5(file_content)
    else:
        # Generate UUIDv4
        uuid_str = generate_uuid_v4()

    # Create the STIX identifier
    stix_identifier = f"{object_type}--{uuid_str}"

    return stix_identifier

# Command-line interface
def main():
    parser = argparse.ArgumentParser(description="Generate a UUID for a given plain text file.")
    parser.add_argument("uuid_version", type=int, nargs='?', default=4, choices=[4, 5], help="UUID version (4 or 5, default: 4)")
    parser.add_argument("object_type", type=str, nargs='?', default="x-stixd-clex", help="Object type (default: x-stixd-clex)")
    parser.add_argument("path", type=str, nargs='?', default="https://raw.githubusercontent.com/Attempto/Clex/20960a5ce07776cb211a8cfb25dc8c81fcdf25e2/clex_lexicon.pl", help="File path or URL to the text file (default: Clex lexicon file)")

    args = parser.parse_args()
    try:
        stix_identifier = generate_stix_uuid(args.uuid_version, args.object_type, args.path)
        print(f"Generated UUID: {stix_identifier.split('--')[1]}")
        print(f"STIX Identifier: {stix_identifier}")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()

