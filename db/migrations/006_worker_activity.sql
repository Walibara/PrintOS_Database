-- Worker Activity Audit table
CREATE TABLE IF NOT EXISTS worker_activity (
    id INT AUTO_INCREMENT PRIMARY KEY,
    job_id BIGINT NOT NULL,
    worker_id VARCHAR(50) NOT NULL,
    worker_type ENUM('SUCCESS','FAILURE','TIMEOUT') NOT NULL,
    expected_behavior ENUM('SUCCESS','FAILURE','TIMEOUT') NULL,
    actual_result ENUM('SUCCESS','FAILURE','TIMEOUT','ERROR') NOT NULL,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    finished_at TIMESTAMP NULL,
    log_reference VARCHAR(1000),
    notes TEXT,
    CONSTRAINT fk_worker_activity_job
        FOREIGN KEY (job_id) REFERENCES jobs(id),
    CONSTRAINT fk_worker_activity_worker
        FOREIGN KEY (worker_id) REFERENCES workers(id)
);

-- Indexes for troubleshooting
CREATE INDEX idx_worker_behavior
    ON worker_activity (worker_type, actual_result);

CREATE INDEX idx_worker_job_id
    ON worker_activity (job_id);
