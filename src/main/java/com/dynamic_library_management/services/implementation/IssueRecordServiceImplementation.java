package com.dynamic_library_management.services.implementation;

import java.util.List;

import com.dynamic_library_management.dao.IssueRecordDaoInterface;
import com.dynamic_library_management.dao.implementation.IssueRecordDaoImplementation;
import com.dynamic_library_management.domain.IssueRecord;
import com.dynamic_library_management.services.IssueRecordServiceInterface;

public class IssueRecordServiceImplementation implements IssueRecordServiceInterface {

	IssueRecordDaoInterface dao = new IssueRecordDaoImplementation();

	@Override
	public String issueBook(IssueRecord issue) {
		return dao.issueBook(issue);
	}

	@Override
	public String returnBook(int memberId, int bookId) {
		return dao.returnBook(memberId, bookId);
	}

	@Override
	public List<IssueRecord> getAllIssues() {
		return dao.getAllIssues();
	}
}
