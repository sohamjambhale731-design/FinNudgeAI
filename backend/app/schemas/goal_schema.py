from datetime import date

from pydantic import BaseModel


class GoalCreate(BaseModel):
    goal_name: str
    target_amount: float
    priority: int
    target_date: date | None = None


class GoalUpdate(BaseModel):
    goal_name: str
    target_amount: float
    priority: int
    target_date: date | None = None


class GoalContributionCreate(BaseModel):
    amount: float
    date: date