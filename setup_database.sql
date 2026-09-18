-- Database Creation
CREATE DATABASE IF NOT EXISTS portfolio_db;
USE portfolio_db;

-- Projects Table
CREATE TABLE IF NOT EXISTS projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    tech_stack VARCHAR(255) NOT NULL,
    image_url VARCHAR(255) DEFAULT '',
    link VARCHAR(255) DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Messages Table (for Contact Form)
CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Services Table
CREATE TABLE IF NOT EXISTS services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    icon VARCHAR(100) NOT NULL,
    title VARCHAR(255) NOT NULL,
    link VARCHAR(500) DEFAULT '',
    description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Portfolio Services
INSERT INTO services (icon, title, link, description) VALUES
('fas fa-shopping-cart', 'E-commerce', 'https://nest-narratives-co.lovable.app', 'Building high-converting, secure online stores tailored to your business needs.'),
('fas fa-paint-brush', 'Graphics Design', 'https://encrypt-essay-doctrine.ngrok-free.dev/project%20management%20system/index%20p.html', 'Crafting beautiful, intuitive interfaces and striking graphical assets for your brand.'),
('fas fa-book', 'E-books', 'https://encrypt-essay-doctrine.ngrok-free.dev/other%20files/kid%20play/', 'Designing, formatting, and publishing professional e-books to share your knowledge.'),
('fas fa-laptop-code', 'Web Design', 'https://encrypt-essay-doctrine.ngrok-free.dev/other%20files/programming%20files/webpage-buiding/', 'Creating responsive, fast, and modern websites focused on excellent user experience.'),
('fas fa-database', 'Database Management', 'https://encrypt-essay-doctrine.ngrok-free.dev/phpmyadmin/index.php?lang=en', 'Designing and maintaining efficient, secure databases for your applications.'),
('fas fa-code', 'Localhost Projects', 'https://encrypt-essay-doctrine.ngrok-free.dev/', 'Developing custom software solutions and scripts to automate tasks and enhance functionality.');

-- Insert Sample Projects
INSERT INTO projects (title, description, tech_stack, image_url, link) VALUES 
('E-Commerce Platform', 'A fully responsive online store with shopping cart and payment integration built as part of my college final year project.', 'PHP, MySQL, HTML, CSS, JavaScript', '', '#'),
('Interactive Dashboard', 'A dynamic data visualization dashboard consuming third-party APIs to display real-time analytics.', 'JavaScript, HTML, CSS, Chart.js', '', '#'),
('College Management System', 'A system to manage student records, grades, and attendance with role-based access control.', 'PHP, MySQL, Bootstrap', '', '#');
