<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, com.mysql.jdbc.exceptions.jdbc4.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>Message Box</title>
</head>
 <jsp:include page="alertUser.jsp" /> 
<body bgcolor="#07a396">
<h1> Train System (Group 41) </h1>
<div style="border:7px groove #ccc">

<div class="container">
<p><b> View Your Messages Here. </b></p>
<p>
<p>
<h2 align="center"><font><strong><%= session.getAttribute("username") %>'s Messages</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="0" border="3">
<tr>

</tr>
<tr bgcolor="#E21745">
<td><b>Message ID</b></td>
<td><b>Customer Username</b></td>
<td><b>Message</b></td>
<td><b>Reply</b></td>
<td><b>Employee Name</b></td>
</tr>
<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("username");
			//String str = "select count(username) from Customer where username = '" + username + "' and password = '" + password + "'";
			String str = "select * from Messages where username = '" + session.getAttribute("username")+"'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			while(result.next()){
				int ssn=result.getInt("ssn");
				String employeeQuery = "select first_name, last_name from Employee where ssn =" + ssn;
				Statement stmt2 = con.createStatement();
				ResultSet employeeResult = stmt2.executeQuery(employeeQuery);
				employeeResult.next();
				String name=employeeResult.getString("first_name")+" "+employeeResult.getString("last_name");
				%>
	<tr bgcolor="#ECE2B6">

<td><%=result.getString("question_number") %></td>
<td><%=result.getString("username") %></td>
<td><%=result.getString("question") %></td>
<td><%=result.getString("reply") %></td>
<td><%=name %></td>

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

<p><input type="reset" value="Send A Message" onclick="window.location.href= 'sendmessageCustomer.jsp'"></p>
<p><input type="reset" value="Search for a Message" onclick="window.location.href= 'searchmessageCustomer.jsp'"></p>
<p><input type="reset" value="Check For New Messages" onclick="window.location.href= 'viewinbox.jsp'"></p>
<p><input type="reset" value="Home Page" onclick="window.location.href= 'loggedin.jsp'"></p>
<p><input type="reset" value="Log Out" onclick="window.location.href= 'logout.jsp'"></p>

</div>

</div>
</body>
</html>