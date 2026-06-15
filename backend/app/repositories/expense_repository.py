from sqlalchemy.orm import Session

from app.models.expense import FixedExpense
from sqlalchemy import func

from app.models.expense import (
    FixedExpense,
    VariableExpense,
    VariableBudget
)

class ExpenseRepository:

    @staticmethod
    def create_fixed_expense(
        db: Session,
        expense: FixedExpense
    ):
        db.add(expense)
        db.commit()
        db.refresh(expense)

        return expense

    @staticmethod
    def get_fixed_expenses(
        db: Session,
        user_id: int
    ):
        return (
            db.query(FixedExpense)
            .filter(
                FixedExpense.user_id == user_id
            )
            .all()
        )

    @staticmethod
    def get_fixed_expense_by_id(
        db: Session,
        expense_id: int
    ):
        return (
            db.query(FixedExpense)
            .filter(
                FixedExpense.expense_id == expense_id
            )
            .first()
        )
    
    @staticmethod
    def update_fixed_expense(
        db: Session,
        expense
    ):
        db.commit()
        db.refresh(expense)

        return expense


    @staticmethod
    def delete_fixed_expense(
        db: Session,
        expense
    ):
        db.delete(expense)
        db.commit()

    @staticmethod
    def get_fixed_expense_by_category(
        db: Session,
        user_id: int,
        category: str,
        subcategory: str
    ):
        return (
            db.query(FixedExpense)
            .filter(
                FixedExpense.user_id == user_id,
                func.lower(FixedExpense.category) == category.lower(),
                func.lower(FixedExpense.subcategory) == subcategory.lower()
            )
            .first()
        )
    
    @staticmethod
    def create_variable_expense(
        db: Session,
        expense: VariableExpense
    ):
        db.add(expense)
        db.commit()
        db.refresh(expense)

        return expense


    @staticmethod
    def get_variable_expenses(
        db: Session,
        user_id: int
    ):
        return (
            db.query(VariableExpense)
            .filter(
                VariableExpense.user_id == user_id
            )
            .all()
        )


    @staticmethod
    def get_variable_expense_by_id(
        db: Session,
        expense_id: int
    ):
        return (
            db.query(VariableExpense)
            .filter(
                VariableExpense.expense_id == expense_id
            )
            .first()
        )


    @staticmethod
    def update_variable_expense(
        db: Session,
        expense: VariableExpense
    ):
        db.commit()
        db.refresh(expense)

        return expense


    @staticmethod
    def delete_variable_expense(
        db: Session,
        expense: VariableExpense
    ):
        db.delete(expense)
        db.commit()
    
    @staticmethod
    def create_variable_budget(
        db: Session,
        budget: VariableBudget
    ):
        db.add(budget)
        db.commit()
        db.refresh(budget)
    
        return budget
    
    
    @staticmethod
    def get_variable_budget_by_month(
        db: Session,
        user_id: int,
        month: str
    ):
        return (
            db.query(VariableBudget)
            .filter(
                VariableBudget.user_id == user_id,
                VariableBudget.month == month
            )
            .first()
        )
    
    @staticmethod
    def get_variable_budget_by_id(
        db: Session,
        budget_id: int
    ):
        return (
            db.query(VariableBudget)
            .filter(
                VariableBudget.budget_id == budget_id
            )
            .first()
        )
    
    @staticmethod
    def get_variable_budgets(
        db: Session,
        user_id: int
    ):
        return (
            db.query(VariableBudget)
            .filter(
                VariableBudget.user_id == user_id
            )
            .all()
        )
    
    
    @staticmethod
    def update_variable_budget(
        db: Session,
        budget: VariableBudget
    ):
        db.commit()
        db.refresh(budget)
    
        return budget
    
    
    @staticmethod
    def delete_variable_budget(
        db: Session,
        budget: VariableBudget
    ):
        db.delete(budget)
        db.commit()