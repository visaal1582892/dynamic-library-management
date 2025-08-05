package com.dynamic_library_management.dao.implementation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.sql.DataSource;

import com.dynamic_library_management.dao.ReportsDaoInterface;
import com.dynamic_library_management.domain.IssueRecord;
import com.dynamic_library_management.exceptions.DatabaseException;
import com.dynamic_library_management.utilities.ConnectionPoolingServlet;

public class ReportsDaoImplementation implements ReportsDaoInterface {
	
	private final DataSource dataSource = ConnectionPoolingServlet.getDataSource();

	public DataSource getDataSource() {
		return dataSource;
	}

	@Override
	public Map<Object, Long> countOfBooksPerCategory() {
		Map<Object, Long> countMap=null;
		List<String> booksList=new ArrayList<>();
		String selectQuery="select category from lms.books";
		ResultSet resultSet;
		try (Connection conn = getDataSource().getConnection();
				Statement statement = conn.createStatement()){
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
				.filter(b -> b.getIssueDate().isBefore(LocalDate.now().minusDays(17)))
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
