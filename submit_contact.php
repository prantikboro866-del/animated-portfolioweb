<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

require_once 'db_connect.php';

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(200); exit(); }

$rawBody     = file_get_contents("php://input");
$contentType = isset($_SERVER['CONTENT_TYPE']) ? $_SERVER['CONTENT_TYPE'] : '';

if (stripos($contentType, 'application/json') !== false) {
    $data = json_decode($rawBody, true);
} elseif (!empty($rawBody)) {
    parse_str($rawBody, $data);
} else {
    $data = $_POST;
}

$name    = isset($data['name'])    ? trim($data['name'])    : '';
$email   = isset($data['email'])   ? trim($data['email'])   : '';
$message = isset($data['message']) ? trim($data['message']) : '';

if ($name === '' || $email === '' || $message === '') {
    echo json_encode(["status" => "error", "message" => "All fields are required."]);
    exit();
}
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode(["status" => "error", "message" => "Invalid email address."]);
    exit();
}

$statement = $conn->prepare("INSERT INTO messages (name, email, message) VALUES (?, ?, ?)");

if ($statement === false) {
    echo json_encode(["status" => "error", "message" => "Unable to prepare message storage."]);
    $conn->close();
    exit();
}

$statement->bind_param('sss', $name, $email, $message);
$saved = $statement->execute();
$statement->close();
$conn->close();

if ($saved) {
    echo json_encode(["status" => "success", "message" => "Message received! I'll get back to you soon."]);
} else {
    echo json_encode(["status" => "error", "message" => "Unable to save your message. Please try again."]);
}
?>
