<?php
include 'config.php';

$sql = "SELECT id, nom, email, date_creation FROM users";
$result = $conn->query($sql);

echo "<h1>List Users</h1>";

if ($result->num_rows > 0) {
    echo "<table border='1' cellpadding='10'>";
    echo "<tr><th>ID</th><th>Nom</th><th>Email</th><th>Date Creation</th></tr>";
    while($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>".$row['id']."</td>";
        echo "<td>".$row['nom']."</td>";
        echo "<td>".$row['email']."</td>";
        echo "<td>".$row['date_creation']."</td>";
        echo "</tr>";
    }
    echo "</table>";
} else {
    echo "Aucun utilisateur.";
}

$conn->close();
?>
