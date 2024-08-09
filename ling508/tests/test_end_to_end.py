#!/usr/bin/env python
# -*- coding: utf-8 -*-
# tests/test_end_to_end.py

""" End-to-end test for the Flask app """

from threading import Thread
import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By  # Correct element locating
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
    driver = webdriver.Chrome()  # Assuming ChromeDriver is in PATH
    yield driver
    driver.quit()

def run_flask_app():
    """Start the Flask app in a separate thread."""
    app.run(debug=False, use_reloader=False)

def test_form_submission(init_driver, test_client):
    """Test the form submission on the Flask app."""
    driver = init_driver

    # Start Flask app in a separate thread
    flask_thread = Thread(target=run_flask_app)
    flask_thread.start()

    # Open the form in the browser
    driver.get("http://localhost:5000/ling508/web/stixd.html")

    # Fill out the form
    uri_field = driver.find_element(By.ID, "uri")
    uri_field.send_keys("https://raw.githubusercontent.com/ciioprof0/stixd/main/lexicon/test_clex.pl")

    # Submit the form
    submit_button = driver.find_element(By.TAG_NAME, "button")
    submit_button.click()

    # Capture the response
    response_message = driver.find_element(By.TAG_NAME, "body").text

    # Assert the expected output
    assert "Import successful" in response_message

    # Stop the Flask server after the test
    flask_thread.join(timeout=1)
