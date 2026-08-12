# Logistics Optimization Project

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Business Objective](#2-business-objective)
3. [Data](#3-data)
4. [Methodology](#4-methodology)
5. [Key Results](#5-key-results)
6. [Business Interpretation](#6-business-interpretation)
7. [Power BI Dashboard](#7-power-bi-dashboard)
8. [Project Structure](#8-project-structure)
9. [Technologies](#9-technologies)
10. [Reproducibility](#10-reproducibility)
11. [Project Status](#11-project-status)
12. [Data Disclaimer](#12-data-disclaimer)

---

## 1. Project Overview

This project analyzes a simulated logistics network in order to identify operational inefficiencies, prioritize customers, and evaluate potential optimization opportunities.

The analysis combines PostgreSQL, Python, Jupyter Notebook, network analysis, customer segmentation, PCA, and Power BI.

The project follows an end-to-end analytical workflow, from data extraction and validation to customer prioritization and logistics optimization scenarios.

---

## 2. Business Objective

The main objectives are to:

- validate the quality and consistency of logistics data;
- analyze transport costs, distances, CO₂ emissions, and shipment volumes;
- identify key cities and hubs in the logistics network;
- segment customers according to their logistics profiles;
- identify high-priority customers;
- provide operational recommendations;
- estimate the potential impact of selected optimization actions;
- communicate the results through an interactive Power BI dashboard.

---

## 3. Data

The project uses simulated logistics data covering:

- customers;
- shipments;
- products;
- warehouses;
- cities;
- transport modes.

The original data files are stored locally in:

`data/raw/`

Processed datasets generated during the analysis are stored locally in:

`data/processed/`

These datasets are intentionally excluded from the GitHub repository through `.gitignore`.

The dataset contains:

- **100 customers**
- **1,000 shipments**
- **12 cities**
- **72 logistics network connections**

The data are simulated for analytical and portfolio purposes. They should not be interpreted as actual operational data from a real company.

---

# 4. Methodology

## 4.1 PostgreSQL Data Extraction

The logistics data are stored and queried in PostgreSQL.

SQL scripts are organized by analytical purpose:

- database schema and constraints;
- data validation;
- KPI calculations;
- logistics network analysis;
- customer clustering preparation.

---

## 4.2 Data Validation

The data validation stage checks the consistency and quality of the logistics data before performing the analytical stages.

The validation includes checks on:

- missing values;
- duplicates;
- relationships between tables;
- shipment and customer consistency;
- key numerical variables.

The final analytical dataset contains 100 customers and no missing values in the main logistics variables used for prioritization:

- annual demand;
- shipment count;
- shipped weight;
- transport cost;
- average distance;
- average transit time;
- CO₂ emissions.

---

## 4.3 Logistics KPI Analysis

Key logistics performance indicators are calculated to provide an overview of the network.

The analysis includes:

- total number of clients;
- total transport cost;
- average distance;
- total CO₂ emissions;
- total shipments;
- transport cost by transport mode;
- CO₂ emissions by transport mode;
- shipment volume by segment.

The global simulated logistics KPIs are:

| KPI                      | Result          |
| ------------------------ | --------------: |
| Total shipments          | 1,000           |
| Total clients            | 100             |
| Total transported weight | 3,799,966 kg    |
| Total transport cost     | €4,094,442.94   |
| Average distance         | 6,281.43 km     |
| Average transit time     | 108.13 hours    |
| Total CO₂ emissions      | 3,135,454.31 kg |

---

## 4.4 Logistics Networks Analysis

The logistics network is analyzed using network centrality measures.

The analysis identifies strategic cities and important network hubs using measures such as:

- PageRank;
- degree centrality;
- betweenness centrality.

Transport flows between cities are also analyzed to identify the main logistics routes.

The simulated network contains:

- **12 cities**
- **72 connections**

The network analysis identifies several highly connected cities, including Lyon, Paris, Hamburg, Barcelona, Shanghai and Dubai.

Hamburg presents the highest betweenness centrality among the analyzed cities, suggesting an important intermediary position in the simulated network.

A shortest-path analysis is also performed to identify potentially efficient routes between cities.

---

## 4.5 Customer Clustering

Customers are segmented using clustering techniques based on their logistics characteristics.

Three customer clusters are used to identify different operational profiles.

The clusters are interpreted according to variables such as:

- transport activity;
- logistics costs;
- shipment characteristics;
- distance-related indicators;
- transit time;
- CO₂ emissions.

The resulting customer segmentation is:

| Cluster   | Number of customers | Profile                                   |
| --------- | ------------------: | ------------------------------------      |
| Cluster 0 | 36                  | Distant Customers / Long-Distance Flows   |
| Cluster 1 | 57                  | Standard Customers / Efficient Flows      |
| Cluster 2 | 7                   | High-Activity Customers / High-Cost Flows |

---

## 4.6 Principal Component Analysis

Principal Component Analysis (PCA) is used to reduce the dimensionality of the customer dataset and visualize the main patterns in the customer profiles.

The PCA helps identify the main dimensions explaining differences between customers.

The first two principal components explain:

- **PCA1: 38.10%**
- **PCA2: 27.55%**
- **Total: 65.66%**

The PCA visualization provides an additional perspective on the customer segmentation and shows how the different customer profiles are distributed in a reduced-dimensional space.

---

## 4.7 Customer Prioritization

A priority score is calculated to identify customers that represent the greatest potential for logistics optimization.

Customers are classified into priority levels:

- Very High;
- High;
- Medium;
- Low.

The prioritization combines several logistics indicators, including customer activity, transport costs, distances, transit times and CO₂ emissions.

The analysis focuses particularly on the highest-priority customers.

---

## 4.8 Recommendations

Operational recommendations are assigned according to customer profiles and clusters.

The recommendations focus on actions such as:

- optimizing warehouse allocation;
- reducing unnecessary transport distances;
- consolidating shipments;
- improving route planning;
- maintaining the current organization when no major optimization opportunity is identified.

The recommendations are therefore linked to the characteristics of each customer cluster rather than being identical for all customers.

---

## 4.9 Optimization Scenario

A scenario-based optimization analysis is performed on the Top 10 priority customers.

The scenario estimates potential reductions in:

- transport costs;
- transport distances;
- CO₂ emissions.

These values are **scenario estimates**, not measured historical improvements.

The optimization scenario is based on the assumptions implemented in the analytical model and should therefore be interpreted as an illustrative decision-support exercise.

---

# 5. Key Results

## 5.1 Global Logistics Performance

The simulated logistics network contains 1,000 shipments serving 100 customers.

The total transported weight is approximately **3.8 million kg**, with total transport costs of approximately **€4.09 million**.

The average shipment distance is approximately **6,281 km**, while the average transit time is approximately **108 hours**.

Total simulated CO₂ emissions reach approximately **3.14 million kg**.

These indicators provide a baseline for identifying areas where logistics performance could potentially be improved.

---

## 5.2 Logistics Transportation Network

The logistics transportation network highlights the main connections between cities and helps identify strategic locations within the simulated network.

![Logistics Transportation Network](exports/charts/01_logistics_transportation_network.png)

The network analysis identifies cities that play different strategic roles.

Lyon, Paris, Hamburg, Barcelona, Shanghai and Dubai show relatively high connectivity in the simulated network.

Hamburg presents the highest betweenness centrality, suggesting that it occupies an important intermediary position between other cities.

This makes Hamburg a potential candidate for further investigation as a consolidation or transit point within the simulated network.

The shortest-path analysis also identifies an example route:

**City 2 → City 5 → City 9**

with a total distance of approximately **10,979 km**.

This demonstrates how network analysis can be used to identify potentially efficient routes and support logistics routing decisions.

---

## 5.3 Transport Mode Analysis

The transport-mode analysis shows significant differences between modes.

Road transport represents the largest shipment volume, with **473 shipments**, followed by:

- Rail: 208 shipments;
- Sea: 203 shipments;
- Air: 116 shipments.

Road transport also represents a major contributor to total transport cost because of its high shipment volume.

Air transport generates the highest total transport cost among the individual modes and also produces the highest total CO₂ emissions.

The results suggest that transport-mode selection can be an important optimization lever, particularly for long-distance flows.

However, these results are based on simulated data and do not include real-world constraints such as contractual requirements, capacity limitations, service-level agreements or actual transport availability.

---

## 5.4 Customer Segmentation — PCA Visualization

The clustering analysis identifies three customer profiles among the 100 simulated customers.

The PCA visualization provides a two-dimensional representation of the customer segments and illustrates the main differences between customer profiles.

![Customer Segmentation — PCA Visualization](exports/charts/02_customer_segmentation_pca.png)

### Cluster 0 — Distant Customers / Long-Distance Flows

- **36 customers**
- higher average distances;
- longer transit times;
- logistics flows requiring particular attention.

Recommended actions include reviewing warehouse allocation and investigating alternative routes to reduce distance, transit time and CO₂ emissions.

### Cluster 1 — Standard Customers / Efficient Flows

- **57 customers**
- relatively efficient logistics flows;
- moderate transport costs;
- represents the largest customer group.

For these customers, the recommendation is mainly to maintain the current organization and consider shipment consolidation where appropriate.

### Cluster 2 — High-Activity Customers / High-Cost Flows

- **7 customers**
- high activity levels;
- high transport costs;
- significant logistics impact.

This smaller cluster represents a particularly important optimization target.

Recommended actions include optimizing warehouse allocation, consolidating shipments and investigating lower-cost routing alternatives.

---

## 5.5 PCA Analysis

The PCA analysis provides a visual representation of the customer profiles.

The first two components explain **65.66% of the total variance**:

- PCA1: 38.10%;
- PCA2: 27.55%.

The PCA visualization shows a visible differentiation between the customer groups identified through clustering.

This provides an additional exploratory perspective on the segmentation by showing how customers with similar logistics characteristics tend to be positioned closer together in the reduced-dimensional space.

PCA is used here as a complementary analytical tool rather than as a replacement for the clustering model.

---

## 5.6 Customer Prioritization

The priority analysis identifies the customers with the greatest potential logistics impact.

The Top 10 priority customers include:

| Rank | Customer  | Segment    | Cluster | Priority Score |
| ---: | --------- | ---------- | ------: | -------------: |
| 1    | CLIENT039 | Standard   | 2       | 80.23          |
| 2    | CLIENT023 | Industrial | 2       | 79.11          |
| 3    | CLIENT033 | Industrial | 2       | 72.72          |
| 4    | CLIENT080 | Standard   | 2       | 72.00          |
| 5    | CLIENT062 | Standard   | 2       | 66.10          |
| 6    | CLIENT010 | Standard   | 2       | 63.02          |
| 7    | CLIENT005 | Standard   | 2       | 56.95          |
| 8    | CLIENT035 | Standard   | 0       | 56.89          |
| 9    | CLIENT022 | Standard   | 0       | 56.26          |
| 10   | CLIENT089 | Standard   | 0       | 49.83          |


CLIENT039 has the highest priority score at **80.23**.

The highest-priority customers are mainly associated with either:

- high activity and high logistics costs; or
- long-distance logistics flows.

This prioritization provides a practical way of focusing optimization resources on customers where the potential impact is greatest.

---

## 5.7 Top 10 Priority Customers for Logistics Optimization

The following visualization highlights the Top 10 customers identified by the priority scoring model.

![Top 10 Priority Customers](exports/charts/03_top10_priority_customers.png)

The results show that the highest-ranked customers are predominantly associated with the **High-Activity / High-Cost** cluster, while some priority customers belong to the **Distant / Long-Distance Flows** cluster.

This demonstrates how the prioritization model can be used to identify customers that deserve targeted operational attention.

---

## 5.8 Optimization Scenario Results

The optimization scenario focuses on the Top 10 priority customers.

The simulated scenario produces the following results:

| KPI            | Current         | Optimized       | Estimated Improvement |
| -------------- | --------------: | --------------: | --------------------: |
| Transport cost | €1,756,188.56   | €1,593,925.71   | €162,262.85           |
| CO₂ emissions  | 1,342,454.08 kg | 1,230,808.27 kg | 111,645.81 kg         |

This corresponds to an estimated reduction of approximately:

- **9.2% in transport costs**
- **8.3% in CO₂ emissions**

The scenario illustrates how customer prioritization can be combined with logistics optimization assumptions to estimate potential business impact.

The largest opportunities are concentrated among the highest-priority customers, particularly those belonging to the **High-Activity / High-Cost** cluster.

> These savings are simulated estimates generated by the analytical model. They are not guaranteed real-world savings and should not be interpreted as historical performance improvements.

---

# 6. Business Interpretation

Overall, the analysis demonstrates how several analytical techniques can be combined to move from descriptive reporting toward data-driven logistics decision support.

The analytical workflow can be summarized as:

**Raw Data → SQL Analysis → Data Validation → KPI Analysis → Logistics Networks Analysis → Customer Segmentation → PCA → Customer Prioritization → Recommendations → Optimization Scenario**

The main business opportunities identified in the simulated dataset are:

1. identifying high-cost and high-impact customers;
2. optimizing warehouse/customer allocation;
3. investigating long-distance logistics flows;
4. improving route selection;
5. evaluating transport-mode choices;
6. consolidating shipments where appropriate;
7. reducing transport costs;
8. reducing CO₂ emissions.

The analysis demonstrates that optimization should not necessarily be applied uniformly across the entire customer base.

Instead, different customer profiles require different actions:

- **Distant customers** require attention to warehouse allocation and route efficiency;
- **Standard customers** can generally be managed through operational efficiency and shipment consolidation;
- **High-Activity / High-Cost customers** should receive priority for targeted optimization initiatives.

The combination of clustering, network analysis and customer prioritization provides a structured framework for identifying where logistics optimization efforts could have the greatest impact.

Because the dataset is simulated, these conclusions demonstrate the analytical approach rather than describing the performance of a real logistics operation.

---

# 7. Power BI Dashboard

The results are presented through a Power BI dashboard containing three main views.

## 7.1 Overview

The Overview presents the main logistics KPIs and a high-level view of:

- transport costs;
- CO₂ emissions;
- shipment volumes;
- customer activity;
- transport modes.

The corresponding dashboard export is available in:

`exports/powerbi/01_overview.PNG`

---

## 7.2 Clients & Recommendations

This view focuses on:

- Top priority customers;
- customer clusters;
- customer profiles;
- priority levels;
- customer recommendations.

The corresponding dashboard export is available in:

`exports/powerbi/02_clients_recommendations.PNG`

---

## 7.3 Logistics Networks

This view presents:

- strategic cities;
- network centrality;
- major transport flows;
- logistics network structure;
- estimated optimization impact.

The corresponding dashboard export is available in:

`exports/powerbi/03_logistic_networks.PNG`

The Power BI page is intentionally named **Logistics Networks** to remain consistent with the dashboard.

---

# 8. Project Structure

```text
logistic_project/
│
├── data/
│   ├── raw/                  # Local source data
│   └── processed/            # Generated datasets
│
├── exports/
│   ├── charts/
│   │   ├── 01_logistics_transportation_network.png
│   │   ├── 02_customer_segmentation_pca.png
│   │   └── 03_top10_priority_customers.png
│   │
│   └── powerbi/
│       ├── 01_overview.PNG
│       ├── 02_clients_recommendations.PNG
│       └── 03_logistic_networks.PNG
│
├── notebooks/
│   └── logistic_analysis.ipynb
│
├── sql/
│   ├── 01_schema.sql
│   ├── 02_validation.sql
│   ├── 03_kpi.sql
│   ├── 04_network.sql
│   └── 05_client_clustering.sql
│
├── .gitignore
└── README.md
```

---

# 9. Technologies

The project uses:

- **PostgreSQL** — database management and SQL analysis
- **Python** — data analysis and modeling
- **Jupyter Notebook** — analytical workflow
- **Pandas** — data manipulation
- **Scikit-learn** — clustering and PCA
- **NetworkX** — logistics network analysis
- **Matplotlib** — data visualization
- **Power BI** — dashboard and business intelligence

---

# 10. Reproducibility

The main analytical workflow is contained in:

`notebooks/logistic_analysis.ipynb`

The notebook includes the complete analysis pipeline:

1. PostgreSQL connection and SQL extraction;
2. data validation;
3. logistics KPI analysis;
4. network and centrality analysis;
5. customer clustering;
6. PCA;
7. customer prioritization;
8. customer recommendations;
9. optimization scenario;
10. saving of generated results.

The SQL scripts used in PostgreSQL are available in the `sql/` directory.

Generated datasets and original source data are excluded from version control.

The complete analytical workflow can be reproduced by executing the notebook sequentially after configuring the PostgreSQL connection and required Python environment.

---

# 11. Project Status

The analytical workflow has been completed and successfully executed in Jupyter Notebook.

The following components have been completed:

- PostgreSQL database and SQL analysis;
- data validation;
- logistics KPI analysis;
- Logistics Networks analysis;
- customer clustering;
- PCA;
- customer prioritization;
- customer recommendations;
- optimization scenario;
- Power BI dashboard.

The Power BI dashboard has been created and exported as screenshots for documentation purposes.

The project is therefore presented as a completed end-to-end logistics analytics portfolio project.

---


# 12. Data Disclaimer

> **Data Disclaimer:** **All customer, shipment, logistics, cost and environmental figures used in this project are simulated. They are intended to demonstrate analytical methods, technical skills and business reasoning and do not represent real company performance.**

**The optimization results are also simulated estimates generated from the assumptions implemented in the analytical model. They should not be interpreted as guaranteed savings or as measured improvements from a real logistics operation.**

**The project is designed as a portfolio demonstration of an end-to-end data analytics workflow, including SQL analysis, data validation, KPI analysis, logistics network analysis, customer segmentation, PCA, customer prioritization, recommendations, scenario-based optimization and Power BI reporting.**
