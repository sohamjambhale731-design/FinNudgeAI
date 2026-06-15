from fastapi import (
    APIRouter,
    Depends
)

from sqlalchemy.orm import Session

from app.database.dependencies import get_db

from app.api.dependencies.auth import (
    get_current_user
)

from app.models.user import User

from app.schemas.expense_schema import (
    FixedExpenseCreate
)

from app.services.expense_service import (
    ExpenseService
)

from app.schemas.expense_schema import (
    FixedExpenseCreate,
    FixedExpenseUpdate,
    VariableExpenseCreate,
    VariableExpenseUpdate,
    VariableBudgetCreate,
    VariableBudgetUpdate
)

router = APIRouter(
    prefix="/expense",
    tags=["Expense"]
)


@router.post("/fixed")
def create_fixed_expense(
    request: FixedExpenseCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        ExpenseService
        .create_fixed_expense(
            db,
            current_user.id,
            request.category,
            request.subcategory,
            request.amount,
            request.recurring
        )
    )


@router.get("/fixed")
def get_fixed_expenses(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        ExpenseService
        .get_fixed_expenses(
            db,
            current_user.id
        )
    )

@router.put("/fixed/{expense_id}")
def update_fixed_expense(
    expense_id: int,
    request: FixedExpenseUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        ExpenseService
        .update_fixed_expense(
            db,
            expense_id,
            current_user.id,
            request.category,
            request.subcategory,
            request.amount,
            request.recurring
        )
    )

@router.delete("/fixed/{expense_id}")
def delete_fixed_expense(
    expense_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        ExpenseService
        .delete_fixed_expense(
            db,
            expense_id,
            current_user.id
        )
    )

@router.post("/variable")
def create_variable_expense(
    request: VariableExpenseCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        ExpenseService
        .create_variable_expense(
            db,
            current_user.id,
            request.category,
            request.amount,
            request.note,
            request.date
        )
    )


@router.get("/variable")
def get_variable_expenses(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        ExpenseService
        .get_variable_expenses(
            db,
            current_user.id
        )
    )

@router.put("/variable/{expense_id}")
def update_variable_expense(
    expense_id: int,
    request: VariableExpenseUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        ExpenseService
        .update_variable_expense(
            db,
            expense_id,
            current_user.id,
            request.category,
            request.amount,
            request.note
        )
    )


@router.delete("/variable/{expense_id}")
def delete_variable_expense(
    expense_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        ExpenseService
        .delete_variable_expense(
            db,
            expense_id,
            current_user.id
        )
    )

@router.post("/budget")
def create_budget(
    request: VariableBudgetCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        ExpenseService
        .create_variable_budget(
            db,
            current_user.id,
            request.month,
            request.allocated_budget
        )
    )


@router.get("/budget")
def get_budgets(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        ExpenseService
        .get_variable_budgets(
            db,
            current_user.id
        )
    )

@router.put("/budget/{budget_id}")
def update_budget(
    budget_id: int,
    request: VariableBudgetUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        ExpenseService
        .update_variable_budget(
            db,
            budget_id,
            current_user.id,
            request.allocated_budget
        )
    )

@router.delete("/budget/{budget_id}")
def delete_budget(
    budget_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        ExpenseService
        .delete_variable_budget(
            db,
            budget_id,
            current_user.id
        )
    )

@router.get("/analytics")
def get_expense_analytics(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return (
        ExpenseService
        .get_expense_analytics(
            db,
            current_user.id
        )
    )