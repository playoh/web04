<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.example.ihateweb04.dao.BoardDAO, org.example.ihateweb04.bean.BoardVO"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Post</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .post-table {
            border-collapse: collapse;
            width: 600px;
        }
        .post-table td, .post-table th {
            border: 1px solid #ddd;
            padding: 10px;
        }
        .post-table th {
            background-color: #f2f2f2;
            width: 100px;
            text-align: right;
        }
        .post-content {
            padding: 15px;
            min-height: 150px;
            vertical-align: top;
        }
        .post-image {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
            margin-top: 10px;
        }
        .actions a {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            background-color: #006bb3;
            color: white;
            cursor: pointer;
            text-decoration: none;
            margin-right: 5px;
        }
    </style>
</head>
<body>

<%
    BoardDAO boardDAO = new BoardDAO();
    String id=request.getParameter("id");
    BoardVO u=boardDAO.getBoard(Integer.parseInt(id));
%>

<h1>View Post</h1>
<table class="post-table">
    <tr><th>Seq:</th><td><%=u.getSeq() %></td></tr>
    <tr><th>Category:</th><td><%=u.getCategory()%></td></tr>
    <tr><th>Title:</th><td><%= u.getTitle()%></td></tr>
    <tr><th>Writer:</th><td><%= u.getWriter()%></td></tr>
    <tr><td colspan="2" class="post-content"><%= u.getContent()%></td></tr>
    <% if(u.getPhoto() != null && !u.getPhoto().isEmpty()) { %>
    <tr>
        <td colspan="2">
            <img src="<%= request.getContextPath() %>/webapp/upload/<%= u.getPhoto() %>" alt="uploaded photo" class="post-image">
        </td>
    </tr>
    <% } %>
</table>
<br>
<div class="actions">
    <a href="list.jsp">Go to List</a>
    <a href="edit.jsp?id=<%= u.getSeq() %>">Edit</a>
    <a href="delete_ok.jsp?id=<%= u.getSeq() %>" onclick="return confirm('Are you sure you want to delete this post?')">Delete</a>
</div>

</body>
</html>