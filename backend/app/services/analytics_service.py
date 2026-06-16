from fastapi import HTTPException

from sqlalchemy.orm import Session

from app.models.analytics import Analytics
from app.models.ai_nudge import AINudge

from app.repositories.goal_repository import (
    GoalRepository
)

from app.repositories.expense_repository import (
    ExpenseRepository
)

from app.repositories.streak_repository import (
    StreakRepository
)

from app.repositories.analytics_repository import (
    AnalyticsRepository
)

from app.repositories.income_repository import (
    IncomeRepository
)

from app.repositories.expense_repository import (
    ExpenseRepository
)


class AnalyticsService:

    @staticmethod
    def generate_analytics(
        db: Session,
        user_id: int,
        month: str
    ):

        month = month.strip().title()

        existing_analytics = (
            AnalyticsRepository
            .get_analytics_by_month(
                db,
                user_id,
                month
            )
        )

        if existing_analytics:
            raise HTTPException(
                status_code=400,
                detail=f"Analytics already exists for {month}"
            )

        incomes = (
            IncomeRepository
            .get_income_by_user(
                db,
                user_id
            )
        )

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

        total_income = sum(
            income.total_income
            for income in incomes
            if income.month == month
        )

        total_fixed_expense = sum(
            expense.amount
            for expense in fixed_expenses
        )

        total_variable_expense = sum(
            expense.amount
            for expense in variable_expenses
            if expense.date.strftime("%B") == month
        )

        total_spent = (
            total_fixed_expense
            + total_variable_expense
        )

        total_saved = max(
            0,
            total_income - total_spent
        )

        if total_income <= 0:
            savings_rate = 0
        else:
            savings_rate = (
                total_saved
                / total_income
            ) * 100

        if savings_rate >= 30:
            financial_health_score = 100
        elif savings_rate >= 20:
            financial_health_score = 80
        elif savings_rate >= 10:
            financial_health_score = 60
        elif savings_rate >= 5:
            financial_health_score = 40
        else:
            financial_health_score = 20

        analytics = Analytics(
            user_id=user_id,
            month=month,
            total_spent=total_spent,
            total_saved=total_saved,
            savings_rate=round(
                savings_rate,
                2
            ),
            financial_health_score=financial_health_score
        )

        AnalyticsRepository.create_analytics(
            db,
            analytics
        )

        if savings_rate >= 20:

            message = (
                "Great job! Your savings rate exceeded 20%."
            )

            priority = "Low"

        elif savings_rate >= 10:

            message = (
                "You are saving consistently. "
                "Try increasing savings further."
            )

            priority = "Medium"

        else:

            message = (
                "Your savings rate is low. "
                "Review your spending habits."
            )

            priority = "High"

        nudge = AINudge(
            user_id=user_id,
            message=message,
            priority=priority,
            category="Savings"
        )

        AnalyticsRepository.create_nudge(
            db,
            nudge
        )

        return analytics

    @staticmethod
    def get_analytics(
        db: Session,
        user_id: int
    ):
        return (
            AnalyticsRepository
            .get_analytics(
                db,
                user_id
            )
        )

    @staticmethod
    def get_nudges(
        db: Session,
        user_id: int
    ):
        return (
            AnalyticsRepository
            .get_nudges(
                db,
                user_id
            )
        )
    
    @staticmethod
    def get_savings_insights(
        db: Session,
        user_id: int,
        month: str
    ):

        month = month.strip().title()

        incomes = (
            IncomeRepository
            .get_income_by_user(
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

        fixed_expenses = (
            ExpenseRepository
            .get_fixed_expenses(
                db,
                user_id
            )
        )

        goals = (
            GoalRepository
            .get_goals(
                db,
                user_id
            )
        )

        total_income = sum(
            income.total_income
            for income in incomes
            if income.month == month
        )

        total_fixed_expense = sum(
            expense.amount
            for expense in fixed_expenses
        )

        budget = next(
            (
                b
                for b in budgets
                if b.month == month
            ),
            None
        )

        allocated_budget = (
            budget.allocated_budget
            if budget
            else 0
        )

        variable_expenses = (
            ExpenseRepository
            .get_variable_expenses(
                db,
                user_id
            )
        )
        
        spent_amount = sum(
            expense.amount
            for expense in variable_expenses
            if expense.date.strftime("%B") == month
        )
        
        budget_usage = 0
        
        if allocated_budget > 0:
        
            budget_usage = (
                spent_amount
                / allocated_budget
            ) * 100

        savings_potential = max(
            0,
            total_income
            - total_fixed_expense
            - allocated_budget
        )

        goal_predictions = []

        for goal in goals:

            remaining_amount = (
                goal.target_amount
                - goal.current_amount
            )

            if savings_potential <= 0:

                months_to_complete = None

            else:

                months_to_complete = round(
                    remaining_amount
                    / savings_potential,
                    1
                )

            goal_predictions.append({
                "goal_id": goal.goal_id,
                "goal_name": goal.goal_name,
                "remaining_amount": remaining_amount,
                "months_to_complete":
                    months_to_complete
            })

        if (
            savings_potential > 0
            and len(goals) > 0
        ):

            highest_priority_goal = min(
                goals,
                key=lambda g: g.priority
            )

            existing_nudges = (
                AnalyticsRepository
                .get_nudges_by_category(
                    db,
                    user_id,
                    "Goal"
                )
            )

            if len(existing_nudges) == 0:

                nudge = AINudge(
                    user_id=user_id,
                    message=(
                        f"You have ₹{savings_potential} "
                        f"available for savings. "
                        f"Consider contributing it to "
                        f"{highest_priority_goal.goal_name}."
                    ),
                    priority="Medium",
                    category="Goal"
                )

                AnalyticsRepository.create_nudge(
                    db,
                    nudge
                )

        existing_budget_nudges = (
            AnalyticsRepository
            .get_nudges_by_category(
                db,
                user_id,
                "Budget"
            )
        )
        
        if len(existing_budget_nudges) == 0:
        
            if budget_usage >= 100:
            
                AnalyticsRepository.create_nudge(
                    db,
                    AINudge(
                        user_id=user_id,
                        message=(
                            "You have exceeded your Flex Spend budget."
                        ),
                        priority="High",
                        category="Budget"
                    )
                )
        
            elif budget_usage >= 80:
            
                AnalyticsRepository.create_nudge(
                    db,
                    AINudge(
                        user_id=user_id,
                        message=(
                            f"You have used "
                            f"{round(budget_usage, 2)}% "
                            f"of your Flex Spend budget."
                        ),
                        priority="High",
                        category="Budget"
                    )
                )

        streak = (
            StreakRepository
            .get_streak(
                db,
                user_id
            )
        )
        
        if streak:
        
            existing_streak_nudges = (
                AnalyticsRepository
                .get_nudges_by_category(
                    db,
                    user_id,
                    "Streak"
                )
            )
        
            if (
                streak.current_streak >= 7
                and len(existing_streak_nudges) == 0
            ):
        
                AnalyticsRepository.create_nudge(
                    db,
                    AINudge(
                        user_id=user_id,
                        message=(
                            f"Awesome! You are on a "
                            f"{streak.current_streak}-day "
                            f"money streak."
                        ),
                        priority="Low",
                        category="Streak"
                    )
                )

        return {
            "month": month,
            "savings_potential":
                savings_potential,
            "goal_predictions":
                goal_predictions
        }
    
    @staticmethod
    def get_monthly_report(
        db: Session,
        user_id: int,
        month: str
    ):

        month = month.strip().title()

        incomes = (
            IncomeRepository
            .get_income_by_user(
                db,
                user_id
            )
        )

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

        total_income = sum(
            income.total_income
            for income in incomes
            if income.month == month
        )

        total_fixed_expense = sum(
            expense.amount
            for expense in fixed_expenses
        )

        total_variable_expense = sum(
            expense.amount
            for expense in variable_expenses
            if expense.date.strftime("%B") == month
        )

        total_expense = (
            total_fixed_expense
            + total_variable_expense
        )

        total_saved = max(
            0,
            total_income - total_expense
        )

        savings_rate = (
            round(
                (total_saved / total_income) * 100,
                2
            )
            if total_income > 0
            else 0
        )

        return {
            "month": month,
            "income": total_income,
            "fixed_expenses": total_fixed_expense,
            "variable_expenses": total_variable_expense,
            "total_expense": total_expense,
            "total_saved": total_saved,
            "savings_rate": savings_rate
        }
    
    @staticmethod
    def get_trends(
        db: Session,
        user_id: int
    ):

        analytics = (
            AnalyticsRepository
            .get_analytics(
                db,
                user_id
            )
        )

        return [
            {
                "month": record.month,
                "total_spent": record.total_spent,
                "total_saved": record.total_saved,
                "savings_rate": record.savings_rate,
                "financial_health_score":
                    record.financial_health_score
            }
            for record in analytics
        ]
    
    @staticmethod
    def get_category_comparison(
        db: Session,
        user_id: int,
        month: str
    ):

        month = month.strip().title()

        variable_expenses = (
            ExpenseRepository
            .get_variable_expenses(
                db,
                user_id
            )
        )

        category_totals = {}

        for expense in variable_expenses:

            if expense.date.strftime("%B") != month:
                continue

            category = expense.category.strip().title()

            category_totals[category] = (
                category_totals.get(
                    category,
                    0
                )
                + expense.amount
            )

        return category_totals
    
    @staticmethod
    def get_goal_report(
        db: Session,
        user_id: int
    ):

        goals = (
            GoalRepository
            .get_goals(
                db,
                user_id
            )
        )

        report = []

        for goal in goals:

            completion_percentage = round(
                (
                    goal.current_amount
                    / goal.target_amount
                ) * 100,
                2
            )

            report.append({
                "goal_name": goal.goal_name,
                "target_amount":
                    goal.target_amount,
                "current_amount":
                    goal.current_amount,
                "remaining_amount":
                    goal.target_amount
                    - goal.current_amount,
                "completion_percentage":
                    completion_percentage,
                "status":
                    goal.status
            })

        return report
    

