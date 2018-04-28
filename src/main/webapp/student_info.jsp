<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Dictionary" %>
<%@ page import="java.util.Hashtable" %><%--
  Created by IntelliJ IDEA.
  User: zyp
  Date: 18-4-18
  Time: 下午7:26
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
    final String queryStudentInfoSQL = "select * from student_info_view";
    final String queryCollegeSQL = "select * from college";
    final String queryMajorSQL = "select * from major";
    ResultSet rs = null;
    ArrayList<String> collegeList = new ArrayList<String>();
    ArrayList<String> majorList = new ArrayList<String>();
    ArrayList<Dictionary<String, String>> studentInfoList = new ArrayList<Dictionary<String, String>>();
    Dictionary<String,String> info = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(url, user, password);
        statement = connection.createStatement();
        rs = statement.executeQuery(queryStudentInfoSQL);
        while (rs.next()) {
            info = new Hashtable<String, String>();
            info.put("id", rs.getInt("id") + "");
            info.put("name", rs.getString("name"));
            info.put("major", rs.getString("major"));
            info.put("college", rs.getString("college"));
            info.put("sex", rs.getString("sex"));
            info.put("hobby", rs.getString("hobby"));
            info.put("age", rs.getInt("age") + "");
            studentInfoList.add(info);
        }
        rs = statement.executeQuery(queryCollegeSQL);
        while (rs.next()) {
            collegeList.add(rs.getString("name"));
        }
        rs = statement.executeQuery(queryMajorSQL);
        while (rs.next()) {
            majorList.add(rs.getString("name"));
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (statement != null) {
            statement.close();
        }
        if (connection != null) {
            connection.close();
        }
        if (statement != null) {
            statement.close();
        }
    }

%>
<html>
<head>
    <title>Student Info</title>
</head>
<body>
    <div>
        <form action="insert.jsp" method="post">
            <div>
                <label for="name">姓名：</label>
                <input type="text" name="name" id="name">
            </div>
            <div>
                <label>年龄</label>
                <input type="text" name="age" id="age">
            </div>
            <div>
                <label>性别</label>
                <label>
                 <input type="radio" name="sex" id="sex_nan" value="0">男
                </label>
                <label>
                    <input type="radio" name="sex" id="sex_nv" value="1">女
                </label>
            </div>
            <div>
                <label>爱好</label>
                <label>
                    <input type="checkbox" name="hobby" id="hobby_game" value="game">游戏
                </label>
                <label>
                    <input type="checkbox" name="hobby" id="hobby_sport" value="sport">体育
                </label>
                <label>
                    <input type="checkbox" name="hobby" id="hobby_music" value="music">音乐
                </label>
                <label>
                    <input type="checkbox" name="hobby" id="hobby_travel" value="travel">旅游
                </label>
            </div>
            <div>
                <label>学院</label>
                <select id="college" name="college">
                    <%
                        for (String name : collegeList) {
                    %>
                    <option value="<%=name%>"><%=name%></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div>
                <label>专业</label>
                <select id="major" name="major">
                    <%
                        for (String name : majorList) {
                    %>
                    <option value="<%=name%>"><%=name%></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div>
                <input type="submit">xxxxx
            </div>
        </form>
    </div>
    <div>
        <table>
            <thead>
            <tr>
                <th>姓名</th>
                <th>年龄</th>
                <th>性别</th>
                <th>爱好</th>
                <th>学院</th>
                <th>专业</th>
                <th>修改与删除</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Dictionary<String, String> student : studentInfoList) {
            %>
            <tr>
                <td><%=student.get("name")%></td>
                <td><%=student.get("age")%></td>
                <td><%=student.get("sex")%></td>
                <td><%=student.get("hobby")%></td>
                <td><%=student.get("college")%></td>
                <td><%=student.get("major")%></td>
                <td>
                    <a href="delete.jsp?id=<%=student.get("id")%>">删除</a>
                    <a href="update.jsp?id=<%=student.get("id")%>">修改</a>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</body>
</html>
