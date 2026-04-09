-- Users table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    cognito_sub VARCHAR(255) NOT NULL UNIQUE
    email VARCHAR(255) NULL;
    name VARCHAR(255) NULL,
        
    created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_modified_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    /*jobs VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    PRIMARY KEY (id)*/ -- commenting this out since it's not needed. Maria 
);
