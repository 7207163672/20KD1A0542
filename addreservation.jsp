<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*, com.mysql.jdbc.exceptions.jdbc4.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<!-- Page by Max Pandolpho -->
<head>
<title>Reservation Added</title>
</head>
<body>
	<%
	try {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
 		String username = (String)session.getAttribute("username");
		String trainArrival = request.getParameter("arrival_datetime");
		int trainID = Integer.parseInt(request.getParameter("id"));
		
		ResultSet res = stmt.executeQuery("select * from Train_Schedule t where t.arrival_datetime = '" + trainArrival + "' and t.id = " + trainID);
		if(!res.next()) {
			response.setContentType("text/html");
			out.println("<script type=\"text/javascript\">");
			out.println("alert('The requested train schedule does not exist');");
			out.println("window.location.href = \"reservationspage.jsp\";");
			out.println("</script>");
			throw new Exception();
		}

		//check if there are seats available
		
		Statement stmt8 = con.createStatement();
		String decrementSeatQuery="select available_seats from Train_Schedule t where t.arrival_datetime = '" + trainArrival + "' and t.id = " + trainID;
		ResultSet decrementSeat = stmt8.executeQuery(decrementSeatQuery);

		decrementSeat.next();
		int availableSeats=decrementSeat.getInt("available_seats");
		
		if(availableSeats<=0){
			response.setContentType("text/html");
			out.println("<script type=\"text/javascript\">");
			out.println("alert('We regret to inform you that no available seats are left on this train');");
			out.println("window.location.href = \"reservationspage.jsp\";");
			out.println("</script>");
			throw new Exception();
		}
		int origin = Integer.parseInt(request.getParameter("origin"));
		int destination = Integer.parseInt(request.getParameter("destination"));
		
		String originTime, destinationTime;
		Statement stmt3 = con.createStatement();
		
		if(origin == res.getInt("destination_station_id")) {
			response.setContentType("text/html");
			out.println("<script type=\"text/javascript\">");
			out.println("alert('The requested train schedule does not visit the stops requested in the requested order.');");
			out.println("window.location.href = \"reservationspage.jsp\";");
			out.println("</script>");
			throw new Exception();
		}
		if(destination == res.getInt("origin_station_id")) {
			response.setContentType("text/html");
			out.println("<script type=\"text/javascript\">");
			out.println("alert('The requested train schedule does not visit the stops requested in the requested order.');");
			out.println("window.location.href = \"reservationspage.jsp\";");
			out.println("</script>");
			throw new Exception();
		}
		
		if(origin == res.getInt("origin_station_id")) {
			originTime = res.getString("origin_arrival_time");
		}
		else {
			ResultSet resO = stmt3.executeQuery("select s.arrival_datetime from Intermediate_Stop s where s.stationid = " + origin + " and s.trainid = " + trainID + " and s.final_destination_arrival_datetime = '" + trainArrival + "'");
			if(!resO.next()){
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('The requested train schedule does not visit at least one of the stops requested');");
				out.println("window.location.href = \"reservationspage.jsp\";");
				out.println("</script>");
				throw new Exception();
			}
			originTime = resO.getString("arrival_datetime");
		}
		if(destination == res.getInt("destination_station_id")) {
			destinationTime = res.getString("destination_arrival_time");
		}
		else {
			ResultSet resD = stmt3.executeQuery("select s.arrival_datetime from Intermediate_Stop s where s.stationid = " + destination + " and s.trainid = " + trainID + " and s.final_destination_arrival_datetime = '" + trainArrival + "'");
			if(!resD.next()){
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('The requested train schedule does not visit at least one of the stops requested');");
				out.println("window.location.href = \"reservationspage.jsp\";");
				out.println("</script>");
				throw new Exception();
			}
			destinationTime = resD.getString("arrival_datetime");
		}
		
		java.time.LocalDateTime or = java.time.LocalDateTime.of(Integer.parseInt(originTime.substring(0,4)), Integer.parseInt(originTime.substring(5,7)), Integer.parseInt(originTime.substring(8,10)), Integer.parseInt(originTime.substring(11,13)), Integer.parseInt(originTime.substring(14, 16)), Integer.parseInt(originTime.substring(17,19)), Integer.parseInt(originTime.substring(20)));
		java.time.LocalDateTime de = java.time.LocalDateTime.of(Integer.parseInt(destinationTime.substring(0,4)), Integer.parseInt(destinationTime.substring(5,7)), Integer.parseInt(destinationTime.substring(8,10)), Integer.parseInt(destinationTime.substring(11,13)), Integer.parseInt(destinationTime.substring(14, 16)), Integer.parseInt(destinationTime.substring(17,19)), Integer.parseInt(destinationTime.substring(20)));
		if(or.compareTo(de) > 0){
			response.setContentType("text/html");
			out.println("<script type=\"text/javascript\">");
			out.println("alert('The requested train schedule does not visit the stops requested in the requested order.');");
			out.println("window.location.href = \"reservationspage.jsp\";");
			out.println("</script>");
			throw new Exception();
		}
		
		String date = trainArrival.substring(0,10);
		String trip = request.getParameter("trip");

		if(trip.equals("monthly")) {
			java.time.LocalDate day = java.time.LocalDate.of(Integer.parseInt(date.substring(0,4)), Integer.parseInt(date.substring(5,7)), Integer.parseInt(date.substring(8)));
			day = day.plusMonths(1);
			date = day.toString();
		}
		else if(trip.equals("weekly")) {
			java.time.LocalDate day = java.time.LocalDate.of(Integer.parseInt(date.substring(0,4)), Integer.parseInt(date.substring(5,7)), Integer.parseInt(date.substring(8)));
			day = day.plusWeeks(1);
			date = day.toString();
		}
		
		double total_fare = 0;
		double constant = 1;
		if(trip.equals("one-way"))
			total_fare = Integer.parseInt(res.getString("one_way_fare"));
		else if(trip.equals("roundtrip"))
			total_fare = Integer.parseInt(res.getString("round_trip_fare"));
		else if(trip.equals("monthly"))
			total_fare = Integer.parseInt(res.getString("monthly_fare"));
		else if(trip.equals("weekly"))
			total_fare = Integer.parseInt(res.getString("weekly_fare"));
		double ticket_cost = total_fare;
		
		String discount = request.getParameter("discount");

		if(discount.equals("child")) {
			total_fare -= total_fare*res.getDouble("child_discount");
		}
		else if(discount.equals("senior")) {
			total_fare -= total_fare*res.getDouble("senior_discount");
		}
		else if(discount.equals("disabled")) {
			total_fare -= total_fare*res.getDouble("disabled_discount");
		}
		
		String passenger = request.getParameter("passenger");
		
		String seat = request.getParameter("seat");
		
		//check if there is anyone else with that seat
		Statement stmt5 = con.createStatement();
		
		ResultSet validSeat = stmt5.executeQuery("select t.seats from Train t where t.id = "+ trainID);
		validSeat.next();
		if(validSeat.getInt("seats") < Integer.parseInt(seat)) {
			response.setContentType("text/html");
			out.println("<script type=\"text/javascript\">");
			out.println("alert('This is not a valid seat number for the selected train.');");
			out.println("window.location.href = \"reservationspage.jsp\";");
			out.println("</script>");
			throw new Exception();
		}
		
		String seatCheckQuery="select count(*) as total from Reservation where seat_number="+seat+" and train_destination_arrival_time='"+trainArrival+"' and trainid="+trainID + " and cancelled = 0 and destination_arrival_time > '" + originTime + "' and origin_arrival_time < '" + destinationTime + "'";
		ResultSet seatCount = stmt5.executeQuery(seatCheckQuery);
		
		seatCount.next();
		int total=seatCount.getInt("total");
		if(total>0){
			response.setContentType("text/html");
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Chosen seat taken. Please select another seat.');");
			out.println("window.location.href = \"reservationspage.jsp\";");
			out.println("</script>");
			throw new Exception();
		}
		
		//decrement the seat with this success
		availableSeats=availableSeats-1;
		Statement stmt9 = con.createStatement();
		String updateSeatQuery="update Train_Schedule t set available_seats="+availableSeats+" where t.arrival_datetime = '" + trainArrival + "' and t.id = " + trainID;
		int updated = stmt9.executeUpdate(updateSeatQuery);
		
		if(updated<=0){
				
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Error when adding Reservation.');");
				out.println("window.location.href = \"reservationspage.jsp\";");
				out.println("</script>");
				throw new Exception();
		}
		
		String trainClass = request.getParameter("class");
		
		String query = "select reservation_number from Counters";
		Statement stmt7 = con.createStatement();
		ResultSet resnum = stmt7.executeQuery(query);
		resnum.next();
		int reservation_number = resnum.getInt("reservation_number")+1;			
		double booking_fee = ticket_cost*.15;
		if(trainClass.equals("first"))
			booking_fee = ticket_cost*.5;
		else if(trainClass.equals("business"))
			booking_fee = ticket_cost*.25;
		
		String serviceRep = "None";
		
		//Make an insert statement for the Sells table:
		String insert = "insert into Reservation(reservation_number, total_fare, booking_fee, date, passenger_name, seat_number, class, customer_username, origin_station, destination_station, origin_arrival_time, destination_arrival_time, trainid, train_destination_arrival_time, trip, service_representative_name, discount)"
				+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, reservation_number);
		ps.setDouble(2, total_fare);
		ps.setDouble(3, booking_fee);
		ps.setString(4, date);
		ps.setString(5, passenger);
		ps.setString(6, seat);
		ps.setString(7, trainClass);
		ps.setString(8, username);
		ps.setInt(9, origin);
		ps.setInt(10, destination);
		ps.setString(11, originTime);
		ps.setString(12, destinationTime);
		ps.setInt(13, trainID);
		ps.setString(14, trainArrival);
		ps.setString(15, trip);
		ps.setString(16, serviceRep);
		ps.setString(17, discount);

		int count = ps.executeUpdate();
		
		if(count <= 0){
			//response.sendRedirect("loggedin.jsp");
			out.print("insert failed");
			response.setContentType("text/html");
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Error when adding reservation.');");
			out.println("window.location.href = \"reservationspage.jsp\";");
			out.println("</script>");
			throw new Exception();
		}
		
		//now update the counter for reservation number
		
		//Create a SQL statement
		Statement stmt2 = con.createStatement();
		String updateCounterQuery="update Counters set reservation_number="+reservation_number;
		int executed = stmt2.executeUpdate(updateCounterQuery);
		
			if(executed >0 ) {
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Reservation Added.');");
				out.println("window.location.href = \"reservationspage.jsp\";");
				out.println("</script>");
			}
			else {
				//response.sendRedirect("incorrectcredentials.jsp");
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Error when adding reservation.');");
				out.println("window.location.href = \"reservationspage.jsp\";");
				out.println("</script>");
				throw new Exception();
			}
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
	} 
	catch (SQLException ex) {
		//out.print(ex);
		//out.print("sql failed");
		response.setContentType("text/html");
		out.println("<script type=\"text/javascript\">");
		out.println("alert('Error when adding reservation. Please check your inputs and try again');");
		out.println("window.location.href = \"reservationspage.jsp\";");
		out.println("</script>");
	}
	catch (Exception ex) {
		out.print(ex);
		out.print("failure");
	}
%>

</body>
</html>