from datetime import date

from sqlalchemy import (
    String,
    Float,
    Integer,
    Date,
    ForeignKey
)

from sqlalchemy.orm import (
    Mapped,
    mapped_column,
    relationship
)

from app.database.base import Base


class Goal(Base):
    __tablename__ = "goals"

    goal_id: Mapped[int] = mapped_column(
        primary_key=True
    )

    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id")
    )

    goal_name: Mapped[str] = mapped_column(
        String(100)
    )

    target_amount: Mapped[float] = mapped_column(
        Float
    )

    current_amount: Mapped[float] = mapped_column(
        Float,
        default=0
    )

    priority: Mapped[int] = mapped_column(
        Integer
    )

    target_date: Mapped[date | None] = mapped_column(
        Date,
        nullable=True
    )

    status: Mapped[str] = mapped_column(
        String(50),
        default="Active"
    )

    user = relationship(
        "User",
        back_populates="goals"
    )

    contributions = relationship(
        "GoalContribution",
        back_populates="goal"
    )


class GoalContribution(Base):
    __tablename__ = "goal_contributions"

    contribution_id: Mapped[int] = mapped_column(
        primary_key=True
    )

    goal_id: Mapped[int] = mapped_column(
        ForeignKey("goals.goal_id")
    )

    amount: Mapped[float] = mapped_column(
        Float
    )

    date: Mapped[date] = mapped_column(
        Date
    )

    goal = relationship(
        "Goal",
        back_populates="contributions"
    )