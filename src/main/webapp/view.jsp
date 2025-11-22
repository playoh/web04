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
    <title>view Form</title>
</head>
<body>

<%
    BoardDAO boardDAO = new BoardDAO();
    String id=request.getParameter("id");
    BoardVO u=boardDAO.getBoard(Integer.parseInt(id));
%>

<h1>View Form</h1>
<input type="hidden" name="seq" value="<%=u.getSeq() %>"/>
<table>
    <tr><td>Category: <%=u.getCategory()%></td></tr>
    <tr><td>Title: <%= u.getTitle()%></td></tr>
    <tr><td>Writer: <%= u.getWriter()%></td></tr>
    <tr><td>Content: <%= u.getContent()%></td></tr>
</table>

</body>
</html>