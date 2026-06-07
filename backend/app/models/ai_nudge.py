from datetime import datetime

from sqlalchemy import (
    String,
    Boolean,
    DateTime,
    ForeignKey
)

from sqlalchemy.orm import (
    Mapped,
    mapped_column , relationship
)

from app.database.base import Base


class AINudge(Base):
    __tablename__ = "ai_nudges"

    nudge_id: Mapped[int] = mapped_column(
        primary_key=True
    )

    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id")
    )

    message: Mapped[str] = mapped_column(
        String(500)
    )

    priority: Mapped[str] = mapped_column(
        String(20)
    )

    category: Mapped[str] = mapped_column(
        String(50)
    )

    created_at: Mapped[datetime] = mapped_column(
        DateTime,
        default=datetime.utcnow
    )

    is_read: Mapped[bool] = mapped_column(
        Boolean,
        default=False
    )
    
    user = relationship(
        "User",
        back_populates="ai_nudges"
    )