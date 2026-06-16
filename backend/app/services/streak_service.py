from datetime import datetime

from sqlalchemy.orm import Session

from app.models.streak import Streak

from app.repositories.streak_repository import (
    StreakRepository
)


class StreakService:

    @staticmethod
    def update_streak(
        db: Session,
        user_id: int
    ):

        streak = (
            StreakRepository
            .get_streak(
                db,
                user_id
            )
        )

        today = datetime.utcnow().date()

        if not streak:

            streak = Streak(
                user_id=user_id,
                current_streak=1,
                longest_streak=1
            )

            return (
                StreakRepository
                .create_streak(
                    db,
                    streak
                )
            )

        last_activity = (
            streak.updated_at.date()
        )

        days_difference = (
            today - last_activity
        ).days

        # Already updated today
        if days_difference == 0:

            return streak

        # Consecutive day
        elif days_difference == 1:

            streak.current_streak += 1

        # Missed one or more days
        else:

            streak.current_streak = 1

        if (
            streak.current_streak
            > streak.longest_streak
        ):
            streak.longest_streak = (
                streak.current_streak
            )

        streak.updated_at = (
            datetime.utcnow()
        )

        return (
            StreakRepository
            .update_streak(
                db,
                streak
            )
        )

    @staticmethod
    def get_streak(
        db: Session,
        user_id: int
    ):

        streak = (
            StreakRepository
            .get_streak(
                db,
                user_id
            )
        )

        if not streak:

            return {
                "current_streak": 0,
                "longest_streak": 0
            }

        return streak