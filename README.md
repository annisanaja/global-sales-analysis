# 🌍 Global Sales Operations: Business Analysis (2010–2017)

An end-to-end data analysis project covering global sales operations across 45 countries and 12 product categories, spanning 8 years of transactional data.

## 📁 Repository Contents

| File | Description |
|------|-------------|
| `Global_Sales_Analysis.sql` | SQL queries for all analytical dimensions |
| `Global_Sales_Dashboard.pbix` | Power BI dashboard with interactive visuals |
| `Business_Report__Global_Sales_Analysis.pdf` | Full written analysis report |

---

## 📊 Project Overview

**Dataset:** 1,330 orders · 45 countries · 12 product categories · 2010–2017

**Tools used:** SQL Server · Power BI

This project analyzes a global B2B sales dataset to surface actionable insights across five dimensions: product performance, geographic reach, sales channel behavior, lead time efficiency, and temporal trends.

---

## 🔍 Key Analyses

### 1. Product Category Performance (ABC Analysis)
- Revenue share and profit margin by category
- Pareto/ABC classification across revenue, profit, and volume dimensions
- Identifies cross-metric mismatches (e.g. high-volume, low-profit categories)

### 2. Geographic Analysis
- Order and revenue distribution by region, sub-region, and country
- Top markets ranked by revenue share, units sold, and profit margin
- Coverage breakdown: Europe (~94%) vs. Western Asia (~6%)

### 3. Sales Channel Analysis
- Online vs. Offline comparison across order volume, revenue, average order size, product mix, geographic reach, and profit margin
- SKU diversity and geographic reach per channel

### 4. Lead Time Analysis
- Scatter analysis of order-to-shipment intervals vs. profitability
- R² < 0.05: lead time is not a meaningful profit predictor (except for perishables)

### 5. Sales Trends & Temporal Patterns
- Year-over-year growth phases: early growth (2010–2012) → peak (2013–2014) → plateau (2015–2016) → re-acceleration (2017)
- Seasonal buying cycles (Q1 and Q3 peaks)
- Day-of-week sales dynamics

---

## 💡 Key Findings

- **Clothes** has the highest profit margin (67%) in the portfolio but contributes only ~4% of revenue, a significant underexploited opportunity
- **Cosmetics and Office Supplies** are the anchor categories, driving the majority of profit
- **Fruits and Beverages** are volume traps: high transaction count, near-zero margin
- **Cereal** is a C-tier performer across all ABC dimensions, a candidate for strategic review
- **Snacks** is A by profit but B by revenue, signaling a pricing opportunity
- **6.2% of records** (82 orders) carry an UNKNOWN country code, a data governance gap excluded from geographic analyses

---

## 📌 Business Recommendations
**Quick Wins (0–3 months)**
- Price up Clothes: 67% margin suggests the market can absorb a 10–15% price increase without volume loss, highest-leverage action available
- Fix the data gap: recover 82 UNKNOWN country records via Order IDs and enforce a mandatory country field at order entry to prevent recurrence
- Audit Fruits & Beverages: if fully-loaded costs (logistics, handling, credit terms) make these net-negative per order, introduce minimum order sizes or a category surcharge

**Medium-Term (3–12 months)**
- Price up Snacks & Vegetables: both are A-tier by profit but underperform on revenue, indicating a pricing opportunity
- Invest in the Online channel: broader geographic reach, higher-margin category support, and wider SKU spread make it the stronger growth driver
- Build a seasonal promo calendar: Q1 and Q3 buying cycles are identifiable; proactive bundled offers for Group A categories during those windows can lift revenue

**Long-Term**
- Grow Clothes and Snacks: solid margins with room to scale without major cost structure changes; reduces concentration risk from over-reliance on Cosmetics and Office Supplies
- Expand into Western Asia: Armenia, Georgia, and Cyprus show consistent purchasing behavior; a regional sales resource or local distributor could multiply order frequency
- Establish a data quality KPI dashboard: track completeness metrics (country, product ID, channel) monthly with a named owner accountable for resolution

---

## 🗂️ SQL Query Reference

The `Global_Sales_Analysis.sql` file includes:

```
- Total revenue aggregation
- Revenue share + profit margin by category (CTE-based)
- ABC classification with rolling window functions
- Geographic order distribution by region
- Top markets by country (revenue, units sold, profit)
- Sales channel comparison metrics
- Geographic reach by channel and category
```

---

## 📈 Dashboard (Power BI)

<img width="1280" height="720" alt="image" src="https://github.com/user-attachments/assets/d59399aa-e008-4d81-84b1-6a0e82f5767a" />

The `.pbix` file contains interactive visuals for:
- Revenue and profit KPIs
- Category breakdown with ABC segmentation
- Country-level map visualization
- Channel comparison charts
- Time-series trend analysis

> Requires Power BI Desktop to open.

---

## 📄 Report

The PDF report (`Business_Report__Global_Sales_Analysis.pdf`) provides the full written analysis including strategic recommendations across immediate (0–3 months), medium-term (3–12 months), and long-term horizons.

---

## 🔗 Data Source

Raw dataset: [Google Sheets](https://docs.google.com/spreadsheets/d/1QbGIVIBYZvkdNR-KA-2wmHI3VaETtTcJy-oVawLbW8c/edit?gid=318554411#gid=318554411)

---

*Prepared by: Naja Annisa Arifin*
