<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, com.mysql.jdbc.exceptions.jdbc4.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
		
		//Get message from sendMessageCustomer
		String message = request.getParameter("message");
		
		//get the counter for the question id
		String counterQuery="select question_number from Counters";
		
				
		ResultSet result = stmt.executeQuery(counterQuery);
		result.next();
		
		int question_number=result.getInt("question_number")+1;
		//System.out.println(question_number);
		
		//Username is session.getAttribute("username")
		
		//'" + session.getAttribute("username")+"'"
		
		//Make an insert statement 
		//Insert with a Dummy ssn (-1) and empty reply. Update when customer rep responds.
		String insert = "insert into Messages(question_number,username,ssn,question,reply)"
				+ "values (?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, question_number);
		ps.setString(2, session.getAttribute("username")+"");
		ps.setInt(3, -1);  //DUMMY SSN
		ps.setString(4, message);
		ps.setString(5, "");  //EMPTY REPLY
		
		int count = ps.executeUpdate();
		
		if(count <= 0){
			//response.sendRedirect("loggedin.jsp");
			out.print("insert failed");
			response.setContentType("text/html");
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Error when adding message.');");
			out.println("window.location.href = \"viewinbox.jsp\";");
			out.println("</script>");
		}
		
		//now update the counter for question number
		
		//Create a SQL statement
		Statement stmt2 = con.createStatement();
		String updateCounterQuery="update Counters set question_number="+question_number;
		int executed = stmt2.executeUpdate(updateCounterQuery);
			
			if(executed >0 ) {
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Message Successfully Sent.');");
				out.println("window.location.href = \"viewinbox.jsp\";");
				out.println("</script>");
			}
			else {
				//response.sendRedirect("incorrectcredentials.jsp");
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Error when adding message.');");
				out.println("window.location.href = \"viewinbox.jsp\";");
				out.println("</script>");
			}
			
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
	} 
	catch (SQLException ex) {
			out.print(ex);
	}
	catch (Exception ex) {
		out.print(ex);
		out.print("failure");
	}
%>

</body>
</html>