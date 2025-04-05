FROM python:3.11-slim

# Install required system packages
RUN apt-get update && apt-get install -y git python3-pip

# Set working directory
WORKDIR /app

# Clone Sherlock manually
RUN git clone https://github.com/sherlock-project/sherlock.git

# Install Sherlock requirements
WORKDIR /app/sherlock
RUN pip install -r requirements.txt

# Move back to app folder
WORKDIR /app

# Copy your API files (main.py, requirements.txt for FastAPI)
COPY . .

# Install FastAPI and other API dependencies
RUN pip install -r requirements.txt

# Expose port (change if needed)
EXPOSE 10000

# Start your FastAPI server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "10000"]
