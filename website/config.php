<?php
$host = '192.168.56.20'; 
$port = 3306;
$db   = 'myapp';
$user = 'root';
$pass = 'Admin@12345';

$conn = new mysqli($host, $user, $pass, $db, $port);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
