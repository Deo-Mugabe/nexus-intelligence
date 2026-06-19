"""
Standard transaction schema.

Normalizes account transaction history — credits, debits,
repayments — into one consistent shape used by agents for
cashflow and behavioral analysis.
"""

from datetime import datetime
from decimal import Decimal

from pydantic import BaseModel, Field


class StandardTransaction(BaseModel):
    """Normalized transaction record, regardless of source system."""

    id: str = Field(description="Internal Nexus identifier")
    external_id: str = Field(
        description="Transaction reference as it exists in the "
        "source system, e.g. T24 txn_ref"
    )
    source_system: str = Field(
        description="Which connector produced this record"
    )
    institution_id: str = Field(
        description="Which institution this transaction belongs to"
    )
    account_id: str = Field(
        description="Account or loan identifier this transaction "
        "is posted against"
    )

    transaction_type: str = Field(
        description="Normalized type: 'credit' or 'debit'"
    )
    amount: Decimal = Field(description="Transaction amount")
    currency: str = Field(default="UGX", description="ISO currency code")
    description: str | None = Field(
        default=None, description="Transaction narration/description"
    )

    occurred_at: datetime = Field(
        description="When the transaction was posted/valued"
    )

    metadata: dict = Field(
        default_factory=dict,
        description="Source-specific fields preserved but not "
        "part of the standard contract",
    )

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "id": "t0000001-0000-0000-0000-000000000001",
                    "external_id": "TXN-0001847-03",
                    "source_system": "postgresql",
                    "institution_id": "inst-001",
                    "account_id": "CUS-001847",
                    "transaction_type": "credit",
                    "amount": "55000000.00",
                    "currency": "UGX",
                    "description": "Trade receipts - October (seasonal dip)",
                    "occurred_at": "2024-10-10T00:00:00Z",
                    "metadata": {},
                }
            ]
        }
    }