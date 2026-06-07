from datetime import datetime

from sqlalchemy import (
    Integer,
    DateTime,
    ForeignKey
)

from sqlalchemy.orm import (
    Mapped,
    mapped_column , relationship
)

from app.database.base import Base


class Streak(Base):
    __tablename__ = "streaks"

    streak_id: Mapped[int] = mapped_column(
        primary_key=True
    )

    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id"),
        unique=True
    )

    current_streak: Mapped[int] = mapped_column(
        Integer,
        default=0
    )

    longest_streak: Mapped[int] = mapped_column(
        Integer,
        default=0
    )

    updated_at: Mapped[datetime] = mapped_column(
        DateTime,
        default=datetime.utcnow
    )

    user = relationship(
        "User",
        back_populates="streak"
    )