<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, com.mysql.jdbc.exceptions.jdbc4.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<!-- Page by Max Pandolpho -->
<title>Reservations</title>
</head>
<body bgcolor="#07a396">
<h1> Train System (Group 41) </h1>
<div style="border:7px groove #ccc">

<div class="container">
<p><b> Make a Reservation Here. </b></p>
<p><b> Please view our Train Schedules to get the required reservation information. </b></p>
  <section>
	<form name="Reserve" action="addreservation.jsp" method="post" accept-charset="utf-8">
    
 	<p><label for="id">Please enter the ID number of the train you want to ride on</label>
    <input type="text" name="id" placeholder="Enter Train ID" required></p>
    <p><label for="arrival_datetime">Please enter the final destination arrival time of the train you want to ride on</label>
    <input type="text" name="arrival_datetime" placeholder="Enter Destination Arrival Time" required></p>
    
    Please fill in the ID of the specific station you seek to board the train at
    <input type="text" name="origin" placeholder="Enter Origin Station" required></p>
    Please fill in the ID of the specific station you seek to get off the train at
    <input type="text" name="destination" placeholder="Enter Destination Station" required></p>
    
    Please fill in if you qualify for the following discounts (you may only use one per reservation)
    <br>
	<input type="radio" name="discount" value="child"/>Child Discount
	<br>
	<input type="radio" name="discount" value="senior"/>Senior Discount
	<br>
	<input type="radio" name="discount" value="disabled"/>Disability Discount
	<br>
	<input type="radio" name="discount" value="none"/>None
	
	<p><label for="trip">What kind of trip will this be?</label>
    <br>
	<input type="radio" name="trip" value="one-way"/>One-Way
	<br>
	<input type="radio" name="trip" value="roundtrip"/>Roundtrip
	<br>
	<input type="radio" name="trip" value="monthly"/>Monthly
	<br>
	<input type="radio" name="trip" value="weekly"/>Weekly
		
	<p><label for="passenger">Please enter the name of the passenger this ticket is for</label>
    <input type="text" name="passenger" placeholder="Enter Passenger Name" required></p>

	<p><label for="seat">Please input the seat number you would like to request</label>
    <input type="text" name="seat" placeholder="Enter Seat Number" required></p>

	Please state which class you would like to sit in
    <br>
	<input type="radio" name="class" value="first"/>First
	<br>
	<input type="radio" name="class" value="business"/>Business
	<br>
	<input type="radio" name="class" value="coach"/>Coach
	
    <p><input type="submit" value="Make Reservation"></p>
    <br></br>
    
    </form>
   </section> 
<p><input type="reset" value="View Reservations" onclick="window.location.href= 'reservationspage.jsp'"></p>
<p><input type="reset" value="Cancel Reservation" onclick="window.location.href= 'cancelreservation.jsp'"></p>
<p><input type="reset" value="Search Train Schedules" onclick="window.location.href= 'trainScheduleSearch.jsp'"></p>
<p><input type="reset" value="Home Page" onclick="window.location.href= 'loggedin.jsp'"></p>
<p><input type="reset" value="Log Out" onclick="window.location.href= 'logout.jsp'"></p>

</div>

</div>
</body>
</html>