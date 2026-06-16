from fastapi import APIRouter

from app.api.v1.endpoints.health import router as health_router
from app.api.v1.endpoints.auth import router as auth_router
from app.api.v1.endpoints import income
from app.api.v1.endpoints import expense
from app.api.v1.endpoints import goal
from app.api.v1.endpoints import analytics

api_router = APIRouter()

api_router.include_router(
    health_router,
    tags=["Health"]
)

api_router.include_router(
    auth_router
)

api_router.include_router(
    income.router
)

api_router.include_router(
    expense.router
)

api_router.include_router(
    goal.router,
    prefix="/goal",
    tags=["Goal"]
)

api_router.include_router(
    analytics.router,
    prefix="/analytics",
    tags=["Analytics"]
)