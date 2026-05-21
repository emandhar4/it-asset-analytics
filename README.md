# 🖥️ IT Asset & Inventory Analytics

> End-to-end IT asset lifecycle analytics project modeling 527 enterprise assets across 10 departments — structured in Excel, queried in SQL, and visualized in Power BI.

---

## 📌 Project Overview

This project analyzes enterprise IT asset data to track procurement costs, monitor asset lifecycle status, flag aging hardware for refresh, and support data-driven infrastructure decisions. The analysis covers asset types ranging from laptops and servers to network switches and UPS batteries across 6 office locations.

**Dataset:** Synthetic enterprise IT asset inventory — 527 assets  
**Fields:** Asset ID, Type, Vendor, Department, Location, Purchase Date, Cost, Current Value, Status, Warranty, Age, Refresh Flag

---

## 🛠️ Tools Used

| Layer | Tool | Purpose |
|-------|------|---------|
| Data generation | Python (pandas) | Realistic synthetic asset data |
| Data cleaning | Excel (Power Query) | Standardization, age calculations, cost summaries |
| Analysis | SQL (MySQL) | Asset queries, cost breakdowns, refresh flags |
| Visualization | Power BI | Interactive lifecycle dashboard |

---

## 📁 Repository Structure

```
it-asset-analytics/
├── data/
│   └── it_assets_raw.csv
├── excel/
│   └── IT_Asset_Dashboard.xlsx
├── sql/
│   └── IT_Asset_SQL.sql
└── README.md
```

---

## 🔍 Key Findings

- **168 assets (32%) require refresh** — past their expected useful life, flagged for replacement
- **IT and Engineering** carry the highest total asset costs due to servers and high-spec workstations
- **Servers average $7,200** per unit — the highest cost asset type in the portfolio
- **63% of assets have expired warranties** — creating significant support risk for active hardware
- **Sales and Executive departments** have the youngest average asset age due to frequent laptop and phone refreshes

---

## 🗄️ SQL Highlights

The `/sql` folder contains 10 queries including:

- Cost breakdown by department and asset type
- Asset age calculations with oldest and youngest per type
- Refresh cycle flags for assets past expected useful life
- Status distribution across Active, Retired, In Repair, and Pending Disposal
- Warranty expiration analysis for at-risk active assets
- Vendor spend summary
- Location-based asset distribution
- Most expensive asset per department using subqueries

---

## 📊 Excel Workbook Structure

| Sheet | Contents |
|-------|---------|
| `KPI_Summary` | 6 KPI cards + department cost and refresh summary |
| `Raw_Data_Cleaned` | Color-coded status and refresh flag columns |
| `Department_Analysis` | Cost breakdown with dynamic totals |
| `Asset_Type_Analysis` | Per-type cost, count, and refresh counts |
| `Refresh_Priority` | Heat-mapped priority list sorted by asset age |
| `Status_Distribution` | Active / Retired / In Repair / Pending breakdown |

---

## 💡 Skills Demonstrated

- Synthetic data modeling for enterprise IT scenarios
- Data cleaning and categorization in Excel
- Age and depreciation calculations using purchase date logic
- SQL queries using GROUP BY, CASE WHEN, WHERE filters, and subqueries
- Conditional formatting for priority and risk visualization
- Business storytelling — translating asset data into refresh and budget recommendations

---

## 👤 Author

**Mandhar Eppakayala**  
BBA in Management Information Systems — University of Georgia  
[LinkedIn](https://www.linkedin.com/in/mandhar-eppakayala) · [GitHub](https://github.com/emandhar4)
