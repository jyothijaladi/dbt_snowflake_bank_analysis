Banking Data Engineering Project
This is a comprehensive data engineering project designed to demonstrate proficiency in building robust, scalable, and maintainable data pipelines using DBT (Data Build Tool). The project models a banking domain, covering key customer, account, transaction, and card data, transformed into actionable insights through multiple layers.

Key Features
DBT Models: The project contains several DBT models organized into different layers:

Staging Models – Raw data transformation and basic cleaning.

Intermediate Models – Data enrichment and joining multiple datasets.

Mart Models – Aggregated and business-ready data for reporting and analysis.

Snowflake: The project leverages Snowflake as the data warehouse for storing and processing large volumes of data.

Incremental Models: Some models are designed as incremental for efficient data processing, focusing only on the new or updated records.

Macros: Custom macros are used to simplify recurring transformations, such as surrogate key generation and date formatting.

Snapshots: The project includes snapshot functionality for tracking historical changes in customer, account, and transaction data.

Tests: Data quality is ensured using singular tests that validate data integrity and consistency at different stages.

Documentation: The project is thoroughly documented with descriptions, test cases, and use of DBT's built-in documentation features to ensure clarity.

Data Models
Staging Models:

stg_customers, stg_accounts, stg_transactions, stg_cards, stg_card_transactions

These models transform raw data into a clean, consistent format.

Intermediate Models:

int_customer_accounts, int_customer_transactions, int_customer_card_usage

These models enrich the data, join multiple sources, and prepare it for aggregation.

Mart Models:

mart_customer_balance, mart_customer_transactions, mart_customer_account_balance

These models aggregate the data and provide business-ready metrics.

Features and Functionalities
Surrogate Keys: The project uses surrogate keys to ensure uniqueness and optimize joins across large tables.

Data Enrichment: Information like account types, transaction categories, and country details are enriched from lookup tables and seed data.

Business Logic: Several mart models apply business rules to calculate customer balances, transaction categories, and card usage.

Incremental Load: For efficiency, some models are incrementally loaded, processing only new or updated records.

Technologies Used
DBT (Data Build Tool): For transforming data in a modular, testable, and version-controlled manner.

Snowflake: Cloud-based data warehouse for storage and processing.

SQL: For data transformations and modeling.

GitHub: For version control and collaborative work on DBT models.

Project Structure
plaintext
Copy
Edit
.
├── models/
│   ├── staging/
│   ├── intermediate/
│   ├── mart/
├── macros/
├── snapshots/
├── tests/
├── analysis/
├── dbt_project.yml
├── schema.yml
└── README.md
Running the Project
Set up the environment:

Install dependencies

Set up the Snowflake credentials in profiles.yml.

Run DBT Models:

To run all models: dbt run.

To run specific models: dbt run --models <model_name>.

Run DBT Snapshots:

dbt snapshot to create snapshot tables that track historical data changes.

Run DBT Tests:

dbt test to validate the models with built-in tests.

Future Work (Next Sprint)
Implement singular tests for data validation.

Finalize documentation for all models.

Review and optimize incremental models for performance.
