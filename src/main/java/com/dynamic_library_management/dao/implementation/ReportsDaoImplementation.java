package com.dynamic_library_management.dao.implementation;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.dynamic_library_management.dao.IssueRecordDaoInterface;
import com.dynamic_library_management.dao.ReportsDaoInterface;
import com.dynamic_library_management.domain.Book;
import com.dynamic_library_management.domain.IssueRecord;
import com.dynamic_library_management.exceptions.DatabaseException;
import com.dynamic_library_management.services.implementation.ReportsServiceImplementation;

public class ReportsDaoImplementation implements ReportsDaoInterface {

	@Override
	public Map<Object, Long> countOfBooksPerCategory() {
		Map<Object, Long> countMap=null;
		List<String> booksList=new ArrayList<>();
		String selectQuery="select category from lms.books";
		Statement statement=DBConnection.getStatement();
		ResultSet resultSet;
		try {
			resultSet = statement.executeQuery(selectQuery);
			while(resultSet.next()) 
			{
				String category=resultSet.getString(1);
				booksList.add(category);
			}
			countMap=booksList.stream()
				.collect(Collectors.groupingBy(c -> c,Collectors.counting()));
			
		} catch (SQLException e) {
			new DatabaseException("Error Getting Book Details...");
		}
		return countMap;
	}
	

	public List<IssueRecord> getOverdueBooks() {
		//return dao.getOverdueBooks();
		List<IssueRecord> overdue = new IssueRecordDaoImplementation().getAllIssues().stream()
				.filter(b -> b.getReturnDate()==null)
				.filter(b -> b.getIssueDate().isBefore(LocalDate.now().minusDays(0)))
				.collect(Collectors.toList());
		System.out.println(overdue);
		return overdue;
	}

	@Override
	public List<List<String>> getActiveIssuedBooks() {
		List<List<String>> data =  new IssueRecordDaoImplementation().getStatusTable().stream()
				.filter(row -> row.get(4).equals("A") && row.get(3).equals("I"))
				.collect(Collectors.toList());
		System.out.println(data);
		return data;
	}
}
