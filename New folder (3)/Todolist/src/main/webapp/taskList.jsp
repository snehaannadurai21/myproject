<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
<meta charset="ISO-8859-1">
<title>Todo</title>
<link rel="stylesheet" href ="styles.css">
</head>
  
  <body>
          <h1>Todo</h1>
          
    <form action="AddServlet" method="post">
    <label for="task"> Add Task:</label>
    <input type="text" name="task"required autocomplete ="off">
    <button type="submit" >Add</button>

</form>
<table>
   <thead>
   <tr>
   <th>id</th>
    <th>Tasks</th>
     <th>Action</th>
   
   </tr>
   </thead>
   <tbody>
   <%
   try{
	   Class.forName("com.mysql.jdbc.Driver");
	   Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tododb", "root", "");
	   if(request.getMethod().equals("Post"))
	   {
	   String a=request.getParameter("task");
	   if(a!=null && !a.isEmpty())
	   {
	   String insert ="insert into task (tasks) values(?)";
	   try(PreparedStatement pst=con.prepareStatement(insert))
	   {
		   pst.setString(1, a);
		   pst.executeUpdate();
	   }
	   }
	   }
	   String select="select * from task";
	   try(Statement smt=con.createStatement();
			   ResultSet rs=smt.executeQuery(select))
	   {
		   while(rs.next())
		   {
			   int id=rs.getInt("id");
			   String tasks=rs.getString("tasks");
		%>
			   <tr>
			   <td><%= id %></td>
			   <td><%=  tasks %></td>
			   <td>
			   <form action="DeleteServlet" method="post">
			   <input type="hidden" name="id" value= "<%=id %>">
			   <button type="submit">Delete</button>
			   </form>
			   </td>
			
			   </tr>
			   <% 
		   }
	   }  
	   
	   
	  con.close();
   }catch(Exception e)
   {
	   e.printStackTrace();
   }
   
   %>

   </tbody>
   
</table>

</body>
</html>