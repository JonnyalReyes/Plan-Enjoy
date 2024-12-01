<%@ page import="java.sql.*" %>
<%
    if ("cancel".equals(request.getParameter("action"))) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/plan_enjoy_db", "root", "");
            // Aquí deberías tener una manera de identificar la fila específica a borrar, por ejemplo, usando una sesión o algún identificador único
            String query = "DELETE FROM eventos ORDER BY numero_even DESC LIMIT 1";
            PreparedStatement ps = con.prepareStatement(query);
            ps.executeUpdate();
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
%>
