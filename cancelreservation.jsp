<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, com.mysql.jdbc.exceptions.jdbc4.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>Reservations</title>
</head>
<body bgcolor="#07a396">
<h1> Train System (Group 41) </h1>
<div style="border:7px groove #ccc">

<div class="container">
<p><b> Cancel a Reservation Here. </b></p>
  <section>
	<form name="Delete Reservation" action="removereservation.jsp" method="post" accept-charset="utf-8">
    
    <p><label for="reservationid">Reservation Number</label>
    <input type="number" name="reservationid" placeholder="Enter Reservation ID" required></p>  
    <p><input type="submit" value="Cancel Reservation"></p>

    
    </form>
   </section> 
<br></br>
<p><input type="reset" value="View Reservations" onclick="window.location.href= 'reservationspage.jsp'"></p>
<p><input type="reset" value="Home Page" onclick="window.location.href= 'loggedin.jsp'"></p>
<p><input type="reset" value="Log Out" onclick="window.location.href= 'logout.jsp'"></p>

</div>

</div>
</body>
</html>