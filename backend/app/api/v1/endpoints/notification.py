from fastapi import (
    APIRouter,
    Depends
)

from sqlalchemy.orm import Session

from app.database.dependencies import get_db

from app.api.dependencies.auth import (
    get_current_user
)

from app.models.user import User

from app.services.notification_service import (
    NotificationService
)

from app.schemas.notification_schema import (
    NotificationCreate
)

router = APIRouter()

@router.post("/")
def create_notification(
    request: NotificationCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        NotificationService
        .create_notification(
            db,
            current_user.id,
            request.title,
            request.message,
            request.type
        )
    )

@router.get("/")
def get_notifications(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        NotificationService
        .get_notifications(
            db,
            current_user.id
        )
    )

@router.put("/{notification_id}/read")
def mark_as_read(
    notification_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        NotificationService
        .mark_as_read(
            db,
            notification_id,
            current_user.id
        )
    )

@router.delete("/{notification_id}")
def delete_notification(
    notification_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        NotificationService
        .delete_notification(
            db,
            notification_id,
            current_user.id
        )
    )