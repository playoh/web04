<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 25. 11. 22.
  Time: 오후 9:39
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="org.example.ihateweb04.dao.BoardDAO,
                 org.example.ihateweb04.bean.BoardVO,
                 java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
    <style>
        #list {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }
        #list td, #list th {
            border: 1px solid #ddd;
            padding: 8px;
            text-align:center;
        }
        #list tr:nth-child(even){background-color: #f2f2f2;}
        #list tr:hover {background-color: #ddd;}
        #list th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: center;
            background-color: #006bb3;
            color: white;
        }
    </style>
    <script>
        // No longer needed
    </script>
</head>
<body>
<h1>자유게시판</h1>

<%
    // DB에서 게시글 목록 가져오기
    BoardDAO boardDAO = new BoardDAO();
    List<BoardVO> list = boardDAO.getBoardList();
%>

<table id="list" width="90%">
    <tr>
        <th>Id</th>
        <th>Category</th>
        <th>Title</th>
        <th>File</th>
        <th>Writer</th>
        <th>Content</th>
        <th>Regdate</th>
        <th>Edit</th>
        <th>Delete</th>
    </tr>

    <%
        if (list != null) {
            for (BoardVO u : list) {
    %>
    <tr>
        <td><%= u.getSeq() %></td>
        <td><%= u.getCategory() %></td>
        <td><a href="view.jsp?id=<%= u.getSeq() %>"><%= u.getTitle() %></a></td>
        <td><% if(u.getPhoto() != null && !u.getPhoto().isEmpty()) { %>📎<% } %></td>
        <td><%= u.getWriter() %></td>
        <td><%= u.getContent() %></td>
        <td><%= u.getRegdate() %></td>
        <td><a href="edit.jsp?id=<%= u.getSeq() %>">Edit</a></td>
        <td><a href="delete_ok.jsp?id=<%= u.getSeq() %>">Delete</a></td>
    </tr>
    <%
            }
        }
    %>
</table>

<br/>
<a href="write.jsp">Add New Post</a>

</body>
</html>
