#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
This script generates UUIDs (both UUIDv4 and UUIDv5) for STIX objects based on STIX 2.1 specifications.
"""

# Import Standard Library Modules
import uuid  # UUID generation
import json  # JSON handling
import hashlib  # Hashing for UUIDv5

# Define the namespace for UUIDv5
STIX_NAMESPACE = uuid.UUID("00abedb4-aa42-466c-9c01-fed23315a9b7")

# Function to generate UUIDv5
def generate_uuid_v5(contributing_properties: dict) -> str:
    """
    Generate a UUIDv5 based on STIX namespace and contributing properties.

    Args:
        contributing_properties (dict): The contributing properties as a JSON object.

    Returns:
        str: The generated UUIDv5 as a string.
    """
    name = json.dumps(contributing_properties, separators=(',', ':'), sort_keys=True)  # Ensure canonical JSON representation
    return str(uuid.uuid5(STIX_NAMESPACE, name))

# Function to generate UUIDv4
def generate_uuid_v4() -> str:
    """
    Generate a UUIDv4.

    Returns:
        str: The generated UUIDv4 as a string.
    """
    return str(uuid.uuid4())

# Function to create STIX identifier
def create_stix_identifier(object_type: str, contributing_properties: dict = None) -> str:
    """
    Create a STIX identifier based on the object type and contributing properties.

    Args:
        object_type (str): The type of the STIX object (e.g., 'indicator', 'ipv4-addr').
        contributing_properties (dict, optional): The contributing properties for deterministic ID generation.

    Returns:
        str: The generated STIX identifier.
    """
    if contributing_properties:
        uuid_str = generate_uuid_v5(contributing_properties)
    else:
        uuid_str = generate_uuid_v4()

    return f"{object_type}--{uuid_str}"

# Example usage
if __name__ == "__main__":
    # Example for STIX Domain Object using UUIDv4
    domain_object_type = "indicator"
    domain_object_id = create_stix_identifier(domain_object_type)
    print(f"STIX Domain Object ID: {domain_object_id}")

    # Example for STIX Cyber-observable Object using UUIDv5
    observable_object_type = "ipv4-addr"
    contributing_properties = {
        "value": "198.51.100.3"
    }
    observable_object_id = create_stix_identifier(observable_object_type, contributing_properties)
    print(f"STIX Cyber-observable Object ID: {observable_object_id}")
