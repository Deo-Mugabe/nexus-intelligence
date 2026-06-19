"""
Nexus standard types.

The contract every federation connector normalizes into,
regardless of source system. Consumers import from here,
never from connector-specific code.

    from nexus_types import StandardBorrower, StandardLoan
"""

from nexus_types.borrower import StandardBorrower
from nexus_types.loan import StandardLoan
from nexus_types.document import StandardDocument
from nexus_types.transaction import StandardTransaction

__all__ = [
    "StandardBorrower",
    "StandardLoan",
    "StandardDocument",
    "StandardTransaction",
]