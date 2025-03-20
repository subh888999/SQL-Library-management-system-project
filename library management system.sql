#********* Library Management system**********

 # creating database
 create database Library_Management;
 # using database
 use Library_Management;
 # creating publisher table
 create table tbl_publisher (publisher_PublisherName varchar(255) 
primary key,
 publisher_PublisherAddress 
text,
 publisher_PublisherPhone 
varchar(15));
 # Loaded publisher data
 select * from tbl_publisher;
 # creating borrower table
 create table tbl_borrower (
 borrower_CardNo int primary 
key auto_increment,
                            borrower_BorrowerName varchar(255),
                            borrower_BorrowerAddress text,
                            borrower_BorrowerPhone varchar(15));
 
  # loaded borrower data.
 select * from tbl_borrower;
 # creating library branch table
 create table tbl_library_branch (
  
library_branch_BranchID int primary key auto_increment,
                                  library_branch_BranchName 
varchar(255),
                                  library_branch_BranchAddress 
text);
 # loaded library branch data.
 select * from tbl_library_branch;
 # creating book table
 create table tbl_book (book_BookID int primary key 
auto_increment,
 book_Title varchar(255),
 book_PublisherName varchar(255),
                        foreign key (book_PublisherName) 
references tbl_publisher(publisher_PublisherName)
                        on update cascade on delete cascade);
# loaded book data.
 select * from tbl_book;
 # creating book authors table
 create table tbl_book_authors (book_authors_AuthorID int primary 
key auto_increment,
 book_authors_BookID 
int,
 book_authors_AuthorName varchar(255),
                                foreign key (book_authors_BookID) 
references tbl_book(book_BookID)
                                on update cascade on delete 
cascade);
 # loaded book authors data.
 select * from tbl_book_authors;
 # creating book copies table
 create table tbl_book_copies (book_copies_CopiesID int primary 
key auto_increment,
  book_copies_BookID int,
                              book_copies_BranchID int,
                              book_copies_No_Of_Copies int,
                              foreign key (book_copies_BookID) 
references tbl_book(book_BookID)
                              on update cascade on delete 
cascade,
                              foreign key (book_copies_BranchID) 
references tbl_library_branch(library_branch_BranchID)
                              on update cascade on delete 
cascade);
 # loaded book copies data.
 select * from tbl_book_copies;
 # creating book loans table
 create table tbl_book_loans (book_loans_LoansID int primary key 
auto_increment,
 book_loans_BookID int,
                             book_loans_BranchID int,
                             book_loans_CardNo int,
                             book_loans_DateOut DATE,
                             book_loans_DueDate DATE,
                             foreign key (book_loans_BookID) 
references  tbl_book(book_BookID)
                             on update cascade on delete cascade,
                             foreign key (book_loans_BranchID) 
references tbl_library_branch(library_branch_BranchID)
                             on update cascade on delete cascade,
                            foreign key (book_loans_CardNo) 
references tbl_borrower(borrower_CardNo)
 on update cascade on delete 
cascade);
 # loaded book loans data.
 select * from tbl_book_loans;
 /* 1. How many copies of the book titled "The Lost Tribe" are 
owned by the library branch whose name is "Sharpstown"?*/
 with cte_1 as (select * from tbl_book inner join tbl_book_copies 
on tbl_book.book_BookID = tbl_book_copies.book_copies_BookID),
 cte_2 as (select * from cte_1 inner join tbl_library_branch on 
cte_1.book_copies_branchid = 
tbl_library_branch.library_branch_branchid),
 cte_3 as (select * from cte_2 where library_branch_branchname = 
"Sharpstown")
 select book_copies_no_of_copies from cte_3 where book_title = 
"The Lost Tribe";
-- 2.How many copies of the book titled "The Lost Tribe" are owned by each library branch?

 with cte_1 as (select * from tbl_book inner join tbl_book_copies 
on tbl_book.book_BookID = tbl_book_copies.book_copies_BookID),
 cte_2 as (select * from cte_1 inner join tbl_library_branch on 
cte_1.book_copies_branchid = 
tbl_library_branch.library_branch_branchid),
 cte_3 as (select * from cte_2 where book_title = "The Lost 
Tribe")
 select library_branch_branchname,sum(book_copies_no_of_copies) 
from cte_3 group by library_branch_branchname;
-- 3. Retrieve the names of all borrowers who do not have any books checked out.

 with cte_1 as (select * from tbl_borrower b left join 
tbl_book_loans bl on b.borrower_cardno = bl.book_loans_cardno)
 select borrower_borrowername from cte_1 where book_loans_cardno 
is null;
/*4. For each book that is loaned out from the "Sharpstown" 
branch and whose DueDate is 2/3/18, --    
retrieve the book title, the borrower's name, and the 
borrower's address.*/ 
with cte_1 as (select * from tbl_library_branch lb inner join 
tbl_book_loans bl on lb.library_branch_branchid = 
bl.book_loans_branchid),
 cte_2 as (select * from cte_1 where book_loans_duedate = 
"2018-02-03" and library_branch_branchname = "Sharpstown"),
 cte_3 as (select * from cte_2 inner join tbl_book b on cte_2
 .book_loans_bookid = b.book_bookid)
 select book_title,borrower_borrowername,borrower_borroweraddress 
from cte_3 inner join tbl_borrower br on cte_3.book_loans_cardno 
= br.borrower_cardno;
/* 5. For each library branch, retrieve the branch name and the 
total number of books loaned out from that branch.*/
 with cte_1 as (select * from tbl_library_branch lb inner join 
tbl_book_loans bl on lb.library_branch_branchid = 
bl.book_loans_branchid)
 select library_branch_branchname,count(book_loans_loansid) as 
Total_no_of_books_loanedout from cte_1 group by 
library_branch_branchname;
/* 6. Retrieve the names, addresses, and number of books checked 
out for all borrowers who have more than five books checked out.*/
 with cte_1 as (select * from tbl_borrower b inner join 
tbl_book_loans bl on b.borrower_cardno = bl.book_loans_cardno)
 select 
borrower_borrowername,borrower_borroweraddress,count(book_loans_loansid)
 as no_of_books_checkedout from cte_1 group by 
borrower_cardno having no_of_books_checkedout>5;
/* 7. For each book authored by "Stephen King", retrieve the 
title and the number of copies owned by the library branch whose 
name is "Central".*/
 with cte_1 as (select * from tbl_book b inner join 
tbl_book_authors ba on b.book_bookid = ba.book_authors_bookid),
 cte_2 as (select * from cte_1 inner join tbl_book_copies bc on 
cte_1.book_bookid = bc.book_copies_bookid where 
book_authors_authorname = "Stephen King"),
 cte_3 as (select * from cte_2 inner join tbl_library_branch lb on 
cte_2.book_copies_branchid = lb.library_branch_branchid)
 select book_title,book_copies_no_of_copies from cte_3 where 
 library_branch_branchname = "Central";
library_branch_branchname = "Central"; 