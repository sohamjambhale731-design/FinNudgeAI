from datetime import datetime, timedelta
import secrets

from sqlalchemy.orm import Session

from app.models.refresh_token import RefreshToken

from app.repositories.refresh_token_repository import (
    RefreshTokenRepository
)

from app.core.security import (
    create_access_token
)


class TokenService:

    @staticmethod
    def generate_refresh_token(
        db: Session,
        user_id: int
    ):

        token = secrets.token_urlsafe(64)

        refresh_token = RefreshToken(
            user_id=user_id,
            token=token,
            expires_at=datetime.utcnow()
            + timedelta(days=7)
        )

        RefreshTokenRepository.create(
            db,
            refresh_token
        )

        return token

    @staticmethod
    def refresh_access_token(
        db: Session,
        refresh_token: str
    ):

        token_obj = (
            RefreshTokenRepository
            .get_token(
                db,
                refresh_token
            )
        )

        if not token_obj:
            raise ValueError(
                "Invalid refresh token"
            )

        if token_obj.is_revoked:
            raise ValueError(
                "Refresh token revoked"
            )

        if token_obj.expires_at < datetime.utcnow():
            raise ValueError(
                "Refresh token expired"
            )

        access_token = create_access_token(
            {
                "sub": str(token_obj.user_id)
            }
        )

        return access_token
    
    @staticmethod
    def revoke_refresh_token(
        db: Session,
        refresh_token: str
    ):
    
        token_obj = (
            RefreshTokenRepository
            .get_token(
                db,
                refresh_token
            )
        )
    
        if not token_obj:
            raise ValueError(
                "Invalid refresh token"
            )
    
        RefreshTokenRepository.revoke_token(
            db,
            token_obj
        )
    
        return True
    



