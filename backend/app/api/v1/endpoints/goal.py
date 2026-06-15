from fastapi import (
    APIRouter,
    Depends
)

from sqlalchemy.orm import Session

from app.database.dependencies import (
    get_db
)

from app.api.dependencies.auth import (
    get_current_user
)

from app.models.user import User

from app.schemas.goal_schema import (
    GoalCreate,
    GoalUpdate,
    GoalContributionCreate
)

from app.services.goal_service import (
    GoalService
)

router = APIRouter()


@router.post("/")
def create_goal(
    request: GoalCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        GoalService
        .create_goal(
            db,
            current_user.id,
            request.goal_name,
            request.target_amount,
            request.priority,
            request.target_date
        )
    )


@router.get("/")
def get_goals(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        GoalService
        .get_goals(
            db,
            current_user.id
        )
    )


@router.put("/{goal_id}")
def update_goal(
    goal_id: int,
    request: GoalUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        GoalService
        .update_goal(
            db,
            goal_id,
            current_user.id,
            request.goal_name,
            request.target_amount,
            request.priority,
            request.target_date
        )
    )


@router.delete("/{goal_id}")
def delete_goal(
    goal_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        GoalService
        .delete_goal(
            db,
            goal_id,
            current_user.id
        )
    )


@router.post("/{goal_id}/contribute")
def contribute_to_goal(
    goal_id: int,
    request: GoalContributionCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        GoalService
        .add_contribution(
            db,
            goal_id,
            current_user.id,
            request.amount,
            request.date
        )
    )

@router.get("/{goal_id}/contributions")
def get_goal_contributions(
    goal_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        GoalService
        .get_goal_contributions(
            db,
            goal_id,
            current_user.id
        )
    )

@router.get("/analytics")
def get_goal_analytics(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        GoalService
        .get_goal_analytics(
            db,
            current_user.id
        )
    )