<%@ page language="java" contentType="text/html"%>

<html>
<head>
<title>Home Page</title>
</head>
<body bgcolor="#07a396">
<h1> Train System (Group 41) </h1>
<div style="border:7px groove #ccc">

<div class="container">
<p><b> Welcome to our project home page! </b></p>
<p> You are logged in as <%= session.getAttribute("username") %>. </p>

<p><input type="reset" value="View Reservations" onclick="window.location.href= 'reservationspage.jsp'"></p>
<p><input type="reset" value="View Inbox" onclick="window.location.href= 'viewinbox.jsp'"></p>
<p><input type="reset" value="Search Train Schedules" onclick="window.location.href= 'trainScheduleSearch.jsp'"></p>
<p><input type="reset" value="Log Out" onclick="window.location.href= 'logout.jsp'"></p>

</div>

</div>
</body>
</html>