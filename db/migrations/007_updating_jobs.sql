UPDATE jobs SET status = 'READY' WHERE status = 'CREATED';
UPDATE jobs SET status = 'RUNNING' WHERE status = 'PROCESSING';
UPDATE jobs SET status = 'ERROR' WHERE status = 'FAILED';
