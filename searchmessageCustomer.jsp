<%@ page language="java" contentType="text/html"%>

<html>
<head>
<title>Message Searching</title>
</head>
<body bgcolor="#07a396">
<h1> Train System (Group 41) </h1>
<div style="border:7px groove #ccc">

<div class="container">

<section>
	<form name="Search Messages" action="inboxQuery.jsp" method="post" accept-charset="utf-8">
   
   	<p><b>Find messages based on Reservation Number, key phrases, or Employee Name</b></p>
   	<p><b>Search for your messages using the following filters (fill in as many as you would like):</b></p>
   	
   	<p><label for="question_number">Message ID</label>
   	<input type="number" name="question_number" placeholder="Enter Message ID"></p>
   	
   	<p><label for="message">Message Key Phrase</label>
   	<input type="text" name="message" placeholder="Enter Message Key Phrase"></p>
   	
   	<p><label for="reply">Reply Key Phrase</label>
   	<input type="text" name="reply" placeholder="Enter Reply Key Phrase"></p>
   	
   	<p><label for="name">Employee's Name</label>
   	<input type="text" name="name" placeholder="Enter Employee Name"></p>
	   
   	<p><input type="submit" value="Search"></p>
	<br></br>
   
 	</form>
</section>

<p><input type="reset" value="View Messages" onclick="window.location.href= 'viewinbox.jsp'"></p>
<p><input type="reset" value="Home Page" onclick="window.location.href= 'loggedin.jsp'"></p>
<p><input type="reset" value="Log Out" onclick="window.location.href= 'logout.jsp'"></p>

</div>

</div>
</body>
</html>