from sqlalchemy.orm import Session

from app.repositories.income_repository import (
    IncomeRepository
)

from app.repositories.expense_repository import (
    ExpenseRepository
)

from app.repositories.goal_repository import (
    GoalRepository
)

from app.repositories.analytics_repository import (
    AnalyticsRepository
)


class DashboardService:

    @staticmethod
    def get_dashboard(
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

        budgets = (
            ExpenseRepository
            .get_variable_budgets(
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

        analytics = (
            AnalyticsRepository
            .get_analytics(
                db,
                user_id
            )
        )

        nudges = (
            AnalyticsRepository
            .get_nudges(
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
            total_income
            - total_expense
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

        remaining_budget = (
            budget.remaining_budget
            if budget
            else 0
        )

        latest_nudge = (
            nudges[-1].message
            if nudges
            else "No insights available."
        )

        latest_analytics = (
            analytics[-1]
            if analytics
            else None
        )

        nearest_goal = (
            goals[0].goal_name
            if goals
            else None
        )

        return {

            "wallet_summary": {
                "total_income": total_income,
                "total_expense": total_expense,
                "total_saved": total_saved
            },

            "ai_insight": {
                "message": latest_nudge
            },

            "essentials": {
                "fixed_expense":
                    total_fixed_expense
            },

            "flex_spend": {
                "allocated_budget":
                    allocated_budget,
                "remaining_budget":
                    remaining_budget
            },

            "goals_overview": {
                "active_goals":
                    len(goals),
                "nearest_goal":
                    nearest_goal
            },

            "money_streak": {
                "current_streak":
                    "Coming Soon"
            },

            "monthly_snapshot": {
                "financial_health_score":
                    latest_analytics.financial_health_score
                    if latest_analytics
                    else 0
            }
        }