# EIE3537 Big Data and Data Engineering

This repository contains the code and reports for the lab assignments of **EIE3537 Big Data and Data Engineering**. The work covers Relational Database Management (MySQL) and AI Model Implementation (ModelScope).

## 📂 [Lab1]: Database SQL Practice

**Topic:** Library Management System Implementation

### 📝 Overview
Design and implement a "Library Management System" database using **MySQL 8.0+**. The project involves ER modeling, schema creation, data manipulation, and business logic simulation using SQL.

### 🛠 Key Requirements
* **Database Configuration:** Must use **MySQL 8.0+** with `utf8mb4` encoding to support Chinese characters. Table and attribute names should be in **Chinese**.
* **Schema Design:**

  Create tables based on the ER diagram (Reader, Book, Borrowing Record).

  Define appropriate Primary Keys (PK) and Foreign Keys (FK).
* **Data Operations:**
  
  **Insert:** Populate initial data for Readers (including your own student ID), Books (including 0 stock items), and Borrowing Records (covering various states: returned, overdue, renewed).

  **Simulation:** Implement logic for Borrowing, Returning, Renewing (limit 2 times), and Daily Updates (marking overdue items).

  **Query:** Statistics on reader activity and out-of-stock books.

  **Maintenance:** Update categories for out-of-stock/inactive books and delete logs of returned items.

### 🌟 Bonus Task (Credit Score System)
* Add a `Credit Score` field (default 100) via `ALTER TABLE`.
* Implement logic: **-5 points** for overdue returns, **+2 points** for on-time returns.
* **Design Challenge:** Create a robust design (potentially a separate history table) to prevent "inflation" or duplicate scoring for the same transaction.

---
## 📂 [Lab2]: ModelScope Speech Synthesis

**Topic:** Text-to-Speech (TTS) with Alibaba ModelScope

Utilize the **ModelScope** platform and Alibaba Cloud resources to deploy a Speech Synthesis model that converts a line of Chinese text into audio.
