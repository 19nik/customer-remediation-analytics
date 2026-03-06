--1. Identify impacted customers
SELECT customer_id,atm_fee_charged, correct_fee
FROM customers
WHERE atm_fee_charged > correct_fee;

--2. Calculate refund amount
SELECT customer_id, (atm_fee_charged - correct_fee) * transactions AS refund_amount
FROM customers
WHERE atm_fee_charged > correct_fee;

--3. High risk customers
SELECT customer_id, complaints, last_transaction_days, account_balance
FROM customers
WHERE complaints >= 3
OR last_transaction_days > 30
OR account_balance < 3000;

--4. Total remediation liability
SELECT SUM((atm_fee_charged - correct_fee) * transactions) AS total_refund
FROM customers
WHERE atm_fee_charged > correct_fee;

--5. Root Cause Analysis
SELECT complaints, COUNT(customer_id) AS impacted_customers, round(AVG((atm_fee_charged - correct_fee) * transactions),0) AS avg_refund_amount
FROM customers
WHERE atm_fee_charged > correct_fee
GROUP BY complaints
ORDER BY complaints;


