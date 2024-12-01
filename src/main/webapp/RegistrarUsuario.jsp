<%@ page import="java.sql.*" %>
<%
    // 1. Recibir los datos del formulario
    String nombreUsuario = request.getParameter("username");
    String correoElectronico = request.getParameter("email");
    String contrasena = request.getParameter("password");

    // 2. Conexión a la base de datos
    String url = "jdbc:mysql://localhost:3306/plan_enjoy_db";
    String usuarioDB = "root";
    String contrasenaDB = ""; 

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(url, usuarioDB, contrasenaDB);

        // 3. Insertar los datos en la tabla "usuarios"
        String consulta = "INSERT INTO usuarios (nombre_usuario, correo_electronico, contraseña) VALUES (?, ?, ?)";
        PreparedStatement statement = conexion.prepareStatement(consulta);
        statement.setString(1, nombreUsuario);
        statement.setString(2, correoElectronico);
        statement.setString(3, contrasena);
        int filasAfectadas = statement.executeUpdate();

        if (filasAfectadas > 0) {
            // Registro exitoso
            response.sendRedirect("Login.html"); // Redirigir a la página de login
        } else {
            // Error al registrar
            out.println("Error al registrar el usuario.");
        }

        statement.close();
        conexion.close();

    } catch (ClassNotFoundException | SQLException e) {
        out.println("Error al conectar a la base de datos: " + e.getMessage());
    }
%>