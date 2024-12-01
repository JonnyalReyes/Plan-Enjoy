<%@ page import="java.sql.*" %>
<%
    // Obtener los datos del formulario
    String nombreCompleto = request.getParameter("nombreCompleto");
    String correoElectronico = request.getParameter("correoElectronico");
    String telefonoStr = request.getParameter("telefono");
    String direccion = request.getParameter("direccion");
    String nombreEvento = request.getParameter("nombreEvento");
    String descripcionEvento = request.getParameter("descripcionEvento");
    String cantidadInvitadosStr = request.getParameter("cantidadInvitados");
    String ubicacionEvento = request.getParameter("ubicacionEvento");
    
    // Agregar valores por defecto para columnas obligatorias
    String tipoEvento = "General"; // Valor por defecto para 'tipo_evento'
    Timestamp fechaCreacion = new Timestamp(System.currentTimeMillis()); // Fecha y hora actuales

    // Convertir teléfono y cantidad de invitados a enteros
    int telefono = Integer.parseInt(telefonoStr);
    int cantidadInvitados = Integer.parseInt(cantidadInvitadosStr);

    // Mensaje de respuesta
    String message = "";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Cargar el controlador de MySQL
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establecer la conexión a la base de datos
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/plan_enjoy_db", "root", "");

        // Consulta SQL para insertar los datos en la tabla eventos
       String insertQuery = "INSERT INTO eventos (nombre_evento, tipo_evento, nombre_anfitrion, correo_anfitrion, telefono_anfitrion, direccion_anfitrion, descripcion_evento, cantidad_invitados, ubicacion_evento, fecha_creacion) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
       	pstmt = conn.prepareStatement(insertQuery);
        pstmt = conn.prepareStatement(insertQuery);
        pstmt.setString(1, nombreCompleto);
        pstmt.setString(2, tipoEvento);
        pstmt.setString(3, correoElectronico);
        pstmt.setInt(4, telefono);
        pstmt.setString(5, direccion);
        pstmt.setString(6, nombreEvento);
        pstmt.setString(7, descripcionEvento);
        pstmt.setInt(8, cantidadInvitados);
        pstmt.setString(9, ubicacionEvento);
        pstmt.setTimestamp(10, fechaCreacion);

        // Ejecutar la consulta
        int rowsAffected = pstmt.executeUpdate();

        // Mostrar mensaje de éxito o error
        if (rowsAffected > 0) {
            message = "Formulario enviado y evento creado con éxito.";
        } else {
            message = "No se pudo crear el evento.";
        }

    } catch (ClassNotFoundException | SQLException e) {
        message = "Error al procesar el formulario: " + e.getMessage();
        e.printStackTrace(); // Imprimir la excepción para obtener más detalles
    } finally {
        // Cerrar la conexión y el PreparedStatement en un bloque finally
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Mostrar el mensaje de respuesta
    out.println("<p>" + message + "</p>");

    // Redirigir a la página Mis eventos.html
    response.sendRedirect("Formulario.html");
%>