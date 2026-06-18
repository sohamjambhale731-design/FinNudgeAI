from datetime import date

from pydantic import BaseModel


class FixedExpenseCreate(BaseModel):
    category: str
    subcategory: str
    amount: float
    recurring: bool = True


class FixedExpenseUpdate(BaseModel):
    category: str
    subcategory: str
    amount: float
    recurring: bool


class VariableExpenseCreate(BaseModel):
    category: str
    amount: float
    note: str
    date: date


class VariableExpenseUpdate(BaseModel):
    category: str
    amount: float
    note: str


class VariableBudgetCreate(BaseModel):
    month: str
    allocated_budget: float


class VariableBudgetUpdate(BaseModel):
    allocated_budget: float