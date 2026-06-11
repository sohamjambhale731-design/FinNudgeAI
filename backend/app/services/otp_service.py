import random

from datetime import datetime, timedelta

from sqlalchemy.orm import Session

from app.models.otp_verification import OTPVerification

from app.repositories.otp_repository import (
    OTPRepository
)


class OTPService:

    @staticmethod
    def generate_otp(
        db: Session,
        user_id: int
    ):

        otp_code = str(
            random.randint(
                100000,
                999999
            )
        )

        otp = OTPVerification(
            user_id=user_id,
            otp_code=otp_code,
            expires_at=datetime.utcnow()
            + timedelta(minutes=10)
        )

        OTPRepository.create(
            db,
            otp
        )

        return otp_code

    @staticmethod
    def verify_otp(
        db: Session,
        user_id: int,
        otp_code: str
    ):

        otp = (
            OTPRepository
            .get_latest_otp(
                db,
                user_id
            )
        )

        if not otp:
            raise ValueError(
                "OTP not found"
            )

        if otp.is_used:
            raise ValueError(
                "OTP already used"
            )

        if otp.expires_at < datetime.utcnow():
            raise ValueError(
                "OTP expired"
            )

        if otp.otp_code != otp_code:
            raise ValueError(
                "Invalid OTP"
            )

        otp.is_used = True

        db.commit()

        return True