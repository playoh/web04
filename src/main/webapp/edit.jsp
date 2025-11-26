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
    <title>Edit Form</title>
</head>
<body>

<%
    BoardDAO boardDAO = new BoardDAO();
    String id=request.getParameter("id");
    BoardVO u=boardDAO.getBoard(Integer.parseInt(id));
%>

<h1>Edit Form</h1>
<form action="edit_ok.jsp" method="post" enctype="multipart/form-data">
    <input type="hidden" name="seq" value="<%=u.getSeq() %>"/>
    <input type="hidden" name="old_photo" value="<%=u.getPhoto() != null ? u.getPhoto() : "" %>"/>
    <table>
        <tr><td>Category:</td><td><input type="text" name="category" value="<%=u.getCategory()%>"> </td></tr>
        <tr><td>Title:</td><td><input type="text" name="title" value="<%= u.getTitle()%>"/></td></tr>
        <tr><td>Writer:</td><td><input type="text" name="writer" value="<%= u.getWriter()%>" /></td></tr>
        <tr><td>Content:</td><td><textarea cols="50" rows="5" name="content"><%= u.getContent()%></textarea></td></tr>
        <tr><td>Photo:</td><td><input type="file" name="photo" />
        <% if(u.getPhoto() != null && !u.getPhoto().equals("")){ %>
        <br>Current file: <img src="${pageContext.request.contextPath}/upload/<%=u.getPhoto()%>" width="100">
        <%}%>
        </td></tr>
        <tr><td colspan="2"><input type="submit" value="Edit Post"/>
            <input type="button" value="Cancel" onclick="history.back()"/></td></tr>
    </table>
</form>

</body>
</html>