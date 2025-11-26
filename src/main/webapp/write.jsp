<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 25. 11. 22.
  Time: 오후 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>

<h1>Add New Post</h1>
<form action="write_ok.jsp" method="post" enctype="multipart/form-data">
    <table>
        <tr><td>Category:</td><td><input type="text" name="category"/></td></tr>
        <tr><td>Title:</td><td><input type="text" name="title"/></td></tr>
        <tr><td>Writer:</td><td><input type="text" name="writer"/></td></tr>
        <tr><td>Content:</td><td><textarea cols="50" rows="5" name="content"></textarea></td></tr>
        <tr><td>Photo:</td><td><input type="file" name="photo"/></td></tr>
        <tr><td><a href="list.jsp">View All Records</a></td><td align="right"><input type="submit" value="Add Post"/></td></tr>
    </table>
</form>

</body>
</html>