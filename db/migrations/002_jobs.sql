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
-- Updating the db to get it ready for the s3 path (and adding other things) (Maria - 4/15)

DROP TABLE IF EXISTS jobs; 

CREATE TABLE jobs (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,-- internal db id (backend only) Maria 4/15
  job_number VARCHAR(10) NOT NULL UNIQUE -- This is the job number that the client will see

  job_type VARCHAR(100) NOT NULL,
  quantity INT NOT NULL, -- Added quantity back (Maria)
  material VARCHAR(100), -- Added material back (Maria)
  original_file VARCHAR(255) NOT NULL, --changed this from name (Maria)


  s3_key VARCHAR(500), -- canged name to s3_key (Maria)
  file_type VARCHAR(50),
  additional_comments VARCHAR(255),
  cost DOUBLE,

  -- which worker currently own this job
  current_worker_id VARCHAR(50) NULL,
  last_heartbeat_at TIMESTAMP NULL,
  retry_count INT NOT NULL DEFAULT 0,
  max_retries INT NOT NULL DEFAULT 3,


  status VARCHAR(50) NOT NULL,-- backend sets: CREATED/FAILED/PROCESSING/etc.

  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,

  uploaded_by_user_id BIGINT NOT NULL, -- changed it to be required (Maria)
  last_updated_by VARCHAR(100) NULL, -- "worker:imposition" or "user:12"

    CONSTRAINT fk_jobs_current_worker
    FOREIGN KEY (current_worker_id) REFERENCES workers(id),

  CONSTRAINT fk_jobs_uploaded_by_user
    FOREIGN KEY (uploaded_by_user_id) REFERENCES users(id)
);
