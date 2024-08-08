#!/usr/bin/env python
# -*- coding: utf-8 -*-
# app/doc_scrapper.py

"""
Script to scrape HTML content from URLs and convert to Markdown, respecting robots meta tags.
"""

# Import Standard Library Modules
import argparse
import re
import os

# Import Third-Party Modules
from bs4 import BeautifulSoup  # Library for parsing HTML and XML documents
import html2text  # Convert HTML to Markdown
import requests  # HTTP library for Python

# Fetch HTML content from the URL
def fetch_html(url: str) -> str:
    response = requests.get(url)
    response.raise_for_status()
    return response.text

# Extract the body and title from the HTML content
def extract_body_and_title(html: str) -> tuple[str, str]:
    soup = BeautifulSoup(html, 'html.parser')
    body = soup.body
    title = soup.title.string if soup.title else 'untitled'
    return str(body), title

# Convert HTML to Markdown
def convert_html_to_markdown(html: str) -> str:
    converter = html2text.HTML2Text()
    converter.ignore_links = False
    return converter.handle(html)

# Save Markdown text to a file
def save_markdown(markdown_text: str, title: str, save_path: str) -> str:
    if not os.path.exists(save_path):
        os.makedirs(save_path)
    filename = f"{title}.md"
    filename = "".join(x for x in filename if x.isalnum() or x in "._- ")
    full_path = os.path.join(save_path, filename)
    with open(full_path, 'w', encoding='utf-8') as file:
        file.write(markdown_text)
    return full_path

# Check if the site allows scraping by examining meta tags
def allows_scraping(html: str) -> bool:
    soup = BeautifulSoup(html, 'html.parser')
    meta_tags = soup.find_all('meta', attrs={'name': re.compile(r'robots', re.IGNORECASE)})
    for meta in meta_tags:
        if 'noindex' in meta.get('content', '').lower() or 'nofollow' in meta.get('content', '').lower():
            return False
    return True

# Process the given URL
def process_url(url: str, save_path: str):
    try:
        html = fetch_html(url)
        if allows_scraping(html):
            body_html, title = extract_body_and_title(html)
            markdown_text = convert_html_to_markdown(body_html)
            filename = save_markdown(markdown_text, title, save_path)
            print(f"Markdown saved as {filename}")
        else:
            print(f"Skipping {url}: Scraping not allowed (robots meta tag).")
    except Exception as e:
        print(f"Failed to process {url}: {e}")

# Main function to handle input path (URL or .txt file containing URLs)
def main(input_path: str, save_path: str):
    if input_path.endswith('.txt'):
        with open(input_path, 'r', encoding='utf-8') as file:
            urls = file.readlines()
            urls = [url.strip() for url in urls]
            for url in urls:
                if url:
                    process_url(url, save_path)
    else:
        process_url(input_path, save_path)

# Entry point for the script
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert HTML content from URLs to Markdown, respecting robots meta tags.")
    parser.add_argument('input_path', nargs='?', default='docs/ace/ace_docs.txt', help="URL or path to a .txt file containing URLs")
    parser.add_argument('--save_path', default='docs/ace/', help="Path to save the Markdown files")
    args = parser.parse_args()
    main(args.input_path, args.save_path)