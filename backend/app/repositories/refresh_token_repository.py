from sqlalchemy.orm import Session

from app.models.refresh_token import RefreshToken


class RefreshTokenRepository:

    @staticmethod
    def create(
        db: Session,
        refresh_token: RefreshToken
    ):
        db.add(refresh_token)
        db.commit()
        db.refresh(refresh_token)

        return refresh_token

    @staticmethod
    def get_token(
        db: Session,
        token: str
    ):
        return (
            db.query(RefreshToken)
            .filter(
                RefreshToken.token == token
            )
            .first()
        )

    @staticmethod
    def revoke_token(
        db: Session,
        token_obj: RefreshToken
    ):
        token_obj.is_revoked = True

        db.commit()