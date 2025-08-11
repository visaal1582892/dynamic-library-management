<%@page import="com.dynamic_library_management.domain.Book"%>
<%@page
	import="com.dynamic_library_management.dao.implementation.BookDaoImplementation"%>
<%@page import="com.dynamic_library_management.constants.BookCategory"%>
<%@page import="com.dynamic_library_management.constants.BookStatus"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setAttribute("categoryList", List.of(BookCategory.values()));
request.setAttribute("statusList", List.of(BookStatus.values()));
request.setAttribute("bookList", new BookDaoImplementation().selectAllBooks());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Book</title>
<style>
/* existing styles unchanged */
body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
		url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=1470&q=80');
	background-size: cover;
	background-position: center;
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
}

.back-btn {
	position: absolute;
	top: 15px;
	left: 15px;
	background-color: rgba(255, 255, 255, 0.8);
	color: #0d47a1;
	padding: 6px 12px;
	font-size: 14px;
	font-weight: bold;
	border: none;
	border-radius: 6px;
	text-decoration: none;
	transition: background-color 0.3s ease;
	z-index: 10;
}

.back-btn:hover {
	background-color: #bbdefb;
}

.container {
	width: 360px;
	background: rgba(255, 255, 255, 0.95);
	padding: 25px 35px;
	border-radius: 12px;
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
	position: relative;
}

h1 {
	text-align: center;
	font-size: 22px;
	color: #0d47a1;
	margin-bottom: 20px;
	border-bottom: 2px solid #90caf9;
	display: inline-block;
	padding-bottom: 8px;
}

label {
	display: block;
	margin-top: 12px;
	font-size: 14px;
	color: #0d47a1;
	font-weight: bold;
}

input[type="text"], select {
	width: 100%;
	padding: 8px;
	margin-top: 4px;
	font-size: 13px;
	border: 1px solid #ccc;
	border-radius: 6px;
}

.submit-btn {
	display: block;
	width: 100%;
	margin-top: 20px;
	padding: 10px;
	background-color: #64b5f6;
	color: white;
	font-size: 14px;
	font-weight: bold;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.submit-btn:hover {
	background-color: #42a5f5;
}

.popup {
	position: absolute;
	top: 10%;
	left: 50%;
	transform: translateX(-50%);
	background-color: #f0f0f0;
	padding: 10px 20px;
	border-radius: 8px;
	font-size: 14px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	z-index: 999;
	display: none;
}

.popup.success {
	background-color: #c8e6c9;
	color: #2e7d32;
}

.popup.error {
	background-color: #ffcdd2;
	color: #c62828;
}

/* suggestions dropdown */
.suggestions {
	position: absolute;
	background: white;
	border: 1px solid #ccc;
	border-radius: 6px;
	max-height: 150px;
	overflow-y: auto;
	width: calc(100% - 70px);
	z-index: 1000;
}

.suggestion-item {
	padding: 6px 10px;
	cursor: pointer;
	font-size: 13px;
}

.suggestion-item:hover {
	background-color: #f0f0f0;
}
</style>
</head>
<body>

	<a href="${pageContext.request.contextPath}/jsp/bookOptions.jsp"
		class="back-btn">← Back</a>

	<c:if test="${not empty message}">
		<div id="popupMessage" class="popup ${success ? 'success' : 'error'}">
			${message}</div>
	</c:if>

	<div class="container">
		<h1>🔄 Update Book</h1>

		<form
			action="${pageContext.request.contextPath}/books/updateBookDetailsController"
			method="post">
			<label>Search Book:</label> <input type="text" id="searchBook"
				placeholder="Search by title or author" autocomplete="off" />
			<div id="suggestions" class="suggestions" style="display: none;"></div>

			<!-- Hidden field to store selected bookId -->
			<input type="hidden" name="bookId" id="bookIdField" required /> <label>Title:</label>
			<input type="text" name="title" id="titleField" required /> <label>Author:</label>
			<input type="text" name="author" id="authorField" required /> <label>Category:</label>
			<select name="category" id="categoryField" required>
				<option value="">Select Category</option>
				<c:forEach items="${categoryList}" var="category">
					<option value="${category.getStringValue()}">${category.toString()}</option>
				</c:forEach>
			</select> <input type="submit" class="submit-btn" value="✏️ Update Book" />
		</form>
	</div>

	<script>
    const bookMap = new Map();
    <c:forEach items="${bookList}" var="book">
        bookMap.set(${book.getBookId()}, {
            "title": "${book.getTitle()}",
            "author": "${book.getAuthor()}",
            "category": "${book.getCategory().getStringValue()}"
        });
    </c:forEach>

    const searchInput = document.getElementById("searchBook");
    const suggestionsBox = document.getElementById("suggestions");
    const bookIdField = document.getElementById("bookIdField");

    searchInput.addEventListener("input", function() {
        const searchTerm = this.value.toLowerCase().trim();
        suggestionsBox.innerHTML = "";
        if (!searchTerm) {
            suggestionsBox.style.display = "none";
            return;
        }
        let matches = [];
        bookMap.forEach((book, id) => {
            if (book.title.toLowerCase().includes(searchTerm) || book.author.toLowerCase().includes(searchTerm)) {
                matches.push(id);
            }
        });
        if (matches.length > 0) {
        	matches.forEach(matchId => {
        	    const bookObj = bookMap.get(matchId); // Get the book object
        	    const item = document.createElement("div");
        	    item.classList.add("suggestion-item");
        	    item.textContent = bookObj["title"]+" - "+bookObj["author"];
        	    item.onclick = () => {
        	        loadBookDetails(matchId);
        	        searchInput.value = bookObj["title"]+" - "+bookObj["author"];
        	        suggestionsBox.style.display = "none";
        	    };
        	    suggestionsBox.appendChild(item);
        	});

            suggestionsBox.style.display = "block";
        } else {
            suggestionsBox.style.display = "none";
        }
    });

    function loadBookDetails(bookId) {
        const currBook = bookMap.get(bookId);
        if (currBook) {
            bookIdField.value = bookId;
            document.getElementById("titleField").value = currBook.title;
            document.getElementById("authorField").value = currBook.author;
            document.getElementById("categoryField").value = currBook.category;
        }
    }

    const titleInput = document.querySelector('input[name="title"]');
    const authorInput = document.querySelector('input[name="author"]');

    titleInput.addEventListener('input', function () {
        this.value = this.value.replace(/[^a-zA-Z0-9 ]/g, '');
        if (this.value.length > 60) {
            this.value = this.value.substring(0, 60);
        }
    });

    authorInput.addEventListener('input', function () {
        this.value = this.value.replace(/[^a-zA-Z ]/g, '');
        if (this.value.length > 60) {
            this.value = this.value.substring(0, 60);
        }
    });

    document.querySelector('form').addEventListener('submit', function(e) {
        let titleField = document.querySelector('input[name="title"]');
        let authorField = document.querySelector('input[name="author"]');
        titleField.value = titleField.value.trim().replace(/\s+/g, ' ');
        authorField.value = authorField.value.trim().replace(/\s+/g, ' ');
    });

    // Popup auto-hide
    const popup = document.getElementById('popupMessage');
    if (popup) {
        popup.style.display = 'block';
        setTimeout(() => { popup.style.display = 'none'; }, 3000);
    }
</script>

</body>
</html>
