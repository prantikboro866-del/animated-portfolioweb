-- Services database table
CREATE DATABASE IF NOT EXISTS portfolio_db;
USE portfolio_db;

CREATE TABLE IF NOT EXISTS services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    icon VARCHAR(100) NOT NULL,
    title VARCHAR(255) NOT NULL,
    link VARCHAR(500) DEFAULT '',
    description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO services (icon, title, link, description) VALUES
('fas fa-shopping-cart', 'E-commerce', 'https://nest-narratives-co.lovable.app', 'Building high-converting, secure online stores tailored to your business needs.'),
('fas fa-paint-brush', 'Graphics Design', 'https://encrypt-essay-doctrine.ngrok-free.dev/project%20management%20system/index%20p.html', 'Crafting beautiful, intuitive interfaces and striking graphical assets for your brand.'),
('fas fa-book', 'E-books', 'https://encrypt-essay-doctrine.ngrok-free.dev/other%20files/kid%20play/', 'Designing, formatting, and publishing professional e-books to share your knowledge.'),
('fas fa-laptop-code', 'Web Design', 'https://encrypt-essay-doctrine.ngrok-free.dev/other%20files/programming%20files/webpage-buiding/', 'Creating responsive, fast, and modern websites focused on excellent user experience.'),
('fas fa-database', 'Database Management', 'https://encrypt-essay-doctrine.ngrok-free.dev/phpmyadmin/index.php?lang=en', 'Designing and maintaining efficient, secure databases for your applications.'),
('fas fa-code', 'Localhost Projects', 'https://encrypt-essay-doctrine.ngrok-free.dev/', 'Developing custom software solutions and scripts to automate tasks and enhance functionality.');
