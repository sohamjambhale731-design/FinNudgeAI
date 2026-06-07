from app.database.base import Base
from app.database.session import engine

from app.models.user import User
from app.models.income import Income
from app.models.income import AdditionalIncome
from app.models.expense import FixedExpense
from app.models.expense import VariableExpense
from app.models.expense import VariableBudget
from app.models.goal import Goal
from app.models.goal import GoalContribution
from app.models.ai_nudge import AINudge
from app.models.streak import Streak
from app.models.analytics import Analytics
from app.models.notification import Notification
from app.models.otp_verification import OTPVerification 
from app.models.refresh_token import RefreshToken
from app.models.user_activity_log import UserActivityLog

Base.metadata.create_all(bind=engine)

print("Tables created successfully!")
