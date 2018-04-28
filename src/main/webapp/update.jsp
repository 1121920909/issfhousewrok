<%@ page import="java.util.Dictionary" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %><%--
  Created by IntelliJ IDEA.
  User: zyp
  Date: 18-4-19
  Time: 下午2:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    response.setCharacterEncoding("utf-8");
    final String url = "jdbc:mysql://localhost:3306/issf?useUnicode=true&characterEncoding=utf-8";
    final String user = "root";
    final String password = "zhengyupeng0602";
    final String querySQL = "select * from student_info_view where id = ?";
    final String queryCollegeSQL = "select name from college";
    final String queryMajorSQL = "select name from major";
    Connection connection = null;
    PreparedStatement ps = null;
    Statement statement = null;
    ArrayList<String> collegeList = new ArrayList<String>();
    ArrayList<String> majorList = new ArrayList<String>();
    int id = Integer.parseInt(request.getParameter("id"));
    ResultSet rs = null;
    Dictionary<String, String> student = new Hashtable<String, String>();
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(url, user, password);
        ps = connection.prepareCall(querySQL);
        ps.setInt(1, id);
        ps.execute();
        rs = ps.getResultSet();
        rs.next();
            student.put("id", rs.getInt("id") + "");
            student.put("name", rs.getString("name"));
            student.put("age", rs.getString("age"));
            student.put("sex", rs.getString("sex"));
            student.put("college", rs.getString("college"));
            student.put("hobby", rs.getString("hobby"));
            student.put("major", rs.getString("major"));
            statement = connection.createStatement();
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
    }finally {
        if (rs != null) {
            rs.close();
        }
        if (statement != null) {
            statement.close();
        }
        if (ps != null) {
            ps.close();
        }
        if (connection != null) {
            connection.close();
        }
    }
%>
<html>
<head>
    <title>update student info</title>
</head>
<body>
<div>
    <form action="updateInfo.jsp" method="post">
        <div>
            <input id="id" name="id" value="<%=student.get("id")%>" hidden="hidden">
            <label for="name">姓名：</label>
            <input type="text" name="name" id="name" value="<%=student.get("name")%>">
        </div>
        <div>
            <label>年龄</label>
            <input type="text" name="age" id="age" value="<%=student.get("age")%>">
        </div>
        <div>
            <label>性别</label>
            <label>
                <input type="radio" name="sex" id="sex_nan" value="0" <%if (student.get("sex").equals("男")){%> checked <%}%>>男
            </label>
            <label>
                <input type="radio" name="sex" id="sex_nv" value="1"<% if (student.get("sex").equals("女")){%> checked <%}%>>女
            </label>
        </div>
        <div>
            <label>爱好</label>
            <%
                String hobby = student.get("hobby");
                String[] temp = hobby.split(" ");
                ArrayList hobbies = new ArrayList(Arrays.asList(temp));
            %>
            <label>
                <input type="checkbox" name="hobby" id="hobby_game" value="game" <%if (hobbies.contains("游戏")){%> checked <%}%> >游戏
            </label>
            <label>
                <input type="checkbox" name="hobby" id="hobby_sport" value="sport" <%if (hobbies.contains("体育")){%> checked <%}%>>体育
            </label>
            <label>
                <input type="checkbox" name="hobby" id="hobby_music" value="music" <%if (hobbies.contains("音乐")){%> checked <%}%>>音乐
            </label>
            <label>
                <input type="checkbox" name="hobby" id="hobby_travel" value="travel" <%if (hobbies.contains("旅游")){%> checked <%}%>>旅游
            </label>
        </div>
        <div>
            <label>学院</label>
            <select id="college" name="college">
                <%
                    for (String name : collegeList) {
                %>
                <option value="<%=name%>"
                        <%if (name.equals(student.get("college"))){ %>
                            selected
                        <%}%>
                >
                    <%=name%>
                </option>
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
                <option value="<%=name%>"
                        <%if (name.equals(student.get("major"))){ %>
                        selected
                        <%}%>
                >
                    <%=name%>
                </option>
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
</body>
</html>
