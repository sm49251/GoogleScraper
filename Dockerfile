# Use an older Python version to maintain compatibility with the repo
FROM python:3.7-slim

# Install system dependencies, Google Chrome, and Chromedriver
RUN apt-get update && apt-get install -y wget gnupg2 unzip curl \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable

WORKDIR /app
COPY . /app

# Install the scraper and our Flask web server
RUN pip install -r requirements.txt
RUN pip install flask
RUN python setup.py install

# Open port 5000 for Coolify
EXPOSE 5000

# Start the API server
CMD ["python", "api.py"]
