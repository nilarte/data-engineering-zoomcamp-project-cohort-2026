# data-engineering-zoomcamp-project-cohort-2026
## Description
This is my [DataTalksClub DE zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp) project repo. 
Dataset Credit: https://citibikenyc.com/system-data

It uses NYC Citi Bike Trip data from above source and creates an end to data pipeline
High Level Steps:
Kestra Pipeline for processing this dataset and putting it to a datalake in GCS bucket 
Kestra Pipeline for moving the data from the GCS lake to a BigQuery data warehouse 
dbt pipeline to transform the data in the BigQuery data warehouse: prepare it for the dashboard
Build a looker studio dashboard to visualize the data

## Tools used
Cloud: GCP
Workflow orchestration: Kestra + dbt 
Data Warehouse: BigQuery
Batch processing: Kestra

## Prerequisites
GCP account and service account
Docker
dbt cloud account 

## Steps to run this data pipeline
### Local Kestra setup
### Data ingestion via batch mode using Kestra
### Data transformation via dbt cloud
### Dashboards via lookerstudio

