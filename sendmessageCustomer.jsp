<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, com.mysql.jdbc.exceptions.jdbc4.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>Message Sending</title>
</head>
<body bgcolor="#07a396">
<h1> Train System Login (Group 41) </h1>
<div style="border:7px groove #ccc">

<div class="container">
<p><b> Send Messages Here. </b></p>
  <section>
	<form name="Message" action="addmessageCustomer.jsp" method="post" accept-charset="utf-8">
    
    A Customer Representative will respond when they can.
  
	<p><label for="Question">Enter your message:</label>
    <input type="text" name="message" placeholder="your message" required></p>

	
    
    <p><input type="submit" value="Confirm"></p>
    <br></br>
    
    </form>
   </section> 
<p><input type="reset" value="View Messages" onclick="window.location.href= 'viewinbox.jsp'"></p>
<p><input type="reset" value="Home Page" onclick="window.location.href= 'loggedin.jsp'"></p>
<p><input type="reset" value="Log Out" onclick="window.location.href= 'logout.jsp'"></p>

</div>

</div>
</body>
</html>