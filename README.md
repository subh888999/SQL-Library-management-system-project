📚 Library Management System
🏛️ Overview
The Library Management System (LMS) is a database project designed to manage books, borrowers, and transactions across multiple library branches efficiently. Built using SQL, this system ensures seamless record-keeping, optimized borrowing processes, and efficient data retrieval.

🔹 Features
📖 Book & Borrower Management: Maintain records of books, authors, borrowers, and library branches.
🔗 Database Relationships: Proper primary & foreign key constraints for data integrity.
🔄 CASCADE Operations: Ensure referential integrity with ON UPDATE CASCADE & ON DELETE CASCADE.
📊 Advanced Query Execution: Retrieve insights on book availability, borrower activity, and branch statistics.
🛠 Database Schema & Tables
tbl_publisher → Stores publisher details.
tbl_borrower → Manages borrower information.
tbl_library_branch → Represents different library branches.
tbl_book → Stores book details, linked to publishers.
tbl_book_authors → Tracks authorship of books.
tbl_book_copies → Records number of copies per branch.
tbl_book_loans → Handles book borrowing transactions.
🔍 SQL Queries for Data Insights
📌 Number of copies of "The Lost Tribe" in each branch.
📌 Borrowers who have not checked out any books.
📌 Books loaned out from "Sharpstown" branch due on 02/03/2018.
📌 Borrowers with more than five books checked out.
📌 Books authored by Stephen King available in the "Central" branch.
