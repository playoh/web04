<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.ihateweb04.dao.BoardDAO, org.example.ihateweb04.bean.BoardVO, java.util.List, java.net.URLDecoder" %>

<%
    request.setCharacterEncoding("UTF-8");
    // 파라미터 받기
    String category = request.getParameter("category");
    String searchCondition = request.getParameter("searchCondition");
    String keyword = request.getParameter("keyword");

    // null 처리
    if (category == null) category = "all";
    if (searchCondition == null) searchCondition = "title";
    if (keyword == null) keyword = "";

    // DB에서 데이터 가져오기
    BoardDAO boardDAO = new BoardDAO();
    List<String> categories = boardDAO.getCategories();
    int totalCount = boardDAO.getBoardCount(category, searchCondition, keyword);
    List<BoardVO> list = boardDAO.getBoardList(category, searchCondition, keyword);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
    <style>
        body { font-family: Arial, sans-serif; }
        #list {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }
        #list td, #list th {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        #list tr:nth-child(even) { background-color: #f2f2f2; }
        #list tr:hover { background-color: #ddd; }
        #list th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: center;
            background-color: #006bb3;
            color: white;
        }
        .search-box {
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .search-box select, .search-box input[type="text"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .search-box input[type="submit"], .new-post-btn {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            background-color: #006bb3;
            color: white;
            cursor: pointer;
            text-decoration: none; /* for link */
        }
        .info-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<h1>자유게시판</h1>

<!-- 검색 및 필터링 폼 -->
<form method="get" action="list.jsp" class="search-box">
    <span>카테고리:</span>
    <select name="category" onchange="this.form.submit()">
        <option value="all" <%= "all".equals(category) ? "selected" : "" %>>전체</option>
        <% for (String cat : categories) { %>
        <option value="<%= cat %>" <%= cat.equals(category) ? "selected" : "" %>><%= cat %></option>
        <% } %>
    </select>
    <select name="searchCondition">
        <option value="title" <%= "title".equals(searchCondition) ? "selected" : "" %>>제목</option>
        <option value="writer" <%= "writer".equals(searchCondition) ? "selected" : "" %>>작성자</option>
    </select>
    <input type="text" name="keyword" value="<%= keyword %>" placeholder="검색어 입력">
    <input type="submit" value="검색">
</form>

<div class="info-bar">
    <span>Total Posts: <%= totalCount %></span>
    <a href="write.jsp" class="new-post-btn">Add New Post</a>
</div>

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
        if (list != null && !list.isEmpty()) {
            for (BoardVO u : list) {
    %>
    <tr>
        <td><%= u.getSeq() %></td>
        <td><%= u.getCategory() %></td>
        <td><a href="view.jsp?id=<%= u.getSeq() %>"><%= u.getTitle() %></a></td>
        <td><% if(u.getPhoto() != null && !u.getPhoto().isEmpty()) { %><img src="<%= request.getContextPath() %>/upload/<%= u.getPhoto() %>" alt="thumbnail" style="max-width:60px; max-height:60px;"><% } %></td>
        <td><%= u.getWriter() %></td>
        <td><%= u.getContent() %></td>
        <td><%= u.getRegdate() %></td>
        <td><a href="edit.jsp?id=<%= u.getSeq() %>">Edit</a></td>
        <td><a href="delete_ok.jsp?id=<%= u.getSeq() %>" onclick="return confirm('정말로 삭제하시겠습니까?');">Delete</a></td>
    </tr>
    <%
            }
        } else {
    %>
    <tr>
        <td colspan="9">게시물이 없습니다.</td>
    </tr>
    <%
        }
    %>
</table>
<br/>
</body>
</html>
