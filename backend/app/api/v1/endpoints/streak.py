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

from app.services.streak_service import (
    StreakService
)

router = APIRouter()


@router.post("/update")
def update_streak(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        StreakService
        .update_streak(
            db,
            current_user.id
        )
    )


@router.get("/")
def get_streak(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        StreakService
        .get_streak(
            db,
            current_user.id
        )
    )