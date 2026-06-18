from fastapi import FastAPI

from app.api.v1.api import api_router
from fastapi.middleware.cors import CORSMiddleware

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

app.add_middleware(
    CORSMiddleware,

    # allow_origins=[
    #     "http://localhost:3000",
    #     "http://localhost:5000",
    #     "http://localhost:8000",
    #     "http://127.0.0.1:8000",
    #     "http://localhost",
    #     "http://127.0.0.1",
    # ],

    # allow_credentials=True,
    # allow_methods=["*"],
    # allow_headers=["*"],
        
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
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