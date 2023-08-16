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
<p><b> View Your Reservations Here. </b></p>
<p>
<p>
<h2 align="center"><font><strong><%= session.getAttribute("username") %>'s Reservations</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="0" border="3">
<tr>

</tr>
<tr bgcolor="#E21745">
<td><b>Reservation Number</b></td>
<td><b>Train ID</b></td>
<td><b>Total Cost</b></td>
<td><b>Ticket Cost</b></td>
<td><b>Booking Fee</b></td>
<td><b>Seat Number</b></td>
<td><b>Class</b></td>
<td><b>Passenger Name</b></td>
<td><b>Origin Station</b></td>
<td><b>Origin Station Arrival Time</b></td>
<td><b>Destination Station</b></td>
<td><b>Destination Station Arrival Time</b></td>
<td><b>Trip</b></td>
<td><b>Valid Until</b></td>
<td><b>Customer Representative</b></td>
<td><b>Status</b></td>
</tr>
<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("username");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String password = request.getParameter("password");
			//String str = "select count(username) from Customer where username = '" + username + "' and password = '" + password + "'";
			String str = "select * from Reservation where customer_username = '" + session.getAttribute("username")+"'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			ResultSet temp;
			int o, d;
			String origin, destination;
			
			while(result.next()){
			o = result.getInt("origin_station");
			temp = stmt2.executeQuery("select s.name from Station s where s.station_id = " + o);
			temp.next();
			origin = temp.getString("name");
			d = result.getInt("destination_station");
			temp = stmt2.executeQuery("select s.name from Station s where s.station_id = " + d);
			temp.next();
			destination = temp.getString("name");
			
			String cancelledBool=result.getString("cancelled");
			String cancelled="";
			if(cancelledBool.equals("0")){
				cancelled="On-time";
			}
			else if(cancelledBool.equals("1")){
				cancelled="Cancelled";
			}
			else if(cancelledBool.equals("2")){
				cancelled="Delayed";
			}
			String resid = result.getString("reservation_number");
			double booking = result.getDouble("booking_fee");
			double trainCost = result.getDouble("total_fare");
			String trip = result.getString("trip");
			double totalCost=booking + trainCost;
			
			java.text.NumberFormat format = java.text.NumberFormat.getCurrencyInstance(java.util.Locale.US);
			String total = format.format(totalCost);
			String book = format.format(booking);
			String ticket = format.format(trainCost);
			
			String trainClass=result.getString("class");
			trainClass=(trainClass.charAt(0)+"").toUpperCase()+trainClass.substring(1,trainClass.length());
				%>
	<tr bgcolor="#ECE2B6">

<td><%=result.getString("reservation_number") %></td>
<td><%=result.getString("trainid") %></td>
<td><%=total %></td>
<td><%=ticket %></td>
<td><%=book %></td>
<td><%=result.getString("seat_number") %></td>
<td><%=trainClass %></td>
<td><%=result.getString("passenger_name") %></td>
<td><%=origin %></td>
<td><%=result.getString("origin_arrival_time") %></td>
<td><%=destination %></td>
<td><%=result.getString("destination_arrival_time") %></td>
<td><%=trip %></td>
<td><%=result.getString("date") %></td>
<td><%=result.getString("service_representative_name") %></td>
<td><%=cancelled %></td>

</tr>


<% 
}
//close the connection.
con.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</table>
</p>
<p><b>Please note that for roundtrip, weekly and monthly reservations, only the first booking dates and times are listed.</b></p>

<p><input type="reset" value="Make Reservation" onclick="window.location.href= 'makereservation.jsp'"></p>
<p><input type="reset" value="Cancel Reservation" onclick="window.location.href= 'cancelreservation.jsp'"></p>
<p><input type="reset" value="Home Page" onclick="window.location.href= 'loggedin.jsp'"></p>
<p><input type="reset" value="Log Out" onclick="window.location.href= 'logout.jsp'"></p>

</div>

</div>
</body>
</html>