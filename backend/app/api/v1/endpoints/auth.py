from fastapi import (
    APIRouter,
    Depends,
    HTTPException
)

from app.api.dependencies.auth import get_current_user
from app.models.user import User

from sqlalchemy.orm import Session

from app.database.dependencies import get_db

from app.schemas.auth_schema import (
    RegisterRequest,
    LoginRequest,
    TokenResponse
)

from app.services.auth_service import (
    AuthService
)

router = APIRouter(
    prefix="/auth",
    tags=["Authentication"]
)


@router.post("/register")
def register(
    request: RegisterRequest,
    db: Session = Depends(get_db)
):
    try:

        user = (
            AuthService
            .register_user(
                db,
                request.full_name,
                request.email,
                request.password,
                request.age,
                request.user_type
            )
        )

        return {
            "message": "User registered",
            "user_id": user.id
        }

    except ValueError as e:
        raise HTTPException(
            status_code=400,
            detail=str(e)
        )
    

@router.post(
    "/login",
    response_model=TokenResponse
)
def login(
    request: LoginRequest,
    db: Session = Depends(get_db)
):
    try:

        token = (
            AuthService
            .login_user(
                db,
                request.email,
                request.password
            )
        )

        return {
            "access_token": token
        }

    except ValueError as e:
        raise HTTPException(
            status_code=401,
            detail=str(e)
        )
    
@router.get("/me")
def get_me(
    current_user: User = Depends(get_current_user)
):
    return {
        "id": current_user.id,
        "full_name": current_user.full_name,
        "email": current_user.email,
        "user_type": current_user.user_type
    }