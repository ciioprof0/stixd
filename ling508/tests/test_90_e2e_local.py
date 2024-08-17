#!/usr/bin/env python
# -*- coding: utf-8 -*-
# tests/test_90_e2e.py

""" End-to-end test for the Flask app """

from multiprocessing import Process
import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from ling508.api import app

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

    driver = webdriver.Chrome(options=chrome_options)
    yield driver
    driver.quit()

def run_flask_app():
    """Start the Flask app in a separate process."""
    app.run(debug=False, use_reloader=False)

def test_form_submission(init_driver, test_client):
    """Test the form submission on the Flask app."""
    driver = init_driver

    # Start Flask app in a separate process
    flask_process = Process(target=run_flask_app)
    flask_process.start()

    try:
        # Open the form in the browser
        driver.get("http://localhost:5000/")

        # Fill out the form
        uri_field = driver.find_element(By.ID, "uri")
        uri_field.send_keys(
            "https://raw.githubusercontent.com/ciioprof0/stixd/main/lexicon/test_clex.pl"
        )

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