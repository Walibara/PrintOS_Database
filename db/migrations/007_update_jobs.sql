ALTER TABLE jobs 
ADD COLUMN name VARCHAR(255),
ADD COLUMN current_worker_id VARCHAR(50),
ADD COLUMN last_heartbeat_at TIMESTAMP NULL,
ADD COLUMN retry_count INT NOT NULL DEFAULT 0,
ADD COLUMN max_retries INT NOT NULL DEFAULT 3,
ADD COLUMN files VARCHAR(255),
ADD COLUMN job_state ENUM('READY','RUNNING','COMPLETED','ERROR','CANCELLED','TIMED_OUT') NOT NULL DEFAULT 'READY';
ALTER TABLE jobs MODIFY COLUMN last_modified_by VARCHAR(50) NULL;

UPDATE jobs SET job_state = 'READY' WHERE status = 'CREATED';
UPDATE jobs SET job_state = 'RUNNING' WHERE status = 'PROCESSING';

UPDATE jobs SET name = CONCAT(job_type, '_', id);  -- Example: auto-generate names
UPDATE jobs SET files = original_file WHERE original_file IS NOT NULL;

ALTER TABLE jobs MODIFY COLUMN id VARCHAR(50) NOT NULL;
ALTER TABLE jobs DROP PRIMARY KEY;
ALTER TABLE jobs ADD PRIMARY KEY (id);

ALTER TABLE jobs 
DROP COLUMN status,
DROP COLUMN original_file,
DROP COLUMN file_type; 
