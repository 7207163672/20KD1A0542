<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, com.mysql.jdbc.exceptions.jdbc4.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Account Created</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Get parameters from the HTML form at the index.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String telephone = request.getParameter("telephone");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zipcode = request.getParameter("zipcode");
		
		//Make an insert statement for the Sells table:
		String insert = "insert into Customer(username, password, email, first_name, last_name, telephone, address, city, state, zip_code)"
				+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, username);
		ps.setString(2, password);
		ps.setString(3, email);
		ps.setString(4, firstname);
		ps.setString(5, lastname);
		ps.setString(6, telephone);
		ps.setString(7, address);
		ps.setString(8, city);
		ps.setString(9, state);
		ps.setString(10, zipcode);
		
		int count = ps.executeUpdate();
		
		if(count > 0){
			response.sendRedirect("accountcreated.jsp");
		}
		else
			out.print("insert failed");
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
	} 
	catch (SQLException ex) {
		if(ex instanceof MySQLIntegrityConstraintViolationException){
			//response.sendRedirect("duplicateaccount.jsp");
			response.setContentType("text/html");
			out.println("<script type=\"text/javascript\">");
			out.println("alert('An account with the Username: "+request.getParameter("username")+" already exists');");
			out.println("window.location.href = \"createaccount.jsp\";");
			out.println("</script>");
		}
		else
			out.print(ex);
	}
	catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
		response.setContentType("text/html");
		out.println("<script type=\"text/javascript\">");
		out.println("alert('Error when creating account. Check your input carefully.');");
		out.println("window.location.href = \"createaccount.jsp\";");
		out.println("</script>");
	}
%>
</body>
</html>