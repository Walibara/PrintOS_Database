-- Workers table
CREATE TABLE IF NOT EXISTS workers (
    id VARCHAR(50) NOT NULL,
    name VARCHAR(255) NOT NULL,
    lambda_function_name VARCHAR(255) NOT NULL,
    behavior_type ENUM('SUCCESS','FAILURE','TIMEOUT') NOT NULL,
    PRIMARY KEY (id)
);

