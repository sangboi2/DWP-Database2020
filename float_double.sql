DROP DATABASE IF EXISTS FloatDoubleDecimalDemoDB; 
CREATE DATABASE FloatDoubleDecimalDemoDB; 
USE FloatDoubleDecimalDemoDB;

CREATE TABLE test_table (
    float_a FLOAT, 
    double_b DOUBLE, 
    decimal_c DECIMAL (6,5)
) 

INSERT INTO test_table VALUES 
(0.6, 0.6, 0.6), 
(0.00006, 0.00006, 0.00006);


SELECT float_a*1000, double_b*1000, decimal_c*1000 
FROM test_table;