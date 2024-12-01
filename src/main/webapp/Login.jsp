<%@ page import="java.sql.*" %>
<%
    String nombreUsuario = request.getParameter("username");
    String contrasena = request.getParameter("password");

    String url = "jdbc:mysql://localhost:3306/plan_enjoy_db";
    String usuarioDB = "root";
    String contrasenaDB = ""; 

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(url, usuarioDB, contrasenaDB);

        String consulta = "SELECT * FROM usuarios WHERE nombre_usuario = ? AND contrase�a = ?";
        PreparedStatement statement = conexion.prepareStatement(consulta);
        statement.setString(1, nombreUsuario);
        statement.setString(2, contrasena);
        ResultSet resultado = statement.executeQuery();

        if (resultado.next()) {
            // Credenciales correctas
            // �Aqu� debes agregar la redirecci�n!
            // ... dentro del bloque if de Login.jsp ...

			// Guardar los datos del usuario en la sesi�n
			session.setAttribute("nombreUsuario", nombreUsuario);
			session.setAttribute("correoElectronico", resultado.getString("correo_electronico")); 

            response.sendRedirect("HOME.html"); // Redirigir a la p�gina principal
        } else {
            // Credenciales incorrectas
            String mensajeError = "Nombre de usuario o contrase�a incorrectos.";
            request.setAttribute("errorMessage", mensajeError);
            request.getRequestDispatcher("Login.html").forward(request, response);
        }

        resultado.close();
        statement.close();
        conexion.close();

    } catch (ClassNotFoundException | SQLException e) {
        out.println("Error al conectar a la base de datos: " + e.getMessage());
    }
%>