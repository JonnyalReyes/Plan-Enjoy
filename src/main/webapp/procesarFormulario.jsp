<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Procesar Formulario</title>
    <style>
        /* Agrega estilos aquí si es necesario */
    </style>
</head>
<body>
    <%
        String nombreCompleto = request.getParameter("nombreCompleto");
        String correoElectronico = request.getParameter("correoElectronico");
        String telefonoStr = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String nombreEvento = request.getParameter("nombreEvento");
        String descripcionEvento = request.getParameter("descripcionEvento");
        String cantidadInvitadosStr = request.getParameter("cantidadInvitados");
        String ubicacionEvento = request.getParameter("ubicacionEvento");

        int telefono = 0;
        int cantidadInvitados = 0;

        boolean hasError = false;
        String message = "";

        // Validar que todos los campos estén presentes
        if (nombreCompleto == null || nombreCompleto.isEmpty() ||
            correoElectronico == null || correoElectronico.isEmpty() ||
            telefonoStr == null || telefonoStr.isEmpty() ||
            direccion == null || direccion.isEmpty() ||
            nombreEvento == null || nombreEvento.isEmpty() ||
            descripcionEvento == null || descripcionEvento.isEmpty() ||
            cantidadInvitadosStr == null || cantidadInvitadosStr.isEmpty() ||
            ubicacionEvento == null || ubicacionEvento.isEmpty()) {

            hasError = true;
            message = "Por favor, rellene todos los campos.";
        }

        try {
            telefono = Integer.parseInt(telefonoStr);
            cantidadInvitados = Integer.parseInt(cantidadInvitadosStr);
        } catch (NumberFormatException e) {
            hasError = true;
            message = "Teléfono y cantidad de invitados deben ser números enteros.";
        }

        if (!hasError) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eventos", "root", "");
                
                // Actualizar la última fila creada
                String updateQuery = "UPDATE eventos SET Nombre_anf=?, Correo_anf=?, Telefono_anf=?, Direccion_anf=?, Nombre_even=?, DescripcionEven=?, Cantidad_inv=?, Ubicacion_even=? ORDER BY numero_even DESC LIMIT 1";
                pstmt = conn.prepareStatement(updateQuery);
                pstmt.setString(1, nombreCompleto);
                pstmt.setString(2, correoElectronico);
                pstmt.setInt(3, telefono);
                pstmt.setString(4, direccion);
                pstmt.setString(5, nombreEvento);
                pstmt.setString(6, descripcionEvento);
                pstmt.setInt(7, cantidadInvitados);
                pstmt.setString(8, ubicacionEvento);
                
                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    message = "Formulario enviado y datos actualizados con éxito.";
                } else {
                    message = "No se pudo actualizar el evento.";
                }

            } catch (Exception e) {
                message = "Error al procesar el formulario: " + e.getMessage();
            } finally {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        }
    %>
    <p><%= message %></p>
    <script>
        setTimeout(function() {
            window.location.href = "Mis eventos.html";
        }, 3000); // Redirige después de 3 segundos
    </script>
</body>
</html>
