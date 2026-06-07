from datetime import datetime, date

from sqlalchemy import (
    String,
    Float,
    Boolean,
    Date,
    DateTime,
    ForeignKey
)

from sqlalchemy.orm import (
    Mapped,
    mapped_column , relationship
)

from app.database.base import Base


class FixedExpense(Base):
    __tablename__ = "fixed_expenses"

    expense_id: Mapped[int] = mapped_column(
        primary_key=True
    )

    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id")
    )

    category: Mapped[str] = mapped_column(
        String(100)
    )

    subcategory: Mapped[str] = mapped_column(
        String(100)
    )

    amount: Mapped[float] = mapped_column(
        Float
    )

    recurring: Mapped[bool] = mapped_column(
        Boolean,
        default=True
    )

    created_at: Mapped[datetime] = mapped_column(
        DateTime,
        default=datetime.utcnow
    )

    user = relationship(
        "User",
        back_populates="fixed_expenses"
    )


class VariableExpense(Base):
    __tablename__ = "variable_expenses"

    expense_id: Mapped[int] = mapped_column(
        primary_key=True
    )

    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id")
    )

    category: Mapped[str] = mapped_column(
        String(100)
    )

    amount: Mapped[float] = mapped_column(
        Float
    )

    note: Mapped[str] = mapped_column(
        String(255)
    )

    date: Mapped[date] = mapped_column(
        Date
    )

    user = relationship(
        "User",
        back_populates="variable_expenses"
    )


class VariableBudget(Base):
    __tablename__ = "variable_budget"

    budget_id: Mapped[int] = mapped_column(
        primary_key=True
    )

    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id")
    )

    month: Mapped[str] = mapped_column(
        String(20)
    )

    allocated_budget: Mapped[float] = mapped_column(
        Float 
    )

    remaining_budget: Mapped[float] = mapped_column(
        Float
    )

    user = relationship(
        "User",
        back_populates="variable_budgets"
    )