from sqlalchemy.orm import Session

from app.models.goal import (
    Goal,
    GoalContribution
)


class GoalRepository:

    @staticmethod
    def create_goal(
        db: Session,
        goal: Goal
    ):
        db.add(goal)
        db.commit()
        db.refresh(goal)

        return goal

    @staticmethod
    def get_goals(
        db: Session,
        user_id: int
    ):
        return (
            db.query(Goal)
            .filter(
                Goal.user_id == user_id
            )
            .all()
        )

    @staticmethod
    def get_goal_by_id(
        db: Session,
        goal_id: int
    ):
        return (
            db.query(Goal)
            .filter(
                Goal.goal_id == goal_id
            )
            .first()
        )

    @staticmethod
    def get_goal_by_name(
        db: Session,
        user_id: int,
        goal_name: str
    ):
        return (
            db.query(Goal)
            .filter(
                Goal.user_id == user_id,
                Goal.goal_name == goal_name
            )
            .first()
        )

    @staticmethod
    def update_goal(
        db: Session,
        goal: Goal
    ):
        db.commit()
        db.refresh(goal)

        return goal

    @staticmethod
    def delete_goal(
        db: Session,
        goal: Goal
    ):
        db.delete(goal)
        db.commit()

    @staticmethod
    def create_contribution(
        db: Session,
        contribution: GoalContribution
    ):
        db.add(contribution)
        db.commit()
        db.refresh(contribution)

        return contribution

    @staticmethod
    def get_contributions(
        db: Session,
        goal_id: int
    ):
        return (
            db.query(GoalContribution)
            .filter(
                GoalContribution.goal_id == goal_id
            )
            .all()
        )
    @staticmethod
    def get_contributions(
        db: Session,
        goal_id: int
    ):
        return (
            db.query(GoalContribution)
            .filter(
                GoalContribution.goal_id == goal_id
            )
            .all()
        )