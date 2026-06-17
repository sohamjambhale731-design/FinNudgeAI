from pydantic import BaseModel


class AnalyticsGenerate(BaseModel):
    month: str