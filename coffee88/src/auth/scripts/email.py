import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText2
import os
import sys

def send_email(to_email, subject, recipient_name, template_path):
    # Email configuration
    from_email = os.getenv('EMAIL_ADDRESS')
    password = os.getenv('EMAIL_PASSWORD')
    smtp_server = os.getenv('SMTP_SERVER')
    smtp_port = int(os.getenv('SMTP_PORT', 587))

    # Read the HTML template and replace [Recipient Name]
    with open(template_path, 'r') as file:
        html_template = file.read()

    html_content = html_template.replace('[Recipient Name]', recipient_name)

    # Create the email message
    msg = MIMEMultipart()
    msg['From'] = from_email
    msg['To'] = to_email
    msg['Subject'] = subject

    # Attach the HTML content to the email
    msg.attach(MIMEText(html_content, 'html'))

    # Send the email
    try:
        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(from_email, password)
        server.sendmail(from_email, to_email, msg.as_string())
        server.quit()
        print(f'Email sent to {to_email}')
    except Exception as e:
        print(f'Failed to send email: {e}')

if __name__ == '__main__':
    if len(sys.argv) != 5:
        print('Usage: python email.py <to_email> <subject> <recipient_name> <template_path>')
        sys.exit(1)
    to_email = sys.argv[1]
    subject = sys.argv[2]
    recipient_name = sys.argv[3]
    template_path = sys.argv[4]
    send_email(to_email, subject, recipient_name, template_path)