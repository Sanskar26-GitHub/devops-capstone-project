# Use a slim Python 3.9 base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the Python dependencies file into the image
COPY requirements.txt .

# Install dependencies without cache to keep image small
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application source code
COPY service/ ./service/

# Create a non-root user and switch to it
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Expose the port the app runs on
EXPOSE 8080

# Command to run the app using gunicorn
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
