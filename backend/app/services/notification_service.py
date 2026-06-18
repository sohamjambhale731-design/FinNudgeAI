from sqlalchemy.orm import Session

from app.models.notification import Notification

from app.repositories.notification_repository import (
    NotificationRepository
)


class NotificationService:

    @staticmethod
    def create_notification(
        db: Session,
        user_id: int,
        title: str,
        message: str,
        notification_type: str
    ):

        notification = Notification(
            user_id=user_id,
            title=title,
            message=message,
            type=notification_type
        )

        return (
            NotificationRepository
            .create_notification(
                db,
                notification
            )
        )

    @staticmethod
    def get_notifications(
        db: Session,
        user_id: int
    ):
        return (
            NotificationRepository
            .get_notifications(
                db,
                user_id
            )
        )

    @staticmethod
    def mark_as_read(
        db: Session,
        notification_id: int,
        user_id: int
    ):

        notification = (
            NotificationRepository
            .get_notification_by_id(
                db,
                notification_id
            )
        )

        if not notification:
            raise ValueError(
                "Notification not found"
            )

        if notification.user_id != user_id:
            raise ValueError(
                "Unauthorized"
            )

        notification.is_read = True

        return (
            NotificationRepository
            .update_notification(
                db,
                notification
            )
        )

    @staticmethod
    def delete_notification(
        db: Session,
        notification_id: int,
        user_id: int
    ):

        notification = (
            NotificationRepository
            .get_notification_by_id(
                db,
                notification_id
            )
        )

        if not notification:
            raise ValueError(
                "Notification not found"
            )

        if notification.user_id != user_id:
            raise ValueError(
                "Unauthorized"
            )

        NotificationRepository.delete_notification(
            db,
            notification
        )

        return {
            "message": "Notification deleted"
        }