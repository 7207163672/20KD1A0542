<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, com.mysql.jdbc.exceptions.jdbc4.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>Searched Messages</title>
</head>
<body bgcolor="#07a396">
<h1> Train System (Group 41) </h1>
<div style="border:7px groove #ccc">

<div class="container">
<p><b> View Your Searched Messages Here. </b></p>
<p>
<p>
<h2 align="center"><font><strong><%= session.getAttribute("username") %>'s Filtered Messages</strong></font></h2>
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
			
			//get parameters
			String questionNum = request.getParameter("question_number");
			String message = request.getParameter("message");
			String reply = request.getParameter("reply");
			String name = request.getParameter("name");
			//System.out.println(questionNum);
			//System.out.println(message);
			//System.out.println(reply);
			//System.out.println(name);
			
			boolean questionNumGiven = questionNum != null && !questionNum.equals("");
			boolean messageGiven = message != null && !message.equals("");
			boolean replyGiven = reply != null && !reply.equals("");
			boolean nameGiven = name != null && !name.equals("");
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("username");
			//String str = "select count(username) from Customer where username = '" + username + "' and password = '" + password + "'";
			String str = "select * from Messages where username = '" + session.getAttribute("username")+"'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
			
			
			while(result.next()){
				String qNum=result.getString("question_number");
				String uName=result.getString("username");
				String q=result.getString("question");
				String r=result.getString("reply");
				
				int ssn=result.getInt("ssn");
				String employeeQuery = "select first_name, last_name from Employee where ssn =" + ssn;
				Statement stmt2 = con.createStatement();
				ResultSet employeeResult = stmt2.executeQuery(employeeQuery);
				employeeResult.next();
				String eName=employeeResult.getString("first_name")+" "+employeeResult.getString("last_name");
				
				if(questionNumGiven && (!qNum.equals(questionNum) || qNum==null))
					continue;
				if(messageGiven && (q==null || q.toLowerCase().indexOf(message.toLowerCase())<0))
					continue;
				if(replyGiven && (r==null || r.toLowerCase().indexOf(reply.toLowerCase())<0))
					continue;
				if(nameGiven && (eName==null || eName.toLowerCase().indexOf(name.toLowerCase())<0))
					continue;
				%>
	<tr bgcolor="#ECE2B6">

<td><%=qNum %></td>
<td><%=uName %></td>
<td><%=q %></td>
<td><%=r %></td>
<td><%=eName %></td>

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

<p><input type="reset" value="Go Back" onclick="window.location.href= 'searchmessageCustomer.jsp'"></p>
<p><input type="reset" value="View Messages" onclick="window.location.href= 'viewinbox.jsp'"></p>
	<p><input type="reset" value="Home Page" onclick="window.location.href= 'loggedin.jsp'"></p>
	<p><input type="reset" value="Log Out" onclick="window.location.href= 'logout.jsp'"></p>


</div>

</div>
</body>
</html>