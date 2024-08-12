#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Script to tag texts with the Universal Dependencies tagset using SpaCy's
pre-trained models and save the output to a file.
"""

# Import Standard Library Modules
import os  # Provides functions to interact with the operating system

# Import Third-Party Modules
import spacy  # NLP library in Python
from spacy.cli import download  # Function to download language models

# Functions
def _ensure_model_downloaded(model_name: str) -> None:
    """
    Ensure the specified SpaCy model is downloaded.

    :param model_name: Name of the SpaCy model to check/download.
    :type model_name: str
    """
    try:
        # Try loading the model
        spacy.load(model_name)
    except OSError:
        # If the model is not found, download it
        print(f"{model_name} not found. Downloading the model...")
        download(model_name)


def tag_texts(input_file: str, output_file: str, model_name: str) -> None:
    """
    Tag each text from the provided file with POS tags using SpaCy's Universal Dependencies model
    and save the output to a specified file.

    :param input_file: Path to the file containing texts.
    :type input_file: str
    :param output_file: Path to the file where output will be saved.
    :type output_file: str
    :param model_name: Name of the SpaCy model to use.
    :type model_name: str
    """
    # Ensure the model is downloaded
    _ensure_model_downloaded(model_name)

    # Load the SpaCy model
    nlp = spacy.load(model_name)

    # Check if input file exists
    if not os.path.isfile(input_file):
        print(f"File not found: {input_file}")
        return

    # Open the output file for writing
    with open(output_file, 'w', encoding='utf-8') as output:
        # Open the input file and process each line
        with open(input_file, 'r', encoding='utf-8') as file:
            texts = file.readlines()
            for i, text in enumerate(texts, start=1):
                doc = nlp(text.strip())
                output.write(f"Raw Text {i}: {text.strip()}\n\n")

                tagged_sentence = " ".join([f"{token.text} ({token.tag_})" for token in doc])
                output.write(f"Tagged Text {i}: {tagged_sentence}\n\n")

                output.write("POS Tags:\n")
                for token in doc:
                    output.write(f"{token.text} -> {token.pos_} ({token.dep_})\n")
                output.write("\n" + "-"*40 + "\n\n")

# Main Execution
if __name__ == "__main__":
    # File containing example STIX-D descriptions
    INPUT = "input.txt"
    OUTPUT = "output.txt"
    MODEL_NAME = "en_core_web_sm"

    # Tag the texts in the file and save to output file
    tag_texts(INPUT, OUTPUT, MODEL_NAME)
