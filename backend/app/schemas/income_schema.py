from datetime import date

from pydantic import BaseModel


class IncomeCreate(BaseModel):
    primary_income: float
    month: str
    year: int


class IncomeUpdate(BaseModel):
    primary_income: float


class AdditionalIncomeCreate(BaseModel):
    source_name: str
    amount: float
    date: date


class IncomeResponse(BaseModel):
    income_id: int
    primary_income: float
    total_additional_income: float
    total_income: float
    month: str
    year: int

    class Config:
        from_attributes = True
