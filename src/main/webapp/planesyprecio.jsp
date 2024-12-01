<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Plan & Enjoy: Registrar Gastos e Ingresos</title>
</head>
<body>
    <%
        // Establish database connection (replace with your credentials)
        String url = "jdbc:mysql://localhost:3306/plan_enjoy_db";
        String user = "root";
        String password = "";
        
        // Retrieve form data
        String concepto = request.getParameter("concepto");
        String monto = request.getParameter("monto");
        String tipo = request.getParameter("tipo");
        
        String tipoEvento = "General"; // Valor por defecto para 'tipo_evento'
        Timestamp fechaCreacion = new Timestamp(System.currentTimeMillis());

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO gastos_ingresos (concepto, monto, tipo, fecha) VALUES (?, ?, ?, ?)")) {

            // Set parameters for the prepared statement
            stmt.setString(1, concepto);
            stmt.setString(2, monto);
            stmt.setString(3, tipo);
            stmt.setTimestamp(4, fechaCreacion);

            // Execute the insert query
            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                out.println("Gasto/Ingreso registrado exitosamente.");
            } else {
                out.println("Error al registrar el gasto/ingreso.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
      response.sendRedirect("planesyprecio.html");
    %>
</body>
</html>