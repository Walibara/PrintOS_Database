CREATE TABLE IF NOT EXISTS files (
    file_name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    original TINYINT(1) DEFAULT 0,
    file_link VARCHAR(1000) NOT NULL,
    created_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_modified_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    last_modified_by BIGINT,
    PRIMARY KEY (file_name),
    CONSTRAINT fk_files_last_modified_by
        FOREIGN KEY (last_modified_by) REFERENCES users(id)
);
