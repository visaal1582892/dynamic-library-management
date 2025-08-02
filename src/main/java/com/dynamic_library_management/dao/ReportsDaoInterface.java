package com.dynamic_library_management.dao;

import java.util.List;
import java.util.Map;

import com.dynamic_library_management.domain.IssueRecord;

public interface ReportsDaoInterface {
	public Map<Object, Long> countOfBooksPerCategory();

	List<IssueRecord> getOverdueBooks();

	List<List<String>> getActiveIssuedBooks();
}
