<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Issue Book</title>
<style>
body {
	margin: 0;
	padding: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
		url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=1470&q=80');
	background-position: center;
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
}

.home-btn, .back-btn {
	position: absolute;
	top: 20px;
	padding: 6px 12px;
	font-weight: bold;
	font-size: 12px;
	border-radius: 6px;
	border: 2px solid;
	text-decoration: none;
	cursor: pointer;
	transition: background-color 0.3s ease, color 0.3s ease;
}

.home-btn {
	right: 20px;
	background-color: white;
	color: #2e7d32;
	border-color: #2e7d32;
}

.home-btn:hover {
	background-color: #2e7d32;
	color: white;
}

.back-btn {
	left: 20px;
	background-color: white;
	color: #0d47a1;
	border-color: #0d47a1;
}

.back-btn:hover {
	background-color: #0d47a1;
	color: white;
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
	font-size: 18px;
	color: #0d47a1;
	margin-bottom: 20px;
	border-bottom: 1.5px solid #90caf9;
	padding-bottom: 6px;
}

label {
	display: block;
	margin-top: 12px;
	font-size: 13px;
	font-weight: bold;
	color: #333;
}

select {
	width: 100%;
	padding: 8px;
	font-size: 13px;
	border-radius: 6px;
	border: 1px solid #ccc;
	margin-top: 4px;
	font-family: inherit;
	outline: none;
	transition: border-color 0.3s ease;
}

select:focus {
	border-color: #64b5f6;
	box-shadow: 0 0 5px rgba(100, 181, 246, 0.5);
}

.btn {
	margin-top: 20px;
	padding: 10px;
	width: 100%;
	font-size: 13px;
	border-radius: 6px;
	border: none;
	cursor: pointer;
	background-color: #64b5f6;
	color: white;
	transition: background-color 0.3s ease;
	font-family: inherit;
	font-weight: bold;
}

.btn:hover {
	background-color: #42a5f5;
}

.popup {
	position: fixed;
	top: 30px;
	left: 50%;
	transform: translateX(-50%);
	padding: 12px 25px;
	font-size: 13px;
	font-weight: bold;
	border-radius: 8px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
	z-index: 9999;
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

input[type="text"], select {
	width: 100%;
	padding: 8px;
	margin-top: 4px;
	font-size: 13px;
	border: 1px solid #ccc;
	border-radius: 6px;
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

	<a href="${pageContext.request.contextPath}/jsp/index.jsp"
		class="home-btn">🏠 Home</a>
	<a href="${pageContext.request.contextPath}/jsp/issueReturn.jsp"
		class="back-btn">← Back</a>

	<!-- Show popup if message exists -->
	<c:if test="${not empty message}">
		<div id="popupMessage" class="popup ${status}">${message}</div>
	</c:if>

	<div class="container">
		<h1>📖 Issue Book</h1>
		<form
			action="${pageContext.request.contextPath}/issuesAndReturns/issueRecord"
			method="post">
			<label>Select Member:</label> 
			<input type="text" id="searchMember"
				placeholder="Search by member name" autocomplete="off" />
			<div id="memberSuggestions" class="suggestions"
				style="display: none;"></div>
			<input type="hidden" name="member" id="memberIdField" required /> 
			
			<label>Select Book:</label> <input type="text" id="searchBook"
				placeholder="Search by title or author" autocomplete="off" />
			<div id="suggestions" class="suggestions" style="display: none;"></div>

			<!-- Hidden field to store selected bookId -->
			<input type="hidden" name="book" id="bookIdField" required /> <input
				type="submit" value="📘 Issue Book" class="btn" />
		</form>
	</div>

	<script>
	const memberMap = new Map();
	<c:forEach items="${members}" var="member">
	    memberMap.set(${member.memberId}, "${member.memberName}");
	</c:forEach>

	console.log("Members in map:");
	memberMap.forEach((name, id) => console.log(id + ": " + name));

	const searchMemberInput = document.getElementById("searchMember");
	const memberSuggestionsBox = document.getElementById("memberSuggestions");
	const memberIdField = document.getElementById("memberIdField");

	searchMemberInput.addEventListener("input", function() {
		 console.log("Input value:", this.value);
	    const searchTerm = this.value.toLowerCase().trim();
	    memberSuggestionsBox.innerHTML = "";
	    if (!searchTerm) {
	        memberSuggestionsBox.style.display = "none";
	        return;
	    }
	    let matches = [];
	    memberMap.forEach((name, id) => {
	        if (name.toLowerCase().includes(searchTerm)) {
	            matches.push({id: id, name: name});
	        }
	        console.log("Matches found:", matches);
	    });
	    if (matches.length > 0) {
	        matches.forEach(match => {
	            const item = document.createElement("div");
	            item.classList.add("suggestion-item");
	            item.textContent = match.name;
	            item.onclick = () => {
	                memberIdField.value = match.id;
	                searchMemberInput.value = match.name;
	                memberSuggestionsBox.style.display = "none";
	            };
	            memberSuggestionsBox.appendChild(item);
	        });
	        memberSuggestionsBox.style.display = "block";
	    } else {
	        memberSuggestionsBox.style.display = "none";
	    }
	});

	// Prepare book data
    const bookMap = new Map();
    <c:forEach items="${books}" var="book">
        bookMap.set(${book.getBookId()}, {
            "title": "${book.getTitle()}",
            "author": "${book.getAuthor()}"
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
        }
    }
    const popup = document.getElementById('popupMessage');
    if (popup) {
        popup.style.display = 'block';
        setTimeout(() => {
            popup.style.display = 'none';
        }, 3000);
    }
</script>

</body>
</html>
