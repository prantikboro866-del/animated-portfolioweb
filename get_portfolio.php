<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

// 1. Load JSON static portfolio data
$jsonPath = __DIR__ . '/portfolio_data.json';
$portfolioData = [];

if (file_exists($jsonPath)) {
    $jsonData = file_get_contents($jsonPath);
    $portfolioData = json_decode($jsonData, true);
}

if (!$portfolioData) {
    echo json_encode([
        "status" => "error",
        "message" => "Failed to load portfolio configuration."
    ]);
    exit();
}

// 2. Attempt to query database content without letting connection errors terminate the script
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'portfolio_db';

$db_projects = [];
$db_services = [];

// Temporarily suppress mysqli errors to handle connection failure gracefully
mysqli_report(MYSQLI_REPORT_OFF);
$temp_conn = @new mysqli($host, $username, $password);

if ($temp_conn && !$temp_conn->connect_error) {
    if ($temp_conn->select_db($database)) {
        $temp_conn->set_charset("utf8");
        $sql = "SELECT * FROM projects ORDER BY created_at DESC";
        $result = $temp_conn->query($sql);
        
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $db_projects[] = [
                    "title" => $row['title'],
                    "description" => $row['description'],
                    "link" => $row['link']
                ];
            }
        }

        $servicesResult = $temp_conn->query("SELECT icon, title, link, description FROM services ORDER BY id ASC");
        if ($servicesResult && $servicesResult->num_rows > 0) {
            while ($row = $servicesResult->fetch_assoc()) {
                $db_services[] = $row;
            }
        }
    }
    $temp_conn->close();
}

// 3. Merge database projects with static projects if any exist
if (!isset($portfolioData['projects'])) {
    $portfolioData['projects'] = [];
}

if (!empty($db_projects)) {
    // Append database projects to the list
    $portfolioData['projects'] = array_merge($portfolioData['projects'], $db_projects);
}

// Services are managed entirely in the database.
$portfolioData['services'] = $db_services;

// 4. Output complete merged response
echo json_encode([
    "status" => "success",
    "data" => $portfolioData
]);
?>
