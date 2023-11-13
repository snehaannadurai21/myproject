package todo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String id = request.getParameter("id");

	        try {
	            
	          
	        	Class.forName("com.mysql.jdbc.Driver");
	            Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/tododb", "root", "");
                 String sql = "delete from task where id=?";
	            PreparedStatement pst = con.prepareStatement(sql);
	            pst.setInt(1, Integer.parseInt(id));
	            pst.executeUpdate();

	          
	            pst.close();
	            con.close();

	         
	            response.sendRedirect("taskList.jsp");
	        } catch (Exception e) {
	            e.printStackTrace();
	            
	        }
	    }
	}

   
