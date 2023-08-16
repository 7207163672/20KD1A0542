<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, com.mysql.jdbc.exceptions.jdbc4.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Alerts</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//String trainid="100";
		
		//status.equals("2") && (alerted.equals("0") || alerted==null)
	
			//if it is delayed and no alert has been added yet for it
			
			//trainid is the variable (type String) name for the id of the train schedule that is being edited
			//Add this right AFTER the edit is made to the schedule
			Statement stmtEdit = con.createStatement();
			String editQuery = "select reservation_number,trainid,customer_username,cancelled, alerted from Reservation where customer_username='"+session.getAttribute("username")+"'";
			ResultSet editResult = stmtEdit.executeQuery(editQuery);

			while(editResult.next()){
			//compare the trainID to the tuple
			String tidEdit=editResult.getString("trainid");
			String usernameEdit=editResult.getString("customer_username");
			String resIdEdit=editResult.getString("reservation_number");
			String status=editResult.getString("cancelled");
			String alerted=editResult.getString("alerted");
			
			
			if(!(alerted.equals("0") || alerted==null) || status.equals("0"))
				continue;

			String messageEdit="";
			//if they are the same then add to the message table
			if(status.equals("2"))
				 messageEdit="Alert for Reservation "+resIdEdit+": Train schedule for Train "+tidEdit+" has been delayed.";
			else if(status.equals("1"))
				messageEdit="Alert for Reservation "+resIdEdit+": Reservation cancelled or train schedule for Train "+tidEdit+" has been deleted.";
			//get the counter for the question id
			String counterQueryEdit="select question_number from Counters";	
			Statement stmtEditCounter = con.createStatement();			
			ResultSet counterResultEdit = stmtEditCounter.executeQuery(counterQueryEdit);
			counterResultEdit.next();
			int questionNumberEdit=counterResultEdit.getInt("question_number")+1;

			//send the alert to the person
			String insertEdit = "insert into Messages(question_number,username,ssn,question,reply)"
							+ "values (?, ?, ?, ?, ?)";
			PreparedStatement psEdit = con.prepareStatement(insertEdit);

			psEdit.setInt(1, questionNumberEdit);
			psEdit.setString(2, usernameEdit);
			psEdit.setInt(3, 0);  //SSN FOR ALERT EMPLOYEE
			psEdit.setString(4, messageEdit);
			psEdit.setString(5, "");  //EMPTY REPLY

			int countEdit = psEdit.executeUpdate();
					
			if(countEdit <= 0){
				out.print("insert failed");
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Error when sending alert message.');");
				out.println("window.location.href = \"loggedin.jsp\";");
				out.println("</script>");
			}

			//now update the counter for question number
					
			//Create a SQL statement
			Statement stmtEditCounterUpdate = con.createStatement();
			String updateCounterQueryEdit="update Counters set question_number="+questionNumberEdit;
			int executedEdit = stmtEditCounterUpdate.executeUpdate(updateCounterQueryEdit);
						
			if(executedEdit <= 0 ) {
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Error when sending alert message.');");
				out.println("window.location.href = \"loggedin.jsp\";");
				out.println("</script>");
			}
			
			//update alerted
			Statement stmtAlert = con.createStatement();
			String alertQuery ="update Reservation r set alerted=1 where reservation_number= "+resIdEdit;
			int executed = stmtAlert.executeUpdate(alertQuery);
			
			if(executed <=0 ) {
				response.setContentType("text/html");
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Error In Sending Alerts.');");
				out.println("window.location.href = \"loggedin.jsp\";");
				out.println("</script>");
			}
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