from fastapi import FastAPI

from app.api.v1.api import api_router

from fastapi import HTTPException

from app.core.exceptions import (
    FinNudgeException,
    finnudge_exception_handler,
    http_exception_handler
)

app = FastAPI(
    title="FinNudge AI",
    version="1.0.0"
)

app.add_exception_handler(
    FinNudgeException,
    finnudge_exception_handler
)

app.add_exception_handler(
    HTTPException,
    http_exception_handler
)

app.include_router(
    api_router,
    prefix="/api/v1"
)