from sqlalchemy.orm import Session

from app.models.analytics import Analytics

from app.models.ai_nudge import AINudge


class AnalyticsRepository:

    @staticmethod
    def create_analytics(
        db: Session,
        analytics: Analytics
    ):
        db.add(analytics)
        db.commit()
        db.refresh(analytics)

        return analytics

    @staticmethod
    def get_analytics(
        db: Session,
        user_id: int
    ):
        return (
            db.query(Analytics)
            .filter(
                Analytics.user_id == user_id
            )
            .all()
        )

    @staticmethod
    def get_analytics_by_month(
        db: Session,
        user_id: int,
        month: str
    ):
        return (
            db.query(Analytics)
            .filter(
                Analytics.user_id == user_id,
                Analytics.month == month
            )
            .first()
        )

    @staticmethod
    def create_nudge(
        db: Session,
        nudge: AINudge
    ):
        db.add(nudge)
        db.commit()
        db.refresh(nudge)

        return nudge

    @staticmethod
    def get_nudges(
        db: Session,
        user_id: int
    ):
        return (
            db.query(AINudge)
            .filter(
                AINudge.user_id == user_id
            )
            .all()
        )
    
    @staticmethod
    def get_nudges_by_category(
        db: Session,
        user_id: int,
        category: str
    ):
        return (
            db.query(AINudge)
            .filter(
                AINudge.user_id == user_id,
                AINudge.category == category
            )
            .all()
        )   