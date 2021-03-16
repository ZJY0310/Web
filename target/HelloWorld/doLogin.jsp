<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: Z
  Date: 2021/3/16
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    //加载驱动
    Class.forName("com.mysql.cj.jdbc.Driver");
    //获得链接
    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library?serverTimezone=UTC&characterEncoding=utf-8",
            "root", "jc200310");) {
        //获得PreparedStatement
        String sql = "select * from borrow_card where username=?";
        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            //替换占位符
            preparedStatement.setString(1, username);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    if (password.equals(resultSet.getString("password"))) {
                        response.sendRedirect("./main.jsp");
                    } else {
                    %>
                        <jsp:forward page="index.jsp"></jsp:forward>
                    <%
                    }
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

</body>
</html>