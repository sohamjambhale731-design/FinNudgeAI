from sqlalchemy.orm import Session

from app.models.income import (
    Income,
    AdditionalIncome
)
from sqlalchemy import func

class IncomeRepository:

    @staticmethod
    def create_income(
        db: Session,
        income: Income
    ):
        db.add(income)
        db.commit()
        db.refresh(income)

        return income

    @staticmethod
    def get_income_by_user(
        db: Session,
        user_id: int
    ):
        return (
            db.query(Income)
            .filter(
                Income.user_id == user_id
            )
            .all()
        )

    @staticmethod
    def get_income_by_id(
        db: Session,
        income_id: int
    ):
        return (
            db.query(Income)
            .filter(
                Income.income_id == income_id
            )
            .first()
        )

    @staticmethod
    def delete_income(
        db: Session,
        income: Income
    ):
        db.delete(income)
        db.commit()

    @staticmethod
    def create_additional_income(
        db: Session,
        additional_income: AdditionalIncome
    ):
        db.add(additional_income)
        db.commit()
        db.refresh(additional_income)

        return additional_income

    @staticmethod
    def get_additional_income(
        db: Session,
        user_id: int
    ):
        return (
            db.query(AdditionalIncome)
            .filter(
                AdditionalIncome.user_id == user_id
            )
            .all()
        )
    
    @staticmethod
    def get_income_by_user_and_month(
        db: Session,
        user_id: int,
        month: str
    ):
        return (
            db.query(Income)
            .filter(
                Income.user_id == user_id,
                func.lower(Income.month) == month.lower()
            )
            .first()
        )
    
    @staticmethod
    def update_income(
        db: Session,
        income: Income
    ):
        db.add(income)
        db.commit()
        db.refresh(income)
    
        return income
    
    @staticmethod
    def get_additional_income(
        db: Session,
        user_id: int
    ):
        return (
            db.query(AdditionalIncome)
            .filter(
                AdditionalIncome.user_id == user_id
            )
            .order_by(
                AdditionalIncome.date.desc()
            )
            .all()
        )