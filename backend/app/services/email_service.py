import os
import smtplib

from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

from dotenv import load_dotenv

load_dotenv()


class EmailService:

    EMAIL = os.getenv("EMAIL_ADDRESS")
    PASSWORD = os.getenv("EMAIL_PASSWORD")
    SMTP_SERVER = os.getenv("SMTP_SERVER")
    SMTP_PORT = int(os.getenv("SMTP_PORT"))

    @staticmethod
    def send_email(
        recipient: str,
        subject: str,
        body: str,
    ):

        message = MIMEMultipart()

        message["From"] = EmailService.EMAIL
        message["To"] = recipient
        message["Subject"] = subject

        message.attach(
            MIMEText(
                body,
                "plain",
            )
        )

        with smtplib.SMTP(
            EmailService.SMTP_SERVER,
            EmailService.SMTP_PORT,
        ) as server:

            server.starttls()

            server.login(
                EmailService.EMAIL,
                EmailService.PASSWORD,
            )

            server.send_message(message)

    @staticmethod
    def send_otp_email(
        recipient: str,
        otp: str,
    ):

        subject = "FinNudge AI Password Reset OTP"

        body = f"""
Hello,

You requested to reset your FinNudge AI password.

Your OTP is:

{otp}

This OTP will expire in 10 minutes.

If you didn't request this, please ignore this email.

Regards,
FinNudge AI Team
"""

        EmailService.send_email(
            recipient,
            subject,
            body,
        )