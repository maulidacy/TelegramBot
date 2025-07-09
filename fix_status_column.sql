-- Alter the 'status' column in 'users' table to VARCHAR(20) to accommodate status values
ALTER TABLE users MODIFY COLUMN status VARCHAR(20) NOT NULL DEFAULT 'unv';

-- Optionally, if you want to restrict status values, you can use ENUM type instead:
-- ALTER TABLE users MODIFY COLUMN status ENUM('unv', 'pending', 'verified', 'blocked') NOT NULL DEFAULT 'unv';
