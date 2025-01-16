# Resource and Activity Management System (RAMS)

Welcome to the **Resource and Activity Management System (RAMS)** repository! This project focuses on creating a robust database schema and SQL operations to manage users, drivers, vehicles, documents, and contracts efficiently.

## Features
- **Database Design**: Includes detailed schemas for tables such as Users, Drivers, Vehicles, Documents, Contracts, and Tasks.
- **Data Integrity**: Implements primary keys, foreign keys, unique constraints, and check constraints.
- **Advanced SQL Operations**: Supports complex queries, joins, and data analysis.
- **Sample Data**: Preloaded with meaningful sample entries for easy testing and development.

## Table of Contents
1. [Technologies Used](#technologies-used)
2. [Database Schema](#database-schema)
3. [Key Features](#key-features)
4. [Getting Started](#getting-started)
5. [SQL Highlights](#sql-highlights)
6. [Contributing](#contributing)
7. [License](#license)

---

## Technologies Used
- **SQL**: Core language for database creation and manipulation.
- **Oracle Database**: Recommended RDBMS for this project.

## Database Schema
The database consists of the following key tables:
- `Utilizatori_AMO` (Users)
- `Soferi_AMO` (Drivers)
- `Documente_AMO` (Documents)
- `Contracte_AMO` (Contracts)
- `Vehicule_AMO` (Vehicles)
- `Sarcini_AMO` (Tasks)

### Key Relationships:
- **Users ↔ Drivers**: Linked via `UtilizatorID`.
- **Users ↔ Documents**: Linked via `UtilizatorID`.
- **Drivers ↔ Vehicles**: Linked via `SoferID`.
- **Users ↔ Contracts**: Linked via `UtilizatorID`.

## Key Features
1. **Schema Creation**:
   - Tables with constraints to ensure data integrity.
   - Unique constraints for fields like email, phone, and username.
2. **Data Manipulation**:
   - Insert, update, and delete operations with sample data.
3. **Advanced Queries**:
   - Joins, nested queries, and aggregate functions.
4. **Sequences**:
   - Auto-generation of primary keys using sequences.

## Getting Started
### Prerequisites
- Oracle Database or any compatible SQL database.
- SQL Developer or any preferred SQL client.

### Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/OrasanuAna/Resource_and_Activity_Management_System_-RAMS-
   ```
2. Import the SQL scripts into your SQL client.
3. Run the scripts in the following order:
   - Table creation.
   - Insert sample data.
   - Run queries for testing.

## SQL Highlights
### Example: Join Query
Fetch users along with the number of vehicles they manage:
```sql
SELECT Utilizatori_AMO.Nume, Utilizatori_AMO.Prenume, COUNT(Vehicule_AMO.VehiculID) AS NumarVehicule
FROM Utilizatori_AMO
JOIN Soferi_AMO ON Utilizatori_AMO.UtilizatorID = Soferi_AMO.UtilizatorID
LEFT JOIN Vehicule_AMO ON Soferi_AMO.SoferID = Vehicule_AMO.SoferID
GROUP BY Utilizatori_AMO.Nume, Utilizatori_AMO.Prenume;
```

### Example: Subquery
Find details of vehicles requiring an inspection within the next 30 days:
```sql
SELECT *
FROM Vehicule_AMO
WHERE VehiculID IN (
    SELECT VehiculID
    FROM Vehicule_AMO
    WHERE DataSfarsitITP BETWEEN SYSDATE AND SYSDATE + 30
);
```

## Contributing
Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Submit a pull request with detailed descriptions of your changes.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

### Author
Created and maintained by **Ana-Maria Orășanu**.

For any questions or suggestions, feel free to contact me or open an issue in the repository.
