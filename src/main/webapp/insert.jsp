<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: zyp
  Date: 18-4-18
  Time: 下午9:02
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
    Statement statement = null;
    final String insertSQL = "INSERT INTO student (name, major_id, sex, hobby, age) VALUES (?,?,?,?,?);";
    final String queryMajorId = "select * from major where name = ?";
    ResultSet rs = null;
    PreparedStatement ptmt = null;
      String name = request.getParameter("name");
      String age = request.getParameter("age");
      String sex = request.getParameter("sex");
      if (sex.equals("1")) {
          sex = "女";
      } else {
          sex = "男";
      }
      String[] hobbies = request.getParameterValues("hobby");
      List<String> hobbyList = new ArrayList<String>(Arrays.asList(hobbies));
      String hobby = "";
      if (hobbyList.contains("game")) {
          hobby += "游戏 ";
      }
      if (hobbyList.contains("sport")) {
          hobby += "体育 ";
      }
      if (hobbyList.contains("music")) {
          hobby += "音乐 ";
      }
      if (hobbyList.contains("travel")) {
          hobby += "旅游 ";
      }
      String college = request.getParameter("college");
      String major = request.getParameter("major");
      System.out.println(college);
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(url, user, password);
        ptmt = connection.prepareCall(queryMajorId);
        ptmt.setString(1,major);
        ptmt.execute();
        rs = ptmt.getResultSet();
        rs.next();
        int majorId = rs.getInt("id");
        ptmt = connection.prepareCall(insertSQL);
        ptmt.setString(1, name);
        ptmt.setInt(2,majorId);
        ptmt.setString(3, sex);
        ptmt.setString(4,hobby);
        ptmt.setString(5,age);
        ptmt.execute();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        rs.close();
        ptmt.close();
        if (connection != null) {
            connection.close();
        }
    }
    response.sendRedirect("/student_info.jsp");
%>
<html>
<head>
    <title></title>
</head>
<body>

</body>
</html>
