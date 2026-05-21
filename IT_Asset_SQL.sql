-- ============================================================
--  IT ASSET & INVENTORY ANALYTICS — SQL QUERIES
--  Author: Mandhar Eppakayala | Portfolio Project
-- ============================================================


-- ─────────────────────────────────────────────────────────────
-- 1. DATABASE & TABLE SETUP
-- ─────────────────────────────────────────────────────────────

CREATE DATABASE it_asset_analytics;
USE it_asset_analytics;

CREATE TABLE assets (
    asset_id            VARCHAR(20)    PRIMARY KEY,
    asset_type          VARCHAR(50),
    vendor              VARCHAR(50),
    department          VARCHAR(50),
    location            VARCHAR(100),
    purchase_date       DATE,
    purchase_cost       DECIMAL(10,2),
    current_value       DECIMAL(10,2),
    status              VARCHAR(30),
    warranty_expiry     DATE,
    warranty_status     VARCHAR(20),
    age_years           DECIMAL(5,2),
    refresh_needed      VARCHAR(5),
    expected_life_years INT
);


-- ─────────────────────────────────────────────────────────────
-- 2. EXPLORATORY QUERIES
-- ─────────────────────────────────────────────────────────────

-- How many total assets are there?
SELECT COUNT(*) AS total_assets
FROM assets;

-- What asset types exist and how many of each?
SELECT
    asset_type,
    COUNT(*) AS count
FROM assets
GROUP BY asset_type
ORDER BY count DESC;

-- What is the total purchase cost of all assets?
SELECT
    SUM(purchase_cost)  AS total_cost,
    AVG(purchase_cost)  AS avg_cost,
    MIN(purchase_cost)  AS min_cost,
    MAX(purchase_cost)  AS max_cost
FROM assets;


-- ─────────────────────────────────────────────────────────────
-- 3. COST BREAKDOWN BY DEPARTMENT
-- ─────────────────────────────────────────────────────────────

-- Total cost and asset count per department
SELECT
    department,
    COUNT(*)                AS total_assets,
    SUM(purchase_cost)      AS total_cost,
    ROUND(AVG(purchase_cost), 2) AS avg_cost,
    SUM(current_value)      AS current_value
FROM assets
GROUP BY department
ORDER BY total_cost DESC;

-- Which department has the most assets needing refresh?
SELECT
    department,
    COUNT(*) AS refresh_needed_count
FROM assets
WHERE refresh_needed = 'Yes'
GROUP BY department
ORDER BY refresh_needed_count DESC;


-- ─────────────────────────────────────────────────────────────
-- 4. ASSET AGE CALCULATIONS
-- ─────────────────────────────────────────────────────────────

-- Average age of assets by type
SELECT
    asset_type,
    COUNT(*)                    AS total,
    ROUND(AVG(age_years), 2)    AS avg_age_years,
    ROUND(MIN(age_years), 2)    AS youngest,
    ROUND(MAX(age_years), 2)    AS oldest
FROM assets
GROUP BY asset_type
ORDER BY avg_age_years DESC;

-- Assets older than 5 years
SELECT
    asset_id,
    asset_type,
    department,
    purchase_date,
    age_years,
    status
FROM assets
WHERE age_years > 5
ORDER BY age_years DESC;


-- ─────────────────────────────────────────────────────────────
-- 5. REFRESH CYCLE FLAGS
-- ─────────────────────────────────────────────────────────────

-- All assets that need refresh
SELECT
    asset_id,
    asset_type,
    department,
    location,
    purchase_date,
    age_years,
    expected_life_years,
    purchase_cost,
    status
FROM assets
WHERE refresh_needed = 'Yes'
ORDER BY age_years DESC;

-- How many assets need refresh vs don't
SELECT
    refresh_needed,
    COUNT(*)           AS count,
    SUM(purchase_cost) AS total_original_cost
FROM assets
GROUP BY refresh_needed;

-- Refresh needed broken down by department and type
SELECT
    department,
    asset_type,
    COUNT(*) AS needs_refresh
FROM assets
WHERE refresh_needed = 'Yes'
GROUP BY department, asset_type
ORDER BY department, needs_refresh DESC;


-- ─────────────────────────────────────────────────────────────
-- 6. STATUS DISTRIBUTION
-- ─────────────────────────────────────────────────────────────

-- Count of assets by status
SELECT
    status,
    COUNT(*)                AS count,
    SUM(purchase_cost)      AS total_cost,
    ROUND(AVG(age_years),2) AS avg_age
FROM assets
GROUP BY status
ORDER BY count DESC;

-- Active vs inactive breakdown
SELECT
    CASE
        WHEN status = 'Active' THEN 'Active'
        ELSE 'Inactive'
    END AS active_status,
    COUNT(*) AS count,
    SUM(purchase_cost) AS total_cost
FROM assets
GROUP BY active_status;


-- ─────────────────────────────────────────────────────────────
-- 7. WARRANTY ANALYSIS
-- ─────────────────────────────────────────────────────────────

-- How many assets have expired warranties?
SELECT
    warranty_status,
    COUNT(*) AS count,
    SUM(purchase_cost) AS total_cost
FROM assets
GROUP BY warranty_status;

-- Active assets with expired warranties (at-risk assets)
SELECT
    asset_id,
    asset_type,
    department,
    purchase_date,
    warranty_expiry,
    purchase_cost
FROM assets
WHERE status = 'Active'
  AND warranty_status = 'Expired'
ORDER BY purchase_cost DESC;


-- ─────────────────────────────────────────────────────────────
-- 8. VENDOR ANALYSIS
-- ─────────────────────────────────────────────────────────────

-- Total spend by vendor
SELECT
    vendor,
    COUNT(*)           AS total_assets,
    SUM(purchase_cost) AS total_spend,
    ROUND(AVG(purchase_cost),2) AS avg_cost
FROM assets
GROUP BY vendor
ORDER BY total_spend DESC;


-- ─────────────────────────────────────────────────────────────
-- 9. LOCATION ANALYSIS
-- ─────────────────────────────────────────────────────────────

-- Asset count and cost by location
SELECT
    location,
    COUNT(*)           AS total_assets,
    SUM(purchase_cost) AS total_cost,
    ROUND(AVG(age_years),2) AS avg_age
FROM assets
GROUP BY location
ORDER BY total_assets DESC;


-- ─────────────────────────────────────────────────────────────
-- 10. SPECIFIC LOOKUPS
-- ─────────────────────────────────────────────────────────────

-- Show all servers
SELECT *
FROM assets
WHERE asset_type = 'Server'
ORDER BY purchase_cost DESC;

-- Show assets purchased before 2020 that are still active
SELECT
    asset_id,
    asset_type,
    department,
    purchase_date,
    age_years,
    status
FROM assets
WHERE purchase_date < '2020-01-01'
  AND status = 'Active'
ORDER BY purchase_date ASC;

-- Most expensive assets in each department
SELECT
    department,
    asset_id,
    asset_type,
    purchase_cost
FROM assets
WHERE (department, purchase_cost) IN (
    SELECT department, MAX(purchase_cost)
    FROM assets
    GROUP BY department
)
ORDER BY purchase_cost DESC;
