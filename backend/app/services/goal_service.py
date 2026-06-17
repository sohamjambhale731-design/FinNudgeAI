from sqlalchemy.orm import Session

from app.models.goal import (
    Goal,
    GoalContribution
)

from app.repositories.goal_repository import (
    GoalRepository
)


class GoalService:

    @staticmethod
    def create_goal(
        db: Session,
        user_id: int,
        goal_name: str,
        target_amount: float,
        priority: int,
        target_date
    ):

        goal_name = goal_name.strip().title()

        if target_amount <= 0:
            raise ValueError(
                "Target amount must be greater than zero"
            )

        if priority not in [1, 2, 3]:
            raise ValueError(
                "Priority must be 1, 2 or 3"
            )

        existing_goal = (
            GoalRepository
            .get_goal_by_name(
                db,
                user_id,
                goal_name
            )
        )

        if existing_goal:
            raise ValueError(
                "Goal already exists"
            )

        goal = Goal(
            user_id=user_id,
            goal_name=goal_name,
            target_amount=target_amount,
            current_amount=0,
            priority=priority,
            target_date=target_date,
            status="Active"
        )

        return (
            GoalRepository
            .create_goal(
                db,
                goal
            )
        )

    @staticmethod
    def get_goals(
        db: Session,
        user_id: int
    ):
        return (
            GoalRepository
            .get_goals(
                db,
                user_id
            )
        )

    @staticmethod
    def update_goal(
        db: Session,
        goal_id: int,
        user_id: int,
        goal_name: str,
        target_amount: float,
        priority: int,
        target_date
    ):

        goal = (
            GoalRepository
            .get_goal_by_id(
                db,
                goal_id
            )
        )

        if not goal:
            raise ValueError(
                "Goal not found"
            )

        if goal.user_id != user_id:
            raise ValueError(
                "Unauthorized"
            )

        goal_name = goal_name.strip().title()

        if target_amount <= 0:
            raise ValueError(
                "Target amount must be greater than zero"
            )

        if priority not in [1, 2, 3]:
            raise ValueError(
                "Priority must be 1, 2 or 3"
            )

        goal.goal_name = goal_name
        goal.target_amount = target_amount
        goal.priority = priority
        goal.target_date = target_date

        return (
            GoalRepository
            .update_goal(
                db,
                goal
            )
        )

    @staticmethod
    def delete_goal(
        db: Session,
        goal_id: int,
        user_id: int
    ):

        goal = (
            GoalRepository
            .get_goal_by_id(
                db,
                goal_id
            )
        )

        if not goal:
            raise ValueError(
                "Goal not found"
            )

        if goal.user_id != user_id:
            raise ValueError(
                "Unauthorized"
            )

        GoalRepository.delete_goal(
            db,
            goal
        )

        return {
            "message": "Goal deleted"
        }

    @staticmethod
    def add_contribution(
        db: Session,
        goal_id: int,
        user_id: int,
        amount: float,
        contribution_date
    ):

        goal = (
            GoalRepository
            .get_goal_by_id(
                db,
                goal_id
            )
        )

        if not goal:
            raise ValueError(
                "Goal not found"
            )

        if goal.user_id != user_id:
            raise ValueError(
                "Unauthorized"
            )

        if amount <= 0:
            raise ValueError(
                "Contribution must be greater than zero"
            )

        remaining_amount = (
            goal.target_amount
            - goal.current_amount
        )

        if amount > remaining_amount:
            raise ValueError(
                f"Only {remaining_amount} remaining to complete this goal"
            )

        contribution = GoalContribution(
            goal_id=goal_id,
            amount=amount,
            date=contribution_date
        )

        GoalRepository.create_contribution(
            db,
            contribution
        )

        goal.current_amount += amount

        if goal.current_amount >= goal.target_amount:
            goal.status = "Completed"

        GoalRepository.update_goal(
            db,
            goal
        )

        return goal
    
    @staticmethod
    def get_goal_contributions(
        db: Session,
        goal_id: int,
        user_id: int
    ):
    
        goal = (
            GoalRepository
            .get_goal_by_id(
                db,
                goal_id
            )
        )
    
        if not goal:
            raise ValueError(
                "Goal not found"
            )
    
        if goal.user_id != user_id:
            raise ValueError(
                "Unauthorized"
            )
    
        return (
            GoalRepository
            .get_contributions(
                db,
                goal_id
            )
        )

    @staticmethod
    def get_goal_analytics(
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

        analytics = []

        for goal in goals:

            if goal.target_amount == 0:
                progress = 0
            else:
                progress = (
                    goal.current_amount
                    / goal.target_amount
                ) * 100

            analytics.append({
                "goal_id": goal.goal_id,
                "goal_name": goal.goal_name,
                "target_amount": goal.target_amount,
                "current_amount": goal.current_amount,
                "remaining_amount":
                    goal.target_amount
                    - goal.current_amount,
                "progress_percentage":
                    round(progress, 2),
                "status": goal.status,
                "priority": goal.priority
            })

        return analytics