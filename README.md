# 🚀 Projet Infra Simple avec Vagrant & VirtualBox  

## 📌 Contexte  
Dans une équipe de développement, chaque développeur utilise un système différent (Windows, Linux, macOS).  
Résultat : l’application fonctionne chez certains, mais pas chez d’autres.  

👉 Solution : créer une **infrastructure commune et reproductible** avec **Vagrant** et **VirtualBox**.  

---

## 🏗️ Architecture du projet  

Le projet contient **2 machines virtuelles** :  

1. **🌐 Web Server (Ubuntu 22.04)**  
   - Serveur **Nginx**  
   - Site web déployé automatiquement  
   - Réseau privé + accès public via le port `8080`  

2. **🗄️ Database Server (CentOS 9)**  
   - Base de données **MySQL 8**  
   - Base créée : `myapp`  
   - Tables et données de test importées automatiquement  
   - Port forwarding : `3306 → 3307`  

---

## 📂 Structure du projet  

projet-infra-simple/
├── Vagrantfile
├── scripts/
│ ├── provision-web-ubuntu.sh
│ └── provision-db-centos.sh
├── website/
├── database/
│ ├── create-table.sql
│ └── insert-demo-data.sql
└── README.md

## ⚙️ Installation & Utilisation  

### 1️⃣ Prérequis  
- [VirtualBox](https://www.virtualbox.org/)  
- [Vagrant](https://developer.hashicorp.com/vagrant/downloads)  

### 2️⃣ Cloner le projet  
```bash
git clone https://github.com/abdo0302/projet-infra-simple.git
cd projet-infra-simple

3️⃣ Démarrer les machines
vagrant up
4️⃣ Accéder aux services
Web : http://localhost:8080

MySQL (depuis l’hôte) :
mysql -h 127.0.0.1 -P 3307 -u root -p
📦 Publication sur Vagrant Cloud
Les machines sont disponibles sur Vagrant Cloud :

🌐 ubuntu-web/web-server

🗄️ centos-db/db-server

👉 Exemple d’utilisation :

vagrant init ubuntu-web/web-server
vagrant up
🛠️ Dépannage (Troubleshooting)
Port déjà utilisé
→ Modifier les ports dans Vagrantfile.

Erreur 403/500 sur Nginx
→ Vérifier la config dans /etc/nginx/sites-available/default.

Connexion MySQL refusée
→ Vérifier que le port 3307 est libre.

🎯 Conclusion
 Ce projet montre comment :
✔️ Créer un environnement multi-machines automatisé
✔️ Uniformiser la configuration pour toute l’équipe
✔️ Partager des box sur Vagrant Cloud


