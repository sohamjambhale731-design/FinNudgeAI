from datetime import datetime, timedelta

from jose import jwt, JWTError
from argon2 import PasswordHasher

from app.core.config import settings


ph = PasswordHasher()


def hash_password(password: str) -> str:
    return ph.hash(password)


def verify_password(
    plain_password: str,
    hashed_password: str
) -> bool:
    try:
        return ph.verify(
            hashed_password,
            plain_password
        )
    except Exception:
        return False


def create_access_token(
    data: dict,
    expires_minutes: int = 60
):
    to_encode = data.copy()

    expire = datetime.utcnow() + timedelta(
        minutes=expires_minutes
    )

    to_encode.update(
        {"exp": expire}
    )

    return jwt.encode(
        to_encode,
        settings.JWT_SECRET_KEY,
        algorithm=settings.JWT_ALGORITHM
    )


def decode_token(token: str):
    try:
        payload = jwt.decode(
            token,
            settings.JWT_SECRET_KEY,
            algorithms=[settings.JWT_ALGORITHM]
        )

        return payload

    except JWTError:
        return None