#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Script to tag texts with the Universal Dependencies tagset using SpaCy's
pre-trained models.
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


def tag_texts(file_path: str, model_name: str) -> None:
    """
    Tag each text from the provided file with POS tags using SpaCy's Universal Dependencies model.

    :param file_path: Path to the file containing texts.
    :type file_path: str
    :param model_name: Name of the SpaCy model to use.
    :type model_name: str
    """
    # Ensure the model is downloaded
    _ensure_model_downloaded(model_name)

    # Load the SpaCy model
    nlp = spacy.load(model_name)

    # Check if file exists
    if not os.path.isfile(file_path):
        print(f"File not found: {file_path}")
        return

    # Open the file and process each line
    with open(file_path, 'r', encoding='utf-8') as file:
        texts = file.readlines()
        for i, text in enumerate(texts, start=1):
            doc = nlp(text.strip())
            print(f"Raw Text {i}: {text.strip()}\n")

            tagged_sentence = " ".join([f"{token.text} ({token.tag_})" for token in doc])
            print(f"Tagged Text {i}: {tagged_sentence}\n")

            print("POS Tags:")
            for token in doc:
                print(f"{token.text} -> {token.pos_} ({token.dep_})")
            print("\n" + "-"*40 + "\n")

# Main Execution
if __name__ == "__main__":
    # File containing example STIX-D descriptions
    FILE_PATH = "stixd_examples.txt"
    MODEL_NAME = "en_core_web_sm"

    # Tag the texts in the file
    tag_texts(FILE_PATH, MODEL_NAME)
