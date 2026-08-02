-- =====================================================
-- Customer Orders Sample Dataset
-- 100 orders across 32 customers (1-5 orders each)
-- =====================================================

DROP TABLE IF EXISTS Customer_Orders;

CREATE TABLE Customer_Orders (
    CustomerID     VARCHAR(10)     NOT NULL,
    CustomerName   VARCHAR(100)    NOT NULL,
    Order_ID       VARCHAR(10)     PRIMARY KEY,
    Order_Date     DATE            NOT NULL,
    Amount         DECIMAL(10,2)   NOT NULL,
    Status         VARCHAR(20)     NOT NULL,
    ModeofPayment  VARCHAR(20)     NOT NULL
);

-- =====================================================
-- Insert sample data (100 rows)
-- =====================================================

INSERT INTO Customer_Orders (CustomerID, CustomerName, Order_ID, Order_Date, Amount, Status, ModeofPayment) VALUES
    ('CUST1000', 'Linda Smith', 'ORD5000', '2024-10-01', 74.5, 'Returned', 'UPI'),
    ('CUST1000', 'Linda Smith', 'ORD5001', '2025-02-14', 790.7, 'Delivered', 'Cash on Delivery'),
    ('CUST1001', 'Sarah Davis', 'ORD5002', '2025-02-09', 798.05, 'Processing', 'Debit Card'),
    ('CUST1001', 'Sarah Davis', 'ORD5003', '2025-05-26', 250.14, 'Delivered', 'UPI'),
    ('CUST1002', 'Joseph Jones', 'ORD5004', '2024-09-26', 394.73, 'Shipped', 'PayPal'),
    ('CUST1002', 'Joseph Jones', 'ORD5005', '2025-07-05', 209.87, 'Pending', 'UPI'),
    ('CUST1002', 'Joseph Jones', 'ORD5006', '2025-08-21', 452.26, 'Cancelled', 'Wallet'),
    ('CUST1003', 'Michael Perez', 'ORD5007', '2024-04-22', 716.19, 'Shipped', 'Credit Card'),
    ('CUST1003', 'Michael Perez', 'ORD5008', '2024-06-05', 356.12, 'Shipped', 'Net Banking'),
    ('CUST1003', 'Michael Perez', 'ORD5009', '2024-06-12', 483.73, 'Pending', 'Wallet'),
    ('CUST1003', 'Michael Perez', 'ORD5010', '2025-10-04', 849.1, 'Processing', 'Credit Card'),
    ('CUST1004', 'Paul Williams', 'ORD5011', '2025-07-03', 679.77, 'Cancelled', 'PayPal'),
    ('CUST1004', 'Paul Williams', 'ORD5012', '2025-11-29', 114.6, 'Shipped', 'Net Banking'),
    ('CUST1005', 'Donna Wilson', 'ORD5013', '2024-01-04', 689.56, 'Shipped', 'Credit Card'),
    ('CUST1005', 'Donna Wilson', 'ORD5014', '2024-09-26', 785.53, 'Delivered', 'Cash on Delivery'),
    ('CUST1005', 'Donna Wilson', 'ORD5015', '2025-05-27', 464.76, 'Delivered', 'PayPal'),
    ('CUST1006', 'John Smith', 'ORD5016', '2024-06-14', 858.88, 'Returned', 'Credit Card'),
    ('CUST1006', 'John Smith', 'ORD5017', '2025-07-06', 545.46, 'Shipped', 'Credit Card'),
    ('CUST1007', 'Jennifer Miller', 'ORD5018', '2024-02-29', 792.15, 'Returned', 'Credit Card'),
    ('CUST1007', 'Jennifer Miller', 'ORD5019', '2024-09-02', 663.0, 'Cancelled', 'Wallet'),
    ('CUST1007', 'Jennifer Miller', 'ORD5020', '2024-09-03', 486.9, 'Delivered', 'Cash on Delivery'),
    ('CUST1007', 'Jennifer Miller', 'ORD5021', '2024-11-10', 436.14, 'Shipped', 'PayPal'),
    ('CUST1007', 'Jennifer Miller', 'ORD5022', '2025-01-06', 482.45, 'Processing', 'Debit Card'),
    ('CUST1008', 'Joseph Taylor', 'ORD5023', '2024-07-24', 368.7, 'Processing', 'PayPal'),
    ('CUST1008', 'Joseph Taylor', 'ORD5024', '2024-11-15', 403.27, 'Shipped', 'Credit Card');

INSERT INTO Customer_Orders (CustomerID, CustomerName, Order_ID, Order_Date, Amount, Status, ModeofPayment) VALUES
    ('CUST1008', 'Joseph Taylor', 'ORD5025', '2025-07-06', 235.14, 'Delivered', 'Credit Card'),
    ('CUST1008', 'Joseph Taylor', 'ORD5026', '2025-12-07', 536.05, 'Delivered', 'Debit Card'),
    ('CUST1009', 'Joshua Smith', 'ORD5027', '2024-01-08', 218.37, 'Returned', 'Wallet'),
    ('CUST1009', 'Joshua Smith', 'ORD5028', '2024-03-01', 308.09, 'Shipped', 'PayPal'),
    ('CUST1009', 'Joshua Smith', 'ORD5029', '2024-03-13', 607.37, 'Delivered', 'Debit Card'),
    ('CUST1009', 'Joshua Smith', 'ORD5030', '2025-10-08', 655.43, 'Returned', 'UPI'),
    ('CUST1009', 'Joshua Smith', 'ORD5031', '2025-12-25', 433.83, 'Cancelled', 'Wallet'),
    ('CUST1010', 'Emily Miller', 'ORD5032', '2024-04-06', 598.53, 'Delivered', 'Net Banking'),
    ('CUST1010', 'Emily Miller', 'ORD5033', '2024-04-09', 428.84, 'Processing', 'Cash on Delivery'),
    ('CUST1010', 'Emily Miller', 'ORD5034', '2024-07-13', 593.64, 'Processing', 'Credit Card'),
    ('CUST1010', 'Emily Miller', 'ORD5035', '2025-02-20', 371.91, 'Delivered', 'Wallet'),
    ('CUST1011', 'Paul Wilson', 'ORD5036', '2024-04-21', 184.13, 'Shipped', 'Net Banking'),
    ('CUST1011', 'Paul Wilson', 'ORD5037', '2024-07-15', 178.19, 'Shipped', 'Wallet'),
    ('CUST1011', 'Paul Wilson', 'ORD5038', '2024-09-11', 832.16, 'Shipped', 'Wallet'),
    ('CUST1012', 'Joseph Anderson', 'ORD5039', '2024-02-21', 899.36, 'Cancelled', 'Credit Card'),
    ('CUST1012', 'Joseph Anderson', 'ORD5040', '2024-04-10', 834.9, 'Cancelled', 'Debit Card'),
    ('CUST1012', 'Joseph Anderson', 'ORD5041', '2025-07-17', 375.26, 'Shipped', 'Wallet'),
    ('CUST1012', 'Joseph Anderson', 'ORD5042', '2025-10-29', 370.51, 'Delivered', 'Net Banking'),
    ('CUST1013', 'Donna Rodriguez', 'ORD5043', '2024-01-03', 268.15, 'Processing', 'Cash on Delivery'),
    ('CUST1013', 'Donna Rodriguez', 'ORD5044', '2024-09-28', 895.94, 'Shipped', 'Cash on Delivery'),
    ('CUST1013', 'Donna Rodriguez', 'ORD5045', '2025-02-03', 446.21, 'Delivered', 'Debit Card'),
    ('CUST1013', 'Donna Rodriguez', 'ORD5046', '2025-04-10', 872.33, 'Shipped', 'UPI'),
    ('CUST1014', 'James Harris', 'ORD5047', '2024-02-28', 60.32, 'Shipped', 'Wallet'),
    ('CUST1014', 'James Harris', 'ORD5048', '2024-03-03', 485.51, 'Delivered', 'UPI'),
    ('CUST1014', 'James Harris', 'ORD5049', '2024-11-17', 86.81, 'Delivered', 'UPI');

INSERT INTO Customer_Orders (CustomerID, CustomerName, Order_ID, Order_Date, Amount, Status, ModeofPayment) VALUES
    ('CUST1015', 'David Thompson', 'ORD5050', '2024-03-10', 121.97, 'Returned', 'Debit Card'),
    ('CUST1015', 'David Thompson', 'ORD5051', '2024-08-28', 527.75, 'Delivered', 'Credit Card'),
    ('CUST1015', 'David Thompson', 'ORD5052', '2025-02-17', 386.58, 'Shipped', 'UPI'),
    ('CUST1015', 'David Thompson', 'ORD5053', '2025-11-22', 295.66, 'Delivered', 'Cash on Delivery'),
    ('CUST1016', 'Margaret Hernandez', 'ORD5054', '2024-09-01', 250.79, 'Delivered', 'Cash on Delivery'),
    ('CUST1016', 'Margaret Hernandez', 'ORD5055', '2024-11-17', 281.19, 'Delivered', 'Wallet'),
    ('CUST1017', 'Sarah Jones', 'ORD5056', '2024-01-10', 896.54, 'Delivered', 'Debit Card'),
    ('CUST1017', 'Sarah Jones', 'ORD5057', '2024-03-15', 463.19, 'Delivered', 'PayPal'),
    ('CUST1017', 'Sarah Jones', 'ORD5058', '2025-04-14', 794.67, 'Returned', 'PayPal'),
    ('CUST1017', 'Sarah Jones', 'ORD5059', '2025-07-30', 267.92, 'Shipped', 'UPI'),
    ('CUST1017', 'Sarah Jones', 'ORD5060', '2025-09-28', 637.92, 'Processing', 'Wallet'),
    ('CUST1018', 'Susan Harris', 'ORD5061', '2025-06-25', 22.91, 'Cancelled', 'PayPal'),
    ('CUST1018', 'Susan Harris', 'ORD5062', '2025-10-31', 839.66, 'Delivered', 'Debit Card'),
    ('CUST1019', 'Nancy Brown', 'ORD5063', '2024-04-19', 256.75, 'Processing', 'Cash on Delivery'),
    ('CUST1019', 'Nancy Brown', 'ORD5064', '2024-04-28', 319.1, 'Processing', 'Wallet'),
    ('CUST1019', 'Nancy Brown', 'ORD5065', '2024-06-08', 249.35, 'Shipped', 'Wallet'),
    ('CUST1019', 'Nancy Brown', 'ORD5066', '2024-09-27', 60.9, 'Processing', 'Wallet'),
    ('CUST1019', 'Nancy Brown', 'ORD5067', '2025-07-20', 260.58, 'Delivered', 'Wallet'),
    ('CUST1020', 'Jennifer Gonzalez', 'ORD5068', '2024-05-13', 882.13, 'Delivered', 'Net Banking'),
    ('CUST1020', 'Jennifer Gonzalez', 'ORD5069', '2025-10-14', 503.68, 'Shipped', 'Credit Card'),
    ('CUST1021', 'Michael Lopez', 'ORD5070', '2024-03-18', 851.42, 'Processing', 'Debit Card'),
    ('CUST1021', 'Michael Lopez', 'ORD5071', '2024-04-24', 498.29, 'Cancelled', 'UPI'),
    ('CUST1022', 'Daniel Martin', 'ORD5072', '2024-05-10', 52.97, 'Delivered', 'Wallet'),
    ('CUST1022', 'Daniel Martin', 'ORD5073', '2024-05-31', 875.41, 'Delivered', 'PayPal'),
    ('CUST1022', 'Daniel Martin', 'ORD5074', '2025-03-16', 201.7, 'Delivered', 'Credit Card');

INSERT INTO Customer_Orders (CustomerID, CustomerName, Order_ID, Order_Date, Amount, Status, ModeofPayment) VALUES
    ('CUST1022', 'Daniel Martin', 'ORD5075', '2025-07-19', 328.64, 'Shipped', 'Wallet'),
    ('CUST1023', 'Thomas Sanchez', 'ORD5076', '2024-06-07', 780.3, 'Pending', 'Wallet'),
    ('CUST1023', 'Thomas Sanchez', 'ORD5077', '2024-08-30', 172.5, 'Shipped', 'Debit Card'),
    ('CUST1023', 'Thomas Sanchez', 'ORD5078', '2025-02-20', 667.11, 'Delivered', 'Net Banking'),
    ('CUST1023', 'Thomas Sanchez', 'ORD5079', '2025-09-27', 725.17, 'Returned', 'Wallet'),
    ('CUST1024', 'John White', 'ORD5080', '2024-06-12', 712.03, 'Delivered', 'Wallet'),
    ('CUST1024', 'John White', 'ORD5081', '2024-09-11', 50.22, 'Shipped', 'Debit Card'),
    ('CUST1024', 'John White', 'ORD5082', '2024-09-30', 737.85, 'Shipped', 'PayPal'),
    ('CUST1025', 'Sandra Moore', 'ORD5083', '2024-01-25', 368.23, 'Delivered', 'Credit Card'),
    ('CUST1025', 'Sandra Moore', 'ORD5084', '2024-07-16', 870.72, 'Delivered', 'Cash on Delivery'),
    ('CUST1025', 'Sandra Moore', 'ORD5085', '2024-08-16', 466.3, 'Processing', 'Wallet'),
    ('CUST1025', 'Sandra Moore', 'ORD5086', '2024-08-21', 490.0, 'Returned', 'Credit Card'),
    ('CUST1025', 'Sandra Moore', 'ORD5087', '2025-11-06', 791.29, 'Delivered', 'UPI'),
    ('CUST1026', 'Linda Robinson', 'ORD5088', '2024-02-09', 111.82, 'Shipped', 'Cash on Delivery'),
    ('CUST1026', 'Linda Robinson', 'ORD5089', '2024-09-28', 711.19, 'Shipped', 'UPI'),
    ('CUST1027', 'Matthew Williams', 'ORD5090', '2024-04-28', 184.02, 'Delivered', 'Net Banking'),
    ('CUST1027', 'Matthew Williams', 'ORD5091', '2025-01-29', 17.49, 'Returned', 'UPI'),
    ('CUST1027', 'Matthew Williams', 'ORD5092', '2025-08-13', 623.17, 'Returned', 'Cash on Delivery'),
    ('CUST1028', 'Emily Martinez', 'ORD5093', '2025-11-17', 190.17, 'Shipped', 'Cash on Delivery'),
    ('CUST1029', 'Michelle Lewis', 'ORD5094', '2024-12-04', 293.49, 'Cancelled', 'Cash on Delivery'),
    ('CUST1029', 'Michelle Lewis', 'ORD5095', '2025-09-30', 811.63, 'Shipped', 'Cash on Delivery'),
    ('CUST1030', 'Lisa Jackson', 'ORD5096', '2025-02-22', 304.34, 'Processing', 'UPI'),
    ('CUST1031', 'Richard Thompson', 'ORD5097', '2024-05-10', 603.79, 'Delivered', 'Cash on Delivery'),
    ('CUST1031', 'Richard Thompson', 'ORD5098', '2024-07-15', 814.07, 'Processing', 'PayPal'),
    ('CUST1031', 'Richard Thompson', 'ORD5099', '2025-03-06', 374.96, 'Cancelled', 'PayPal');



-- ============================================================
-- SOLUTION
-- ============================================================


-- FIND FIRST AND LAST ORDER OF ALL THE CUSTOMERS
-- SHOULD HAVE ONE ROW PER CUSTOMER


SELECT DISTINCT customerid,customername
,MIN(order_date) OVER (PARTITION BY
    customerid) AS FIRST_ORDER_DATE
,MAX(order_date) OVER (PARTITION BY
    customerid) AS LAST_ORDER_DATE
FROM customer_orders