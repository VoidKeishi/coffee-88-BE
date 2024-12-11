#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Get recipient email and name from arguments
RECIPIENT_EMAIL="$1"
RECIPIENT_NAME="$2"

# Email subject
SUBJECT="Password Reset Request"

# Path to HTML template
TEMPLATE_PATH="../templates/ForgotPassword.html"

# Call the Python script
python3 email.py "$RECIPIENT_EMAIL" "$SUBJECT" "$RECIPIENT_NAME" "$TEMPLATE_PATH"