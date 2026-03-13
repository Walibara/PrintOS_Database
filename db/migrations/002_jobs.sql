-- =========================================================
-- I tried to follow the schema as much as possible but 
-- I am sure, it will need to serious changes - this is just
-- so I can test the "submit job" button
-- 
-- Since this project is still in development, so these rules are
-- flexible for now while we don’t have real data.
--
-- In a real production setting (when data actually matters),
-- you technically cannot edit the file.
-- Instead, create a NEW migration file in:
--
--   db/migrations/003_*.sql (or whatever number we need)
--
-- Since we are able to edit the file, here is how we can dot it later:
--
-- Add a column:
--   ALTER TABLE jobs ADD COLUMN customer_email VARCHAR(150);
--
-- Change a column:
--   ALTER TABLE jobs MODIFY cost DECIMAL(12,2);
--
-- Add a foreign key later when users table exists:
--   ALTER TABLE jobs
--   ADD CONSTRAINT fk_jobs_user
--   FOREIGN KEY (uploaded_by_user_id) REFERENCES users(id);
--
-- After adding a new migration file, run:
--   python3 main.py
--
-- Thank you for your attention to this matter,
-- Maria 1/26/26
-- =========================================================

CREATE TABLE IF NOT EXISTS jobs (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,-- job number

  job_type VARCHAR(100) NOT NULL,
  name VARCHAR(255) NOT NULL,


  files VARCHAR(500), -- this will eventually have a path to a S3 bucket where we gonna keep the file
  file_type VARCHAR(50),


  -- which worker currently own this job
  additional_comments VARCHAR(255),
  current_worker_id VARCHAR(50) NULL,
  last_heartbeat_at TIMESTAMP NULL,
  retry_count INT NOT NULL DEFAULT 0,
  max_retries INT NOT NULL DEFAULT 3,



  status VARCHAR(50) NOT NULL,-- backend sets: CREATED/FAILED/PROCESSING/etc.

  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,

  uploaded_by_user_id BIGINT NULL,-- future FK to users(id)
  last_updated_by VARCHAR(100) NULL -- "worker:imposition" or "user:12"
);
