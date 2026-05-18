
# CloudBasket — Cloud Retail Analytics Platform

An end-to-end cloud retail analytics platform built entirely on the 
Microsoft Azure stack. Ingests 9 relational CSV files from the Olist 
Brazilian E-Commerce dataset, processes them through a fully automated 
Azure Data Factory pipeline, transforms them into a dimensional star 
schema in Azure Synapse Analytics, and delivers actionable business 
insights through a 3-page interactive Power BI dashboard.

---

## Business Question

How is the Olist marketplace performing across order revenue, seller reliability, product categories, and customer satisfaction — and which sellers and product categories are driving the most value versus the most complaints?

---

## Tech Stack

| Layer | Technology |
|---|---|
| Raw Storage | Azure Blob Storage (ADLS Gen2) |
| Pipeline Orchestration | Azure Data Factory |
| Data Warehouse | Azure Synapse Analytics (DW100c) |
| Transformation | T-SQL — Star Schema + 5 Business Views |
| Reporting | Power BI Desktop |

---

## Dataset

| File | Contents | Rows |
|---|---|---|
| olist_orders_dataset.csv | Core order records | ~100K |
| olist_customers_dataset.csv | Customer details | ~100K |
| olist_order_items_dataset.csv | Line items per order | ~112K |
| olist_order_payments_dataset.csv | Payment details | ~103K |
| olist_order_reviews_dataset.csv | Customer reviews 1-5 | ~100K |
| olist_products_dataset.csv | Product catalogue | ~33K |
| olist_sellers_dataset.csv | Seller details | ~3K |
| olist_geolocation_dataset.csv | ZIP code coordinates | ~1M |
| product_category_name_translation.csv | Portuguese to English | 71 |

---

## Architecture

```
Kaggle CSVs (9 files)
        ↓
Azure Blob Storage (ADLS Gen2)
raw-retail-data container
        ↓
Azure Data Factory
PL_01_IngestAllFiles — 9 parameterised Copy Activities
Storage Event Trigger — fires automatically on new file upload
        ↓
Azure Synapse Analytics — RetailDW Dedicated SQL Pool
├── raw schema      → 9 staging tables (VARCHAR, ROUND_ROBIN, HEAP)
└── analytics schema → star schema (HASH/REPLICATE, Columnstore)
        ↓
Power BI Desktop
3-page interactive dashboard connected directly to Synapse
```

## Data Quality Issues Resolved

- Reviews CSV had commas inside quoted text — fixed via double-quote 
  escape character in ADF dataset configuration
- Geolocation coordinates exceeded VARCHAR(20) — increased to VARCHAR(50) 
  for precise decimal values
- Products CSV had typo in column names (lenght vs length) — matched 
  exactly in staging DDL
- NULL delivery timestamps for undelivered orders — handled with TRY_CAST 
  and NULL-safe joins in fact table load

---

## How to Reproduce

1. Create Azure free account at 
   [azure.microsoft.com/free](https://azure.microsoft.com/free) 
   ($200 credit — credit card required for verification only)
2. Create resource group, ADLS Gen2 storage account with hierarchical 
   namespace enabled, Synapse workspace, and ADF instance
3. Create Blob container named `raw-retail-data`
4. Download Olist dataset from Kaggle and upload all 9 CSV files 
   to the container
5. Import ADF ARM template from the `adf/` folder into your Data Factory
6. Create Dedicated SQL Pool (RetailDW) inside Synapse at DW100c
7. Run SQL scripts from `synapse/` folder in numbered order (01 to 07)
8. Connect Power BI Desktop to your Synapse dedicated SQL endpoint

**Estimated cost:** $10–20 using the $200 Azure free credit.
Pause the Dedicated SQL Pool after every session to minimise charges.

---

## Skills Demonstrated

**Data Engineering**
Azure Blob Storage · Azure Data Factory · Parameterised Pipelines · 
Storage Event Triggers · Azure Synapse Analytics · Dedicated SQL Pool · 
HASH & REPLICATE Distribution · Clustered Columnstore Index · 
Star Schema Design · Multi-table SQL JOINs · T-SQL DDL & DML

**Business Intelligence**
Power BI · DAX Measures · Data Modelling · Relationship Management · 
Conditional Formatting · KPI Cards · Interactive Slicers · 
Cross-filtering · Filled Maps

**Problem Solving**
CSV parsing error resolution · Column size optimisation · 
NULL value handling · Cross-region Azure deployment · 
Real data quality issue resolution

---
## DashBoard

<img width="1257" height="697" alt="dashboard_page1" src="https://github.com/user-attachments/assets/dacfa6a1-495e-4737-b4b3-0a93b1241451" />

---
<img width="1258" height="695" alt="dashboard_page2" src="https://github.com/user-attachments/assets/59757668-0b06-462f-b6ce-15f64411b5b6" />

---
<img width="1258" height="690" alt="dashboard_page3" src="https://github.com/user-attachments/assets/b0cb1db7-8017-4499-96b1-b86607eecd7a" />

