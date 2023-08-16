<%@ page language="java" contentType="text/html"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<html>
<head>
<title>Login Page</title>
</head>
<body bgcolor="#07a396">
<h1> Train System (Group 41) </h1>
	

  <div class="container" style="border:7px groove #ccc">  
  <div id="Customer">
	  <p><b>Customer Log In</b></p>
	  <section>
		<form name="Log In" action="query.jsp" method="post" accept-charset="utf-8">
	    
	    <p><label for="username">Username</label>
	    <input type="text" name="username" placeholder="Enter Username" required></p>
	    
	    <p><label for="password">Password</label>
	    <input type="password" name="password" placeholder="Enter Password" required></p>
	    
	    <p><input type="submit" value="Log In"></p>
	    
	    </form>
	   </section>
	   <p>Don't have an account yet? <a href=createaccount.jsp>Sign Up</a>.<br/></p>
	
  </div>
  </div>
  <div class="container" style="border:7px groove #ccc">
  <div id="Employee">
  	<p><b>Employee Log In</b></p>
  	<section>
		<form name="Log In" action="loginemployee.jsp" method="post" accept-charset="utf-8">
	    
	    <p><label for="username">Username</label>
	    <input type="text" name="username" placeholder="Enter Username" required></p>
	    
	    <p><label for="password">Password</label>
	    <input type="password" name="password" placeholder="Enter Password" required></p>
	    
	    <p><input type="submit" value="Log In"></p>
	    </form>
	</section>
  </div>
</div>
</body>
</html>