<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Query</title>
</head>
<body>
	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("username");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String password = request.getParameter("password");
			String str = "select * from Employee where username = '" + username + "' and password = '" + password + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			int resultCount = 0;
			String isAdmin = null;
			
			while (result.next()) {
				resultCount++;
				isAdmin = result.getString("isAdmin");
			}
			
			if(resultCount > 0) {
				session.setAttribute("username",username);
				if (isAdmin.equals("1")) {
					response.sendRedirect("adminhome.jsp");
				} else {
					response.sendRedirect("customerRepHome.jsp");
				}
			} else {
				//response.sendRedirect("incorrectcredentials.jsp");
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Invalid Username or Password entered');");
				out.println("window.location.href = \"index.jsp\";");
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