ALTER TABLE jobs
  CHANGE COLUMN materia material VARCHAR(100),
  CHANGE COLUMN original_file original_file VARCHAR(255) NOT NULL;

-- normalize current values 
UPDATE jobs SET status = 'CREATED'    WHERE status IN ('READY','CREATED');
UPDATE jobs SET status = 'IN_PROGRESS'WHERE status IN ('RUNNING','PROCESSING','IN_PROGRESS');
UPDATE jobs SET status = 'FINISHED'   WHERE status IN ('COMPLETED','FINISHED');
UPDATE jobs SET status = 'FAILED'     WHERE status IN ('ERROR','FAILED','TIMEOUT','TIMED_OUT');

-- changed status to 4 values again
ALTER TABLE jobs
  MODIFY COLUMN status ENUM('CREATED','IN_PROGRESS','FINISHED','FAILED')
  NOT NULL DEFAULT 'CREATED';
