package com.dynamic_library_management.dao.implementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.dynamic_library_management.constants.BookAvailability;
import com.dynamic_library_management.constants.BookCategory;
import com.dynamic_library_management.constants.BookStatus;
import com.dynamic_library_management.dao.BookDaoInterface;
import com.dynamic_library_management.domain.Book;
import com.dynamic_library_management.exceptions.DatabaseException;
import com.dynamic_library_management.utilities.ConnectionPoolingServlet;

public class BookDaoImplementation implements BookDaoInterface {

    private final DataSource dataSource = ConnectionPoolingServlet.getDataSource();

    public DataSource getDataSource() {
        return dataSource;
    }

//    Functional to insert logs 
    private void insertBookLog(Connection conn, Book book) throws DatabaseException {
        String insertBooksLogQuery = 
            "INSERT INTO books_log(book_id, title, author, category, status, availability) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement psInsertLog = conn.prepareStatement(insertBooksLogQuery)) {
            psInsertLog.setInt(1, book.getBookId());
            psInsertLog.setString(2, book.getTitle());
            psInsertLog.setString(3, book.getAuthor());
            psInsertLog.setString(4, book.getCategory().getStringValue());
            psInsertLog.setString(5, book.getStatus().getStringValue());
            psInsertLog.setString(6, book.getAvailability().getStringValue());
            int count=psInsertLog.executeUpdate();
            if (count!=1) {
				throw new DatabaseException("Log Not Inserted Properly");
			}
        }catch (DatabaseException | SQLException e) {
			throw new DatabaseException(e.getMessage());
		}
    }

    @Override
    public int addBook(Book book) throws DatabaseException {
        int id = -1;
        try (Connection conn = getDataSource().getConnection();
             PreparedStatement psInsert = conn.prepareStatement(
                 "INSERT INTO books(title, author, category, status, availability) VALUES (?, ?, ?, ?, ?)",
                 Statement.RETURN_GENERATED_KEYS)) {

            psInsert.setString(1, book.getTitle());
            psInsert.setString(2, book.getAuthor());
            psInsert.setString(3, book.getCategory().getStringValue());
            psInsert.setString(4, book.getStatus().getStringValue());
            psInsert.setString(5, book.getAvailability().getStringValue());
            int count=psInsert.executeUpdate();;
            if (count!=1) {
				throw new DatabaseException("Book Not Added Correctly");
			}

            ResultSet rs = psInsert.getGeneratedKeys();
            if (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new DatabaseException("Failed to add book: " + e.getMessage());
        }catch(DatabaseException e) {
        	throw e;
        }
        return id;
    }

//    @Override
//    public void updateBookDetails(Book oldBook, Book newBook) throws DatabaseException {
//        String updateBooksQuery = 
//            "UPDATE books SET title=?, author=?, category=?, status=? WHERE book_id=?";
//
//        try (Connection conn = getDataSource().getConnection()) {
//            conn.setAutoCommit(false);
//            try {
//                insertBookLog(conn, oldBook);
//
//                try (PreparedStatement psUpdate = conn.prepareStatement(updateBooksQuery)) {
//                    psUpdate.setString(1, newBook.getTitle());
//                    psUpdate.setString(2, newBook.getAuthor());
//                    psUpdate.setString(3, newBook.getCategory().getStringValue());
//                    psUpdate.setString(4, newBook.getStatus().getStringValue());
//                    psUpdate.setInt(5, oldBook.getBookId());
//                    psUpdate.executeUpdate();
//                }
//
//                conn.commit();
//            } catch (SQLException e) {
//                conn.rollback();
//                throw new DatabaseException("Error occurred while updating book details: " + e.getMessage());
//            }
//        } catch (SQLException e) {
//            throw new DatabaseException("Database error during updateBookDetails: " + e.getMessage());
//        }
//    }
    
    @Override
    public void updateBookDetails(Book oldBook, Book newBook) throws DatabaseException {
        String updateBooksQuery = 
            "UPDATE books SET title=?, author=?, category=? WHERE book_id=?";

        try (Connection conn = getDataSource().getConnection()) {
            conn.setAutoCommit(false);
            try {
                insertBookLog(conn, oldBook);

                try (PreparedStatement psUpdate = conn.prepareStatement(updateBooksQuery)) {
                    psUpdate.setString(1, newBook.getTitle());
                    psUpdate.setString(2, newBook.getAuthor());
                    psUpdate.setString(3, newBook.getCategory().getStringValue());
                    psUpdate.setInt(4, oldBook.getBookId());
                    int count=psUpdate.executeUpdate();
                    if (count!=1) {
						throw new DatabaseException("Book Not Updated Correctly...");
					}
                }catch(DatabaseException e) {
                	throw e;
                }

                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw new DatabaseException("Error occurred while updating book details: " + e.getMessage());
            }
        } catch (SQLException e) {
            throw new DatabaseException("Database error during updateBookDetails: " + e.getMessage());
        }
    }

    @Override
    public void updateBookAvailability(Book oldBook, String availability, Connection argConn) throws DatabaseException {
//        checking if Book status is active
        if (!BookStatus.ACTIVE.equals(oldBook.getStatus())) {
            throw new DatabaseException("Book Cannot Be Issued Since It Is Inactive");
        }

        String updateAvailabilityQuery = "UPDATE books SET availability=? WHERE book_id=?";
        
        Connection conn;
		try {
			conn = argConn==null?getDataSource().getConnection():argConn;
		} catch (SQLException e) {
			throw new DatabaseException("Unable to Connect To Database");
		}

        try{
            conn.setAutoCommit(false);
            try {
                insertBookLog(conn, oldBook);

                try (PreparedStatement psUpdate = conn.prepareStatement(updateAvailabilityQuery)) {
                    psUpdate.setString(1, availability);
                    psUpdate.setInt(2, oldBook.getBookId());
                    int count=psUpdate.executeUpdate();
                    if (count!=1) {
						throw new DatabaseException("Book Availability Not Updated Correctly...");
					}
                }catch (DatabaseException e) {
					throw e;
				}

                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw new DatabaseException("Failed to update availability: " + e.getMessage());
            }catch(DatabaseException e) {
            	throw e;
            }
        } catch (SQLException e) {
            throw new DatabaseException("Database error during updateBookAvailability: " + e.getMessage());
        }finally {
        	if(argConn==null) {
        		try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
        	}
        }
    }


    @Override
    public void deleteBook(Book oldBook) throws DatabaseException {
        String updateStatusQuery = "UPDATE books SET status=? WHERE book_id=? and availability=?";

        try (Connection conn = getDataSource().getConnection()) {
            conn.setAutoCommit(false);
            try {
                insertBookLog(conn, oldBook);

                try (PreparedStatement psUpdateStatus = conn.prepareStatement(updateStatusQuery)) {
                    psUpdateStatus.setString(1, BookStatus.INACTIVE.getStringValue());
                    psUpdateStatus.setInt(2, oldBook.getBookId());
                    psUpdateStatus.setString(3, BookAvailability.AVAILABLE.getStringValue());
                    int count=psUpdateStatus.executeUpdate();
                    if (count!=1) {
						throw new DatabaseException("An Issued Book Cannot Be Deleted, Not deleted Correcly...");
					}
                }catch (DatabaseException e) {
					throw e;
				}

                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw new DatabaseException("Failed to mark book as inactive: " + e.getMessage());
            }
            catch (DatabaseException e) {
            	throw e;
			}
        } catch (SQLException e) {
            throw new DatabaseException("Database error during deleteBook: " + e.getMessage());
        }
    }

    @Override
    public List<Book> selectAllBooks() throws DatabaseException {
        List<Book> books = new ArrayList<>();
        String selectQuery = "SELECT * FROM books WHERE status = 'A'";

        try (Connection conn = getDataSource().getConnection();
             Statement statement = conn.createStatement();
             ResultSet result = statement.executeQuery(selectQuery)) {

            while (result.next()) {
                books.add(extractBookFromResultSet(result));
            }
        } catch (SQLException e) {
            throw new DatabaseException("Failed to fetch books: " + e.getMessage());
        }
        return books;
    }

    @Override
    public Book selectBookById(int id) throws DatabaseException {
        Book book = null;
        String selectOneQuery = "SELECT * FROM books WHERE book_id=? and status='A'";

        try (Connection conn = getDataSource().getConnection();
             PreparedStatement psSelectOne = conn.prepareStatement(selectOneQuery)) {

            psSelectOne.setInt(1, id);
            ResultSet resultSet = psSelectOne.executeQuery();

            if (resultSet.next()) {
                book = extractBookFromResultSet(resultSet);
            }
        } catch (SQLException e) {
            throw new DatabaseException("Failed to fetch book by ID: " + e.getMessage());
        }
        return book;
    }

    @Override
    public List<Book> selectAllMemberBooks(int memberId) throws DatabaseException {
        List<Book> memberBooks = new ArrayList<>();
        String selectQuery = 
            "SELECT b.* FROM books b JOIN issue_records i ON b.book_id = i.book_id " +
            "WHERE i.member_id = ? AND i.status = 'I' AND b.status = 'A'";

        try (Connection conn = getDataSource().getConnection();
             PreparedStatement psSelect = conn.prepareStatement(selectQuery)) {

            psSelect.setInt(1, memberId);
            ResultSet result = psSelect.executeQuery();

            while (result.next()) {
                memberBooks.add(extractBookFromResultSet(result));
            }
        } catch (SQLException e) {
            throw new DatabaseException("Failed to fetch books issued to member: " + e.getMessage());
        }
        return memberBooks;
    }

    private Book extractBookFromResultSet(ResultSet result) throws SQLException {
        int id = result.getInt("book_id");
        String title = result.getString("title");
        String author = result.getString("author");
        BookCategory category = BookCategory.getEnumConstant(result.getString("category"));
        BookStatus status = BookStatus.getEnumConstant(result.getString("status"));
        BookAvailability availability = BookAvailability.getEnumConstant(result.getString("availability"));

        return new Book(id, title, author, category, status, availability);
    }
}
