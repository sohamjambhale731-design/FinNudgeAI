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
from app.services.streak_service import (
    StreakService
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

        print("USER ID:", user_id)
        print("MONTH:", month)
        print("INCOMES:", incomes)

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

        additional_incomes = (
            IncomeRepository
            .get_additional_income(
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

        streak_data = (
            StreakService
            .get_streak_analytics(
                db,
                user_id
            )
        )

        for income in incomes:
            print(
                "DB MONTH:",
                income.month,
                "TOTAL:",
                income.total_income
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

        recent_transactions = []

        # Income (use the primary income as "Salary")
        for income in incomes:
            if income.month != month:
                continue
            # Income model has month/year, convert to a concrete date for sorting
            # Construct first day of the income month/year (Income model doesn't store a date)
            from datetime import date, datetime
            month_number = datetime.strptime(income.month, "%B").month
            txn_date = date(income.year, month_number, 1)

            recent_transactions.append({
                "type": "income",
                "category": "Salary",
                "note": "Monthly Salary",
                "amount": income.total_income,
                "date": txn_date
            })

        # Additional Income
        for income in additional_incomes:
            recent_transactions.append({

                "type": "income",
                "category": "Additional Income",
                "note": income.source_name,
                "amount": income.amount,
                "date": income.date

            })

        # Variable expenses
        recent_transactions.extend([
            {
                "type": "expense",
                "category": expense.category,
                "note": expense.note,
                "amount": expense.amount,
                "date": expense.date
            }
            for expense in variable_expenses
            if expense.date.strftime("%B") == month
        ])


        # Goal contributions
        for goal in goals:
            contributions = GoalRepository.get_contributions(db, goal.goal_id)
            for contribution in contributions:
                recent_transactions.append({
                    "type": "goal",
                    "category": "Savings",
                    "note": f"Contribution to {goal.goal_name}",
                    "amount": contribution.amount,
                    "date": contribution.date
                })

        # Sort newest first and take latest 5
        recent_transactions.sort(key=lambda x: x["date"], reverse=True)
        recent_transactions = recent_transactions[:3]

        for transaction in recent_transactions:
            if transaction["date"] is not None:
                transaction["date"] = transaction["date"].isoformat()


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
                "goal_name":
                    goals[0].goal_name if goals else "No Active Goal",
                "current_amount":
                    goals[0].current_amount if goals else 0,
                "target_amount":
                    goals[0].target_amount if goals else 0,
                "next_goal":
                    goals[1].goal_name if len(goals) > 1 else "",
                "active_goals":
                    len(goals)
            },

            "recent_transactions": recent_transactions,

            "money_streak": {
                "current_streak":
                    streak_data["current_streak"],

                "longest_streak":
                    streak_data["longest_streak"],

                "level":
                    streak_data["level"]
            },

            

            "monthly_snapshot": {
                "income":
                    total_income,

                "expenses":
                    total_expense,

                "savings":
                    total_saved,

                "financial_health_score":
                    latest_analytics.financial_health_score
                    if latest_analytics
                    else 0
            }
        }