from datetime import datetime

from sqlalchemy.orm import Session

from app.services.analytics_service import AnalyticsService

from app.models.expense import (
    FixedExpense,
    VariableExpense,
    VariableBudget
)

from app.repositories.expense_repository import (
    ExpenseRepository
)
from app.models.income import Income
from app.models.expense import FixedExpense

class ExpenseService:

    @staticmethod
    def create_fixed_expense(
        db: Session,
        user_id: int,
        category: str,
        subcategory: str,
        amount: float,
        recurring: bool
    ):

        category = category.strip().title()
        subcategory = subcategory.strip().title()

        existing_expense = (
            ExpenseRepository
            .get_fixed_expense_by_category(
                db,
                user_id,
                category,
                subcategory
            )
        )

        if existing_expense:
            raise ValueError(
                "Fixed expense already exists"
            )

        expense = FixedExpense(
            user_id=user_id,
            category=category,
            subcategory=subcategory,
            amount=amount,
            recurring=recurring
        )

        expense = (
            ExpenseRepository
            .create_fixed_expense(
                db,
                expense
            )
        )

        AnalyticsService.generate_analytics(
            db,
            user_id,
            datetime.now().strftime("%B")
        )

        return expense

    @staticmethod
    def get_fixed_expenses(
        db: Session,
        user_id: int
    ):
        return (
            ExpenseRepository
            .get_fixed_expenses(
                db,
                user_id
            )
        )
    
    @staticmethod
    def update_fixed_expense(
        db: Session,
        expense_id: int,
        user_id: int,
        category: str,
        subcategory: str,
        amount: float,
        recurring: bool
    ):

        expense = (
            ExpenseRepository
            .get_fixed_expense_by_id(
                db,
                expense_id
            )
        )

        if not expense:
            raise ValueError(
                "Expense not found"
            )

        if expense.user_id != user_id:
            raise ValueError(
                "Unauthorized"
            )

        expense.category = category
        expense.subcategory = subcategory
        expense.amount = amount
        expense.recurring = recurring

        return (
            ExpenseRepository
            .update_fixed_expense(
                db,
                expense
            )
        )


    @staticmethod
    def delete_fixed_expense(
        db: Session,
        expense_id: int,
        user_id: int
    ):

        expense = (
            ExpenseRepository
            .get_fixed_expense_by_id(
                db,
                expense_id
            )
        )

        if not expense:
            raise ValueError(
                "Expense not found"
            )

        if expense.user_id != user_id:
            raise ValueError(
                "Unauthorized"
            )

        ExpenseRepository.delete_fixed_expense(
            db,
            expense
        )

        AnalyticsService.generate_analytics(
            db,
            user_id,
            datetime.now().strftime("%B")
        )

        return {
            "message": "Expense deleted"
        }
    
    @staticmethod
    def create_variable_expense(
        db: Session,
        user_id: int,
        category: str,
        amount: float,
        note: str,
        expense_date
    ):
    
        month = expense_date.strftime("%B")
    
        budget = (
            ExpenseRepository
            .get_variable_budget_by_month(
                db,
                user_id,
                month
            )
        )
    
        if budget:
        
            if amount > budget.remaining_budget:
                raise ValueError(
                    "Budget exceeded"
                )
    
        expense = VariableExpense(
            user_id=user_id,
            category=category,
            amount=amount,
            note=note,
            date=expense_date
        )
    
        expense = (
            ExpenseRepository
            .create_variable_expense(
                db,
                expense
            )
        )

        if budget:

            budget.remaining_budget -= amount

            ExpenseRepository.update_variable_budget(
                db,
                budget
            )

        AnalyticsService.generate_analytics(
            db,
            user_id,
            expense_date.strftime("%B")
        )

        return expense


    @staticmethod
    def get_variable_expenses(
        db: Session,
        user_id: int
    ):
        return (
            ExpenseRepository
            .get_variable_expenses(
                db,
                user_id
            )
        )
    
    @staticmethod
    def update_variable_expense(
        db: Session,
        expense_id: int,
        user_id: int,
        category: str,
        amount: float,
        note: str
    ):

        expense = (
            ExpenseRepository
            .get_variable_expense_by_id(
                db,
                expense_id
            )
        )

        if not expense:
            raise ValueError(
                "Expense not found"
            )

        if expense.user_id != user_id:
            raise ValueError(
                "Unauthorized"
            )

        expense.category = category
        expense.amount = amount
        expense.note = note

        expense = ExpenseRepository.update_variable_expense(
            db,
            expense
        )

        AnalyticsService.generate_analytics(
            db,
            user_id,
            expense.date.strftime("%B")
        )

        return expense


    @staticmethod
    def delete_variable_expense(
        db: Session,
        expense_id: int,
        user_id: int
    ):

        expense = (
            ExpenseRepository
            .get_variable_expense_by_id(
                db,
                expense_id
            )
        )

        if not expense:
            raise ValueError(
                "Expense not found"
            )

        if expense.user_id != user_id:
            raise ValueError(
                "Unauthorized"
            )

        ExpenseRepository.delete_variable_expense(
            db,
            expense
        )

        return {
            "message": "Expense deleted"
        }
    

    @staticmethod
    def create_variable_budget(
        db: Session,
        user_id: int,
        month: str,
        allocated_budget: float
    ):

        month = month.strip().title()

        existing_budget = (
            ExpenseRepository
            .get_variable_budget_by_month(
                db,
                user_id,
                month
            )
        )

        if existing_budget:
            raise ValueError(
                f"Budget already exists for {month}"
            )

        income_record = (
            db.query(Income)
            .filter(
                Income.user_id == user_id,
                Income.month == month
            )
            .first()
        )

        if not income_record:
            raise ValueError(
                f"No income found for {month}"
            )

        fixed_expenses = (
            db.query(FixedExpense)
            .filter(
                FixedExpense.user_id == user_id
            )
            .all()
        )

        total_fixed_expense = sum(
            expense.amount
            for expense in fixed_expenses
        )

        available_budget = (
            income_record.total_income
            - total_fixed_expense
        )

        if allocated_budget > available_budget:
            raise ValueError(
                f"Budget cannot exceed available amount {available_budget}"
            )

        budget = VariableBudget(
            user_id=user_id,
            month=month,
            allocated_budget=allocated_budget,
            remaining_budget=allocated_budget
        )

        budget = ExpenseRepository.create_variable_budget(
            db,
            budget
        )

        AnalyticsService.generate_analytics(
            db,
            user_id,
            month
        )

        return budget


    @staticmethod
    def get_variable_budgets(
        db: Session,
        user_id: int
    ):
        return (
            ExpenseRepository
            .get_variable_budgets(
                db,
                user_id
            )
        )
    
    @staticmethod
    def update_variable_budget(
        db: Session,
        budget_id: int,
        user_id: int,
        allocated_budget: float
    ):

        budget = (
            ExpenseRepository
            .get_variable_budget_by_id(
                db,
                budget_id
            )
        )

        if not budget:
            raise ValueError(
                "Budget not found"
            )

        if budget.user_id != user_id:
            raise ValueError(
                "Unauthorized"
            )

        income_record = (
            db.query(Income)
            .filter(
                Income.user_id == user_id,
                Income.month == budget.month
            )
            .first()
        )

        if not income_record:
            raise ValueError(
                f"No income found for {budget.month}"
            )

        fixed_expenses = (
            db.query(FixedExpense)
            .filter(
                FixedExpense.user_id == user_id
            )
            .all()
        )

        total_fixed_expense = sum(
            expense.amount
            for expense in fixed_expenses
        )

        available_budget = (
            income_record.total_income
            - total_fixed_expense
        )

        if allocated_budget > available_budget:
            raise ValueError(
                f"Budget cannot exceed available amount {available_budget}"
            )

        spent_amount = (
            budget.allocated_budget
            - budget.remaining_budget
        )

        budget.allocated_budget = allocated_budget

        budget.remaining_budget = (
            allocated_budget
            - spent_amount
        )

        budget = ExpenseRepository.update_variable_budget(
            db,
            budget
        )

        AnalyticsService.generate_analytics(
            db,
            user_id,
            budget.month
        )

        return budget
    
    @staticmethod
    def delete_variable_budget(
        db: Session,
        budget_id: int,
        user_id: int
    ):

        budget = (
            ExpenseRepository
            .get_variable_budget_by_id(
                db,
                budget_id
            )
        )

        if not budget:
            raise ValueError(
                "Budget not found"
            )

        if budget.user_id != user_id:
            raise ValueError(
                "Unauthorized"
            )

        ExpenseRepository.delete_variable_budget(
            db,
            budget
        )

        return {
            "message": "Budget deleted"
        }

    @staticmethod
    def get_expense_analytics(
        db: Session,
        user_id: int
    ):

        fixed_expenses = (
            ExpenseRepository
            .get_fixed_expenses(
                db,
                user_id
            )
        )

        variable_expenses = (
            ExpenseRepository
            .get_variable_expenses(
                db,
                user_id
            )
        )

        budgets = (
            ExpenseRepository
            .get_variable_budgets(
                db,
                user_id
            )
        )

        total_fixed = sum(
            expense.amount
            for expense in fixed_expenses
        )

        total_variable = sum(
            expense.amount
            for expense in variable_expenses
        )

        total_expense = (
            total_fixed
            + total_variable
        )

        total_budget = sum(
            budget.allocated_budget
            for budget in budgets
        )

        total_remaining = sum(
            budget.remaining_budget
            for budget in budgets
        )

        if total_budget == 0:
            used_percentage = 0
        else:
            used_percentage = (
                (
                    total_budget
                    - total_remaining
                )
                / total_budget
            ) * 100

        return {
            "total_fixed_expense": total_fixed,
            "total_variable_expense": total_variable,
            "total_expense": total_expense,
            "budget_allocated": total_budget,
            "budget_remaining": total_remaining,
            "budget_used_percentage": round(
                used_percentage,
                2
            )
        }