from datetime import datetime

from sqlalchemy import String, Integer, Boolean, DateTime
from sqlalchemy.orm import Mapped, mapped_column
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.database.base import Base


class User(Base):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(
        primary_key=True
    )

    full_name: Mapped[str] = mapped_column(
        String(100)
    )

    email: Mapped[str] = mapped_column(
        String(255),
        unique=True,
        index=True
    )

    password_hash: Mapped[str] = mapped_column(
        String(255)
    )

    age: Mapped[int] = mapped_column(
        Integer
    )

    user_type: Mapped[str] = mapped_column(
        String(50)
    )
    
    ai_preference: Mapped[bool] = mapped_column(
    Boolean,
    default=True
    )

    is_verified: Mapped[bool] = mapped_column(
        Boolean,
        default=False
    )

    created_at: Mapped[datetime] = mapped_column(
        DateTime,
        default=datetime.utcnow
    )

    # Income
    incomes = relationship("Income", back_populates="user")
    additional_incomes = relationship("AdditionalIncome", back_populates="user")

    # Expenses
    fixed_expenses = relationship("FixedExpense", back_populates="user")
    variable_expenses = relationship("VariableExpense", back_populates="user")

    # Goals
    goals = relationship("Goal", back_populates="user")

    # AI Nudges
    ai_nudges = relationship("AINudge", back_populates="user")

    # Analytics
    analytics = relationship("Analytics", back_populates="user")

    # Streak
    streak = relationship(
        "Streak",
        back_populates="user",
        uselist=False
    )

    # Future Tables
    otp_verifications = relationship(
        "OTPVerification",
        back_populates="user"
    )

    refresh_tokens = relationship(
        "RefreshToken",
        back_populates="user"
    )

    notifications = relationship(
        "Notification",
        back_populates="user"
    )

    activity_logs = relationship(
        "UserActivityLog",
        back_populates="user"   
        
    )

    variable_budgets = relationship(
        "VariableBudget",
        back_populates="user"
    )