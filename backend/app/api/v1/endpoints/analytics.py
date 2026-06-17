from fastapi import (
    APIRouter,
    Depends
)

from sqlalchemy.orm import Session

from app.database.dependencies import (
    get_db
)

from app.api.dependencies.auth import (
    get_current_user
)

from app.models.user import User

from app.schemas.analytics_schema import (
    AnalyticsGenerate
)

from app.services.analytics_service import (
    AnalyticsService
)

router = APIRouter()


@router.post("/generate")
def generate_analytics(
    request: AnalyticsGenerate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        AnalyticsService
        .generate_analytics(
            db,
            current_user.id,
            request.month
        )
    )


@router.get("/")
def get_analytics(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        AnalyticsService
        .get_analytics(
            db,
            current_user.id
        )
    )


@router.get("/nudges")
def get_nudges(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        AnalyticsService
        .get_nudges(
            db,
            current_user.id
        )
    )

@router.get("/insights/{month}")
def get_savings_insights(
    month: str,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        AnalyticsService
        .get_savings_insights(
            db,
            current_user.id,
            month
        )
    )

@router.get("/monthly-report/{month}")
def get_monthly_report(
    month: str,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        AnalyticsService
        .get_monthly_report(
            db,
            current_user.id,
            month
        )
    )

@router.get("/trends")
def get_trends(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        AnalyticsService
        .get_trends(
            db,
            current_user.id
        )
    )

@router.get("/category-comparison/{month}")
def get_category_comparison(
    month: str,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        AnalyticsService
        .get_category_comparison(
            db,
            current_user.id,
            month
        )
    )

@router.get("/goal-report")
def get_goal_report(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        AnalyticsService
        .get_goal_report(
            db,
            current_user.id
        )
    )

@router.get("/health-score-history")
def get_health_score_history(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        AnalyticsService
        .get_health_score_history(
            db,
            current_user.id
        )
    )

@router.get("/health-score-chart")
def get_health_score_chart(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        AnalyticsService
        .get_health_score_chart(
            db,
            current_user.id
        )
    )