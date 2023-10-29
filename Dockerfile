# Use the Python 3.8 image based on Buster
FROM python:3.8-buster

# Set the working directory
WORKDIR /usr/src/app

# Disable Python bytecode generation and set unbuffered mode
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Copy the requirements file and install dependencies
COPY requirements.txt /usr/src/app
RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the rest of your application code
COPY . /usr/src/app

# Copy your environment configuration file (change this if needed)
RUN cp .env.dev.sample .env

# Expose port 8000
EXPOSE 8000

# Make your entrypoint script executable
RUN chmod +x entrypoint.sh

# Define environment variables
ENV APP_HOME=/usr/src/app
ENV DEBUG=1

# Create directories for static and media files
RUN mkdir $APP_HOME/staticfiles
RUN mkdir $APP_HOME/mediafiles

# Set the command to run your application
CMD ["sh", "entrypoint.sh"]

