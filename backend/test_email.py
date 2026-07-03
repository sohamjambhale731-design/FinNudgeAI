import os
import smtplib

from dotenv import load_dotenv
from email.mime.text import MIMEText

load_dotenv()

EMAIL = os.getenv("EMAIL_ADDRESS")
PASSWORD = os.getenv("EMAIL_PASSWORD")

msg = MIMEText("Hello from FinNudge AI 🎉")
msg["Subject"] = "SMTP Test"
msg["From"] = EMAIL
msg["To"] = EMAIL

server = smtplib.SMTP("smtp.gmail.com", 587)
server.starttls()

server.login(
    EMAIL,
    PASSWORD,
)

server.send_message(msg)

server.quit()

print("Email sent successfully!")