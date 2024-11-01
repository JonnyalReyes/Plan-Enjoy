<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/eventos";
    String user = "root";
    String password = "";
    Connection con = null;
    PreparedStatement pstmt = null;
    String eventType = request.getParameter("eventType");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);
        String query = "INSERT INTO eventos (Tipo_even) VALUES (?)";
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, eventType);
        pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    response.sendRedirect("Formulario.html");
%>
