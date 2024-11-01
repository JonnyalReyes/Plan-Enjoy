<%@ page import="java.sql.*" %>
<%
    // Obtener los parámetros del formulario
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Configuración de la base de datos
    String dbURL = "jdbc:mysql://localhost:3306/eventos";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String errorMessage = null;

    try {
        // Conectar a la base de datos
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Consulta para verificar las credenciales
        String sql = "SELECT * FROM usuarios WHERE nombre_us = ? AND contra_us= ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, password);
        rs = stmt.executeQuery();

        if (rs.next()) {
            // Credenciales correctas, redirigir a la página de inicio
            response.sendRedirect("HOME.html");
        } else {
            // Credenciales incorrectas, mostrar mensaje de error
            errorMessage = "Nombre de usuario o contraseña incorrectos.";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("Login.html").forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        errorMessage = "Error en el sistema. Inténtelo de nuevo más tarde.";
        request.setAttribute("errorMessage", errorMessage);
        request.getRequestDispatcher("Login.html").forward(request, response);
    } finally {
        // Cerrar recursos
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
