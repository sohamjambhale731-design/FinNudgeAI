from sqlalchemy.orm import Session

from app.models.streak import Streak


class StreakRepository:

    @staticmethod
    def get_streak(
        db: Session,
        user_id: int
    ):
        return (
            db.query(Streak)
            .filter(
                Streak.user_id == user_id
            )
            .first()
        )

    @staticmethod
    def create_streak(
        db: Session,
        streak: Streak
    ):
        db.add(streak)
        db.commit()
        db.refresh(streak)

        return streak

    @staticmethod
    def update_streak(
        db: Session,
        streak: Streak
    ):
        db.commit()
        db.refresh(streak)

        return streak