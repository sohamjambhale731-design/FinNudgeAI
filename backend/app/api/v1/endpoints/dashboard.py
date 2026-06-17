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

from app.services.dashboard_service import (
    DashboardService
)

router = APIRouter()


@router.get("/{month}")
def get_dashboard(
    month: str,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        DashboardService
        .get_dashboard(
            db,
            current_user.id,
            month
        )
    )