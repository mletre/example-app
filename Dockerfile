# Use an official Python runtime as a parent image
FROM python:3.13-slim-trixie

# Set the working directory in the container
WORKDIR /app

# Copy the dependencies file to the working directory
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
# --no-cache-dir: Disables the cache which reduces the image size
# --trusted-host pypi.python.org: Can help in some network environments
RUN pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

# Copy the rest of the application's code to the working directory
COPY . .

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Run the application using Gunicorn for production
# This will start the web server and listen for connections on port 5000
# Using the absolute path to gunicorn to avoid PATH issues.
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]

