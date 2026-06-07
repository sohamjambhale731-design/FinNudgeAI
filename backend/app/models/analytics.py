from sqlalchemy import (
    String,
    Float,
    ForeignKey
)

from sqlalchemy.orm import (
    Mapped,
    mapped_column , relationship
)

from app.database.base import Base


class Analytics(Base):
    __tablename__ = "analytics"

    analytics_id: Mapped[int] = mapped_column(
        primary_key=True
    )

    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id")
    )

    month: Mapped[str] = mapped_column(
        String(20)
    )

    total_spent: Mapped[float] = mapped_column(
        Float,
        default=0
    )

    total_saved: Mapped[float] = mapped_column(
        Float,
        default=0
    )

    savings_rate: Mapped[float] = mapped_column(
        Float,
        default=0
    )

    financial_health_score: Mapped[float] = mapped_column(
        Float,
        default=0
    )

    user = relationship(
        "User",
        back_populates="analytics"
    )