<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: zyp
  Date: 18-4-19
  Time: 下午2:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    response.setCharacterEncoding("utf-8");
    final String url = "jdbc:mysql://localhost:3306/issf?useUnicode=true&characterEncoding=utf-8";
    final String user = "root";
    final String password = "zhengyupeng0602";
    Connection connection = null;
    PreparedStatement ps = null;
    final String deleteSQL = "delete from student where id = ?";
    int id = Integer.parseInt(request.getParameter("id"));
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(url, user, password);
        ps = connection.prepareCall(deleteSQL);
        ps.setInt(1,id);
        ps.execute();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    }finally {
        ps.close();
        connection.close();
    }
    response.sendRedirect("/student_info.jsp");
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
