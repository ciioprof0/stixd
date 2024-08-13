# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Set environment variables to prevent Python from writing pyc files to disc
# and buffering stdout and stderr (useful for logging)
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /app

# Install system dependencies for MySQL and Chrome (optional for headless browser testing)
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    build-essential \
    google-chrome-stable \
    chromium-chromedriver \
    && apt-get clean

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r ling508/requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable for Flask
ENV FLASK_ENV=production

# Run the application
CMD ["python", "ling508/api.py"]
