from pydantic import BaseModel


class DashboardRequest(BaseModel):
    month: str