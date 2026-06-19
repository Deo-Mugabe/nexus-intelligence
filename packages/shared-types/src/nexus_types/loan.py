"""
Standard loan schema.

Normalizes loan/credit facility records from any core banking
system into one consistent shape. Status codes, product codes,
and date formats all get translated here before reaching
consumers.
"""

from datetime import datetime
from decimal import Decimal

from pydantic import BaseModel, Field


class StandardLoan(BaseModel):
    """Normalized loan record, regardless of source system."""

    id: str = Field(description="Internal Nexus identifier")
    external_id: str = Field(
        description="The loan ID as it exists in the source system, "
        "e.g. T24 loan_no"
    )
    source_system: str = Field(
        description="Which connector produced this record"
    )
    institution_id: str = Field(
        description="Which institution this loan belongs to"
    )
    borrower_id: str = Field(
        description="Internal Nexus borrower ID this loan belongs to"
    )

    product_type: str = Field(
        description="Normalized product type: 'term_loan', "
        "'overdraft', 'group_loan', 'mortgage'"
    )
    amount: Decimal = Field(description="Original loan amount")
    currency: str = Field(default="UGX", description="ISO currency code")
    outstanding: Decimal = Field(description="Current outstanding balance")
    interest_rate: Decimal | None = Field(
        default=None, description="Annual interest rate as a decimal, e.g. 0.18"
    )

    status: str = Field(
        description="Normalized status: 'active', 'closed', "
        "'npl', 'written_off'"
    )

    disbursed_at: datetime | None = Field(
        default=None, description="When the loan was disbursed"
    )
    maturity_at: datetime | None = Field(
        default=None, description="When the loan matures"
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
                    "id": "l0000001-0000-0000-0000-000000000001",
                    "external_id": "LOAN-2847",
                    "source_system": "postgresql",
                    "institution_id": "inst-001",
                    "borrower_id": "b0000001-0000-0000-0000-000000000001",
                    "product_type": "term_loan",
                    "amount": "450000000.00",
                    "currency": "UGX",
                    "outstanding": "380000000.00",
                    "interest_rate": "0.18",
                    "status": "active",
                    "disbursed_at": "2023-01-01T00:00:00Z",
                    "maturity_at": "2026-01-01T00:00:00Z",
                    "metadata": {},
                }
            ]
        }
    }