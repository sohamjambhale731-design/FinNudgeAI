from sqlalchemy.orm import Session

from app.models.otp_verification import OTPVerification
from app.models.user import User


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
    
    @staticmethod
    def get_user_email(
        db: Session,
        user_id: int,
    ):
    
        user = (
            db.query(User)
            .filter(User.id == user_id)
            .first()
        )
    
        return user.email