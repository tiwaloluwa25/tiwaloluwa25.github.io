
--Overall churn rate

SELECT 
	COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
		SUM(CASE WHEN Churn ='Yes' THEN 1 ELSE 0 END) * 100.0/COUNT(*),
        2
	) AS churn_rate_percentage
        FROM churn_data;
        
        ---Churn analysis by contract type
        
SELECT
	COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE  0 END) AS churned_customers,
    ROUND(
		SUM(CASE WHEN Churn ='Yes' THEN 1 ELSE 0 END) * 100.0/COUNT(*),
        2
	) AS churn_rate_percentage
FROM churn_data
GROUP BY Contract
ORDER BY churn_rate_percentage;

---Churn rate by tenure group

SELECT 
	CASE
		WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49+ Months'
	END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
		SUM(CASE WHEN Churn ='Yes' THEN 1 ELSE 0 END) * 100.0/COUNT(*),
        2
	) AS churn_rate_percentage
FROM churn_data
GROUP BY tenure_group
ORDER BY churn_rate_percentage DESC;

---Churn rate by payment method

SELECT
	payment_method,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
		SUM(CASE WHEN Churn ='Yes' THEN 1 ELSE 0 END) * 100.0/COUNT(*),
        2
	) AS churn_rate_percentage
FROM churn_data
GROUP BY payment_method
ORDER BY churn_rate_percentage DESC;


---Identify high-risk customers

SELECT 
	Contract,
    Payment_Method,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
		SUM(CASE WHEN Churn ='Yes' THEN 1 ELSE 0 END) * 100.0/COUNT(*),
        2
	) AS churn_rate_percentage
FROM churn_data
GROUP BY contract, Payment_Method
ORDER BY churn_rate_percentage DESC;


---Revenue at risk from churned customers

SELECT
	ROUND(SUM(monthly_charges), 2) AS revenue_at_risk
FROM churn_data
WHERE churn = 'Yes';

        