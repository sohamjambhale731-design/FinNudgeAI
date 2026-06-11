from sqlalchemy.orm import Session

from app.models.otp_verification import OTPVerification


class OTPRepository:

    @staticmethod
    def create(
        db: Session,
        otp_obj: OTPVerification
    ):
        db.add(otp_obj)
        db.commit()
        db.refresh(otp_obj)

        return otp_obj

    @staticmethod
    def get_latest_otp(
        db: Session,
        user_id: int
    ):
        return (
            db.query(OTPVerification)
            .filter(
                OTPVerification.user_id == user_id
            )
            .order_by(
                OTPVerification.created_at.desc()
            )
            .first()
        )