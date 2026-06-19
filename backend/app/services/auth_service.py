from sqlalchemy.orm import Session

from app.models.user import User

from app.services.token_service import TokenService

from app.repositories.auth_repository import (
    AuthRepository
)

from app.core.security import (
    hash_password,
    verify_password,
    create_access_token
)


class AuthService:

    @staticmethod
    def register_user(
        db: Session,
        full_name: str,
        email: str,
        password: str,
        age: int,
        user_type: str
    ):

        existing_user = (
            AuthRepository
            .get_user_by_email(
                db,
                email
            )
        )

        if existing_user:
            raise ValueError(
                "Email already registered"
            )

        user = User(
            full_name=full_name,
            email=email,
            password_hash=hash_password(password),
            age=age,
            user_type=user_type
        )

        return (
            AuthRepository
            .create_user(
                db,
                user
            )
        )

    @staticmethod
    def login_user(
        db: Session,
        email: str,
        password: str
    ):

        user = (
            AuthRepository
            .get_user_by_email(
                db,
                email
            )
        )

        if not user:
            raise ValueError(
                "Invalid credentials"
            )

        if not verify_password(
            password,
            user.password_hash
        ):
            raise ValueError(
                "Invalid credentials"
            )

        access_token = create_access_token(
            {
                "sub": str(user.id)
            }
        )

        refresh_token = (
            TokenService
            .generate_refresh_token(
                db,
                user.id
            )
        )

        return {
            "access_token": access_token,
            "refresh_token": refresh_token,
            "token_type": "bearer"
        }
    
    @staticmethod
    def reset_password(
        db: Session,
        email: str,
        new_password: str
    ):
    
        user = (
            AuthRepository
            .get_user_by_email(
                db,
                email
            )
        )
    
        if not user:
            raise ValueError(
                "User not found"
            )
    
        user.password_hash = hash_password(
            new_password
        )
    
        db.commit()
    
        return True