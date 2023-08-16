<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cancel Reservation</title>
</head>
<body>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			//Get the combobox from the index.jsp
			String rid = request.getParameter("reservationid");
			String str2 = "select cancelled from Reservation where customer_username = '" + session.getAttribute("username")+"' and reservation_number = " + rid;
			ResultSet result = stmt2.executeQuery(str2);
			int executed=0;
			if(result.next()==false){
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('You do not have a reservation with this reservation number');");
				out.println("window.location.href = \"cancelreservation.jsp\";");
				out.println("</script>");
			}
			String status=result.getString("cancelled");
			
			if((status!=null && status.equals("1"))){
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Reservation Already Cancelled.');");
				out.println("window.location.href = \"cancelreservation.jsp\";");
				out.println("</script>");
			}
			else if(status!=null && status.equals("0") || status.equals("2")){
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "update Reservation set cancelled = 1, alerted = 0 where customer_username = '" + session.getAttribute("username")+"' and reservation_number = " + rid;
			//Run the query against the database.
			executed = stmt.executeUpdate(str);
			
%>
<jsp:include page="alertUser.jsp" /> 
<% 	
			if(executed >0 ) {
				stmt.executeUpdate("update Train_Schedule t, Reservation r set t.available_seats = t.available_seats + 1 where r.trainid = t.id and r.train_destination_arrival_time = t.arrival_datetime");
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Reservation Successfully Cancelled.');");
				out.println("window.location.href = \"cancelreservation.jsp\";");
				out.println("</script>");
			}
			else {
				//response.sendRedirect("incorrectcredentials.jsp");
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Error Cancelling Reservation');");
				out.println("window.location.href = \"cancelreservation.jsp\";");
				out.println("</script>");
			}
			}
			else{
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Error Cancelling Reservation');");
				out.println("window.location.href = \"cancelreservation.jsp\";");
				out.println("</script>");
			}
			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print(e);
		}
	%>

</body>
</html>