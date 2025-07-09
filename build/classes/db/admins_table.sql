-- SQL script to create admins table and insert a sample admin user

CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert a sample admin user with username 'admin' and password 'admin123' hashed with MD5
INSERT INTO admins (username, password, nama_lengkap) VALUES (
    'maulida',
    MD5('admin123'),
    'Administrator'
);
t