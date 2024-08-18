#!/usr/bin/env python
# -*- coding: utf-8 -*-
# tests/test_95_e2e_ci.py

""" End-to-end test for the Flask app """

import logging
import os
import requests
import time
from multiprocessing import Process
import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from ling508.api import app

logging.basicConfig(level=logging.INFO)

@pytest.fixture(scope="module")
def test_client():
    """Fixture to create a test client for the Flask app."""
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

@pytest.fixture(scope="module")
def init_driver():
    """Fixture to initialize the Selenium WebDriver."""
    # Set up Chrome options to control window size
    chrome_options = Options()
    chrome_options.add_argument("--window-size=640,480")

    # Enable headless mode for CI environments
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--disable-gpu")  # Required for running in headless mode on some systems
    chrome_options.add_argument("--no-sandbox")  # Recommended by some for running in CI environments
    chrome_options.add_argument("--disable-dev-shm-usage")  # Recommended to avoid issues with shared memory in Docker

    driver = webdriver.Chrome(options=chrome_options)
    yield driver
    driver.quit()

def run_flask_app():
    """Start the Flask app in a separate process."""
    logging.info("Attempting to start the Flask app...")
    app.run(host="0.0.0.0", port=50001, debug=True, use_reloader=False)

def wait_for_flask():
    """Wait until the Flask app is responsive."""
    for i in range(60):  # Retry 60 times with 1-second intervals
        try:
            response = requests.get("http://localhost:50001/")
            if response.status_code == 200:
                logging.info(f"Flask app responded successfully on attempt {i + 1}.")
                return True
        except requests.exceptions.ConnectionError:
            logging.warning(f"Attempt {i + 1}: Flask app not yet responsive.")
        time.sleep(1)
    logging.error("Flask app did not start within the expected time.")
    return False

def test_form_submission(init_driver, test_client):
    """Test the form submission on the Flask app."""
    driver = init_driver

    # Start Flask app in a separate process
    flask_process = Process(target=run_flask_app)
    flask_process.start()

    try:
        # Ensure Flask app is ready
        if not wait_for_flask():
            pytest.fail("Flask app did not start within the expected time.")

        # Open the form in the browser
        driver.get("http://localhost:50001/")

        # Wait for the URI field to be present
        uri_field = WebDriverWait(driver, 20).until(
            EC.presence_of_element_located((By.ID, "uri"))
        )

        # Use a local path to the file within the same repo
        lexicon_file_path = os.path.join(os.getcwd(), 'lexicon', 'test_clex.pl')
        uri_field.send_keys(lexicon_file_path)

        # Submit the form
        submit_button = driver.find_element(By.TAG_NAME, "button")
        submit_button.click()

        # Capture the response
        response_message = driver.find_element(By.TAG_NAME, "body").text

        # Assert the expected output
        assert "Import successful" in response_message

    finally:
        # Terminate the Flask server process
        flask_process.terminate()
        flask_process.join()