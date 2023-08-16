<%@ page language="java" contentType="text/html"%>

<html>
<head>
<title>Create Account</title>
</head>
<body bgcolor="#07a396">
<div>
<h1> Train System Login (Group 41) </h1>
  <div class="container" style="border:7px groove #ccc">
  <p><b>Sign Up</b></p>
  <section>
	<form name="Sign Up" action="newaccount.jsp" method="post" accept-charset="utf-8">
     <p><b>Enter the following information to create a new account for our system.</b></p>
     
    <p><label for="username">Username: </label>
    <input type="text" placeholder="Username" name="username" required></p>

    <p><label for="password">Password: </label>
    <input type="password" placeholder="Password" name="password" required></p>

    <p><label for="email">Email: </label>
    <input type="email" placeholder="Email" name="email" required></p>
    
    <p><label for="firstname">First Name: </label>
    <input type="text" placeholder="First Name" name="firstname" required></p>
    
    <p><label for="lastname">Last Name: </label>
    <input type="text" placeholder="Last Name" name="lastname" required></p>
    
    <p><label for="telephone">Telephone: </label>
    <input type="text" placeholder="Telephone" name="telephone" required></p>
    
    <p><label for="address">Address: </label>
    <input type="text" placeholder="Address" name="address" required></p>

    <p><label for="city">City</label>
    <input type="text" placeholder="City" name="city" required></p>

    <p><label for="state">State: </label>
    <input type="text" placeholder="State" name="state" required></p>

    <p><label for="zipcode">Zip-Code: </label>
    <input type="text" placeholder="Zip Code" name="zipcode" required></p>
    
    <p><input type="submit" value="Sign Up"></p>
   
    
    </form>
   </section>
   <p>Have an account already? <a href=index.jsp>Log In</a>.<br/></p>
   
	</div>
</div>
</body>
</html>