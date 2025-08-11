package com.dynamic_library_management.services;

import java.util.List;

import com.dynamic_library_management.domain.IssueRecord;

public interface IssueRecordServiceInterface {

	String issueBook(IssueRecord issue);
	String returnBook(int memberId, int bookId);
	List<IssueRecord> getAllIssues();
}
