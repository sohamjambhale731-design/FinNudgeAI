from datetime import date

from sqlalchemy import (
    String,
    Integer,
    Float,
    Date,
    ForeignKey
)

from sqlalchemy.orm import (
    Mapped,
    mapped_column,
    relationship
)

from app.database.base import Base


class Income(Base):
    __tablename__ = "income"

    income_id: Mapped[int] = mapped_column(
        primary_key=True
    )

    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id")
    )

    primary_income: Mapped[float] = mapped_column(
        Float
    )

    total_additional_income: Mapped[float] = mapped_column(
        Float,
        default=0
    )

    total_income: Mapped[float] = mapped_column(
        Float
    )

    month: Mapped[str] = mapped_column(
        String(20)
    )

    year: Mapped[int] = mapped_column(
        Integer
    )

    user = relationship(
        "User",
        back_populates="incomes"
    )


class AdditionalIncome(Base):
    __tablename__ = "additional_income"

    additional_income_id: Mapped[int] = mapped_column(
        primary_key=True
    )

    user_id: Mapped[int] = mapped_column(
        ForeignKey("users.id")
    )

    source_name: Mapped[str] = mapped_column(
        String(100)
    )

    amount: Mapped[float] = mapped_column(
        Float
    )

    date: Mapped[date] = mapped_column(
        Date
    )

    user = relationship(
        "User",
        back_populates="additional_incomes"
    )