# Azure-Projects

A collection of end-to-end cloud data engineering and analytics projects 
built entirely on the Microsoft Azure stack. Each project covers the full 
data lifecycle — from raw file ingestion through automated ETL pipelines, 
cloud data warehousing, dimensional modelling, and executive-level business 
intelligence reporting.

---

## About This Repository

These projects were built to demonstrate production-grade data engineering 
capability across the Microsoft Azure ecosystem — the dominant cloud platform 
in enterprise retail, finance, and healthcare environments.

Each project follows industry-standard architecture patterns including 
medallion architecture (raw → analytics layers), parameterised ADF pipelines, 
Synapse dedicated SQL pools with HASH and REPLICATE distribution, and 
star schema dimensional modelling.

---

## Projects

### 🛒 CloudBasket — Cloud Retail Analytics Platform
> Azure Data Factory · Azure Blob Storage · Azure Synapse Analytics · Power BI

An end-to-end retail analytics platform ingesting 9 relational CSV files 
from the Olist Brazilian E-Commerce dataset (100K+ orders) through automated 
ADF pipelines into a Synapse star schema, delivered as a 3-page Power BI 
dashboard covering revenue performance, seller analytics, and customer 
review behaviour.

**Key highlights:**
- 9 parameterised Copy Activities in a single ADF pipeline
- Storage Event Trigger for fully automated ingestion
- 118,310 fact rows across 7-table star schema
- HASH distribution on fact table, REPLICATE on dimensions
- $16.64M total revenue analysed across 3 Power BI dashboard pages

---

## Core Azure Services Used

| Service | Purpose |
|---|---|
| Azure Blob Storage (ADLS Gen2) | Raw data lake landing zone |
| Azure Data Factory | ETL pipeline orchestration |
| Azure Synapse Analytics | Dedicated SQL Pool data warehouse |
| Power BI Desktop | Business intelligence dashboard |

---

## How to Use These Projects

Each project folder contains a dedicated README with full reproduction 
steps. Generally:

1. Create an Azure free account at azure.microsoft.com/free ($200 credit)
2. Provision the required Azure services following the project README
3. Import ADF templates from the adf/ folder
4. Run SQL scripts from the synapse/ folder in numbered order
5. Connect Power BI to your Synapse dedicated SQL endpoint

---
