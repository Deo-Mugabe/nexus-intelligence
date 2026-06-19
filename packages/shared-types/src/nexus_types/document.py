"""
Standard document schema.

Normalizes documents from SharePoint and local PDF storage
into one consistent shape. Content extraction, classification,
and metadata all flow through here before reaching the context
engine or any agent.
"""

from datetime import datetime

from pydantic import BaseModel, Field


class StandardDocument(BaseModel):
    """Normalized document record, regardless of source system."""

    id: str = Field(description="Internal Nexus identifier")
    external_id: str = Field(
        description="SharePoint item ID, or filename for local PDFs"
    )
    source_system: str = Field(
        description="Which connector produced this record, "
        "e.g. 'sharepoint', 'local_pdf'"
    )
    institution_id: str = Field(
        description="Which institution this document belongs to"
    )
    borrower_id: str | None = Field(
        default=None,
        description="Which borrower this document relates to, if applicable",
    )

    name: str = Field(description="Cleaned, human-readable document name")
    doc_type: str = Field(
        description="Normalized type: 'financial_statement', "
        "'credit_memo', 'collateral_doc', 'correspondence', "
        "'id_document'"
    )

    content: str | None = Field(
        default=None,
        description="Extracted text content, populated after "
        "the document intelligence pipeline runs",
    )
    file_path: str = Field(
        description="Where to retrieve the actual file — a download "
        "URL for SharePoint, an absolute path for local PDFs"
    )

    created_at: datetime | None = Field(
        default=None, description="When the document was originally created"
    )
    modified_at: datetime | None = Field(
        default=None, description="When the document was last modified"
    )
    author: str | None = Field(
        default=None, description="Document author, if known"
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
                    "id": "d0000001-0000-0000-0000-000000000001",
                    "external_id": "KT001_financial_statement_2024Q3.pdf",
                    "source_system": "local_pdf",
                    "institution_id": "inst-001",
                    "borrower_id": "b0000001-0000-0000-0000-000000000001",
                    "name": "Kampala Traders Financial Statement Q3 2024",
                    "doc_type": "financial_statement",
                    "content": None,
                    "file_path": "/data/documents/financial_statements/"
                    "KT001_financial_statement_2024Q3.pdf",
                    "created_at": "2024-10-05T00:00:00Z",
                    "modified_at": "2024-10-05T00:00:00Z",
                    "author": None,
                    "metadata": {},
                }
            ]
        }
    }