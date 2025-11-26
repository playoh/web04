<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 25. 11. 22.
  Time: 오후 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="org.example.ihateweb04.dao.BoardDAO, org.example.ihateweb04.bean.BoardVO"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Post</title>
</head>
<body>

<%
    BoardDAO boardDAO = new BoardDAO();
    String id=request.getParameter("id");
    BoardVO u=boardDAO.getBoard(Integer.parseInt(id));
%>

<h1>View Post</h1>
<table border="1" width="500">
    <tr><td><b>Seq:</b></td><td><%=u.getSeq() %></td></tr>
    <tr><td><b>Category:</b></td><td><%=u.getCategory()%></td></tr>
    <tr><td><b>Title:</b></td><td><%= u.getTitle()%></td></tr>
    <tr><td><b>Writer:</b></td><td><%= u.getWriter()%></td></tr>
    <tr><td colspan="2"><%= u.getContent()%></td></tr>
    <% if(u.getPhoto() != null && !u.getPhoto().isEmpty()) { %>
    <tr><td colspan="2"><img src="upload/<%= u.getPhoto() %>" alt="uploaded photo" width="400"></td></tr>
    <% } %>
</table>
<br>
<a href="list.jsp">Go to List</a>
<a href="edit.jsp?id=<%= u.getSeq() %>">Edit</a>
<a href="delete_ok.jsp?id=<%= u.getSeq() %>" onclick="return confirm('Are you sure you want to delete this post?')">Delete</a>

</body>
</html>