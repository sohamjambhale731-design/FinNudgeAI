from fastapi import (
    APIRouter,
    Depends,
    HTTPException
)

from app.schemas.auth_schema import (
    RefreshTokenRequest,
    RefreshTokenResponse
)

from app.services.token_service import (
    TokenService
)
from app.schemas.auth_schema import( LogoutRequest )
from app.api.dependencies.auth import get_current_user
from app.models.user import User

from sqlalchemy.orm import Session

from app.database.dependencies import get_db

from app.schemas.auth_schema import (
    RegisterRequest,
    LoginRequest,
    TokenResponse
)
from app.services.otp_service import OTPService

from app.schemas.auth_schema import (
    SendOTPRequest,
    VerifyOTPRequest,
    ResetPasswordRequest,
)
from app.services.auth_service import AuthService
from app.repositories.auth_repository import AuthRepository
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

        tokens = (
            AuthService
            .login_user(
                db,
                request.email,
                request.password
            )
        )

        return tokens

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


@router.post(
    "/refresh",
    response_model=RefreshTokenResponse
)
def refresh_token(
    request: RefreshTokenRequest,
    db: Session = Depends(get_db)
):

    try:

        access_token = (
            TokenService
            .refresh_access_token(
                db,
                request.refresh_token
            )
        )

        return {
            "access_token": access_token
        }

    except ValueError as e:
        raise HTTPException(
            status_code=401,
            detail=str(e)
        )
    

@router.post("/logout")
def logout(
    request: LogoutRequest,
    db: Session = Depends(get_db)
):

    try:

        TokenService.revoke_refresh_token(
            db,
            request.refresh_token
        )

        return {
            "message": "Logged out successfully"
        }

    except ValueError as e:
        raise HTTPException(
            status_code=401,
            detail=str(e)
        )
    
@router.post("/send-otp")
def send_otp(
    request: SendOTPRequest,
    db: Session = Depends(get_db)
):

    user = (
        AuthRepository
        .get_user_by_email(
            db,
            request.email
        )
    )

    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )

    otp = (
        OTPService
        .generate_otp(
            db,
            user.id
        )
    )

    return {
        "message": "OTP generated",
        "otp": otp
    }

@router.post("/verify-otp")
def verify_otp(
    request: VerifyOTPRequest,
    db: Session = Depends(get_db)
):

    user = (
        AuthRepository
        .get_user_by_email(
            db,
            request.email
        )
    )

    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )

    OTPService.verify_otp(
        db,
        user.id,
        request.otp
    )

    return {
        "message": "OTP verified"
    }

@router.post("/send-reset-otp")
def send_reset_otp(
    request: SendOTPRequest,
    db: Session = Depends(get_db),
):

    try:
        return (
            AuthService
            .send_reset_otp(
                db,
                request.email,
            )
        )
    except ValueError as e:
        raise HTTPException(
            status_code=400,
            detail=str(e),
        )


@router.post("/reset-password")
def reset_password(
    request: ResetPasswordRequest,
    db: Session = Depends(get_db),
):

    try:
        user = AuthRepository.get_user_by_email(
            db,
            request.email,
        )

        if not user:
            raise HTTPException(
                status_code=404,
                detail="User not found",
            )

        OTPService.verify_otp(
            db,
            user.id,
            request.otp,
        )

        AuthService.reset_password(
            db,
            request.email,
            request.new_password,
        )

        return {
            "message": "Password reset successful",
        }

    except ValueError as e:
        raise HTTPException(
            status_code=400,
            detail=str(e),
        )
