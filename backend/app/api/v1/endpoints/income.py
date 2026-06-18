from fastapi import (
    APIRouter,
    Depends,
    HTTPException
)

from sqlalchemy.orm import Session
from app.schemas.income_schema import (
    IncomeCreate,
    AdditionalIncomeCreate,
    IncomeUpdate
)

from app.database.dependencies import (
    get_db
)

from app.api.dependencies.auth import (
    get_current_user
)

from app.models.user import User

from app.schemas.income_schema import (
    IncomeCreate,
    AdditionalIncomeCreate
)

from app.services.income_service import (
    IncomeService
)

router = APIRouter(
    prefix="/income",
    tags=["Income"]
)

@router.post("/")
def create_income(
    request: IncomeCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    income = (
        IncomeService
        .create_income(
            db,
            current_user.id,
            request.primary_income,
            request.month
        )
    )

    return income

@router.get("/")
def get_income(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        IncomeService
        .get_user_income(
            db,
            current_user.id
        )
    )

@router.post("/additional")
def create_additional_income(
    request: AdditionalIncomeCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    income = (
        IncomeService
        .add_additional_income(
            db,
            current_user.id,
            request.source_name,
            request.amount,
            request.date
        )
    )

    return {
        "additional_income_id": income.additional_income_id,
        "source_name": income.source_name,
        "amount": income.amount,
        "date": income.date,
        "message": "Additional income added successfully"
    }

@router.put("/{income_id}")
def update_income(
    income_id: int,
    request: IncomeUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        IncomeService
        .update_income(
            db,
            income_id,
            request.primary_income,
            current_user.id
        )
    )

@router.delete("/{income_id}")
def delete_income(
    income_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        IncomeService
        .delete_income(
            db,
            income_id,
            current_user.id
        )
    )

@router.get("/analytics")
def get_income_analytics(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        IncomeService
        .get_income_analytics(
            db,
            current_user.id
        )
    )