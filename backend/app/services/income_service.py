from sqlalchemy.orm import Session

from app.models.income import (
    Income,
    AdditionalIncome
)

from app.repositories.income_repository import (
    IncomeRepository
)


class IncomeService:

    @staticmethod
    def create_income(
        db: Session,
        user_id: int,
        primary_income: float,
        month: str
    ):

        income = Income(
            user_id=user_id,
            primary_income=primary_income,
            total_additional_income=0,
            total_income=primary_income,
            month=month
        )

        return (
            IncomeRepository
            .create_income(
                db,
                income
            )
        )

    @staticmethod
    def get_user_income(
        db: Session,
        user_id: int
    ):
        return (
            IncomeRepository
            .get_income_by_user(
                db,
                user_id
            )
        )

    @staticmethod
    def add_additional_income(
        db: Session,
        user_id: int,
        source_name: str,
        amount: float,
        income_date
    ):
    
        additional_income = AdditionalIncome(
            user_id=user_id,
            source_name=source_name,
            amount=amount,
            date=income_date
        )
    
        IncomeRepository.create_additional_income(
            db,
            additional_income
        )
    
        income_record = (
            db.query(Income)
            .filter(
                Income.user_id == user_id
            )
            .first()
        )
    
        if income_record:
            IncomeService.update_income_totals(
                db,
                income_record.income_id
            )
    
        return additional_income

    @staticmethod
    def update_income_totals(
        db: Session,
        income_id: int
    ):

        income = (
            IncomeRepository
            .get_income_by_id(
                db,
                income_id
            )
        )

        if not income:
            raise ValueError(
                "Income not found"
            )

        additional_income_records = (
            IncomeRepository
            .get_additional_income(
                db,
                income.user_id
            )
        )

        total_additional_income = sum(
            item.amount
            for item in additional_income_records
        )

        income.total_additional_income = (
            total_additional_income
        )

        income.total_income = (
            income.primary_income
            + total_additional_income
        )

        db.commit()

        return income