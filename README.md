# Advanced MySQL Finance Tracker

A fully relational database designed to track personal finances, demonstrating advanced MySQL features for data integrity and reporting.

## Key Features Built:
* **Relational Schema:** Designed normalized tables for Users, Accounts, Categories, and Transactions using strict Foreign Key constraints.
* **Automated Data Integrity (Triggers):** Implemented `AFTER INSERT` triggers to automatically calculate and update account balances whenever new transactions are recorded, removing the need for application-layer math.
* **Optimized Reporting (Views):** Built virtual Views utilizing `JOIN`s and `SUM()` aggregations to instantly generate monthly spending reports grouped by category.
* **Encapsulation (Stored Procedures):** Developed custom Stored Procedures (e.g., `AddTransaction()`) to safely insert data and utilize built-in functions like `CURDATE()`.
