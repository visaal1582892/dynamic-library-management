package com.dynamic_library_management.services;

import java.util.List;

import com.dynamic_library_management.constants.BookCategory;
import com.dynamic_library_management.domain.Book;
import com.dynamic_library_management.exceptions.DatabaseException;
import com.dynamic_library_management.exceptions.InvalidDetailsException;

public interface BookServiceInterface {
	void validateAddBook(String title, String author, BookCategory category)
			throws InvalidDetailsException, DatabaseException;

	void validateUpdateBookDetails(int id, String title, String author, BookCategory category, com.dynamic_library_management.constants.BookStatus status)
			throws InvalidDetailsException, DatabaseException;

	List<Book> validateViewAllBooks() throws DatabaseException;
}
