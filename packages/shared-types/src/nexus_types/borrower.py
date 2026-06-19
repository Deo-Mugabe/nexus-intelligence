"""
Standard borrower schema.

Every connector — PostgreSQL, MySQL, SharePoint, local PDF —
normalizes its source-specific data into this exact shape.
Consumers (context engine, agents) only ever see this schema.
They never know which source system the data came from
unless they explicitly inspect source_system.
"""

from datetime import datetime
from typing import Any

from pydantic import BaseModel, Field


class StandardBorrower(BaseModel):
    """Normalized borrower record, regardless of source system."""

    id: str = Field(
        description="Internal Nexus identifier (UUID or stable derived ID)"
    )
    external_id: str = Field(
        description="The ID as it exists in the source system, "
        "e.g. T24 customer_no or MySQL customer_id"
    )
    source_system: str = Field(
        description="Which connector produced this record, "
        "e.g. 'postgresql', 'mysql'"
    )
    institution_id: str = Field(
        description="Which institution this borrower belongs to"
    )

    name: str = Field(description="Borrower's full legal name")
    sector: str = Field(
        description="Human-readable sector, e.g. 'trade', 'agriculture'. "
        "Always decoded from source-specific codes or labels."
    )
    business_type: str | None = Field(
        default=None,
        description="e.g. 'limited_company', 'sole_proprietor', 'sacco'",
    )
    status: str = Field(
        description="Normalized status: 'active', 'closed', "
        "'suspended', 'dormant', 'blocked'"
    )
    risk_grade: str | None = Field(
        default=None,
        description="Normalized risk grade: 'A', 'B', 'C', 'D'",
    )
    registration_no: str | None = Field(
        default=None, description="Business registration number, if known"
    )

    opened_at: datetime | None = Field(
        default=None, description="When this borrower relationship began"
    )

    metadata: dict[str, Any] = Field(
        default_factory=dict,
        description="Source-specific fields preserved but not "
        "part of the standard contract, e.g. relationship manager "
        "name, last contact date",
    )

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "id": "b0000001-0000-0000-0000-000000000001",
                    "external_id": "CUS-001847",
                    "source_system": "postgresql",
                    "institution_id": "inst-001",
                    "name": "Kampala Traders Ltd",
                    "sector": "trade",
                    "business_type": "limited_company",
                    "status": "active",
                    "risk_grade": "B",
                    "registration_no": "REG-UG-44120",
                    "opened_at": "2019-03-15T00:00:00Z",
                    "metadata": {},
                }
            ]
        }
    }