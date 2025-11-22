<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="org.example.ihateweb04.dao.BoardDAO, org.example.ihateweb04.bean.BoardVO" %>

<%
    request.setCharacterEncoding("UTF-8");

    // "confirm" 액션이 있을 경우에만 실제 DB에 저장
    if ("confirm".equals(request.getParameter("action"))) {
        BoardVO vo = new BoardVO();
        vo.setCategory(request.getParameter("category"));
        vo.setTitle(request.getParameter("title"));
        vo.setWriter(request.getParameter("writer"));
        vo.setContent(request.getParameter("content"));

        BoardDAO dao = new BoardDAO();
        dao.insertBoard(vo);

        response.sendRedirect("list.jsp");
        return;
    }

    // 처음 POST 요청 시 (write.jsp에서 넘어왔을 때) 확인 페이지 표시
    String category = request.getParameter("category");
    String title    = request.getParameter("title");
    String writer   = request.getParameter("writer");
    String content  = request.getParameter("content");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>작성 확인</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        h1 { color: #337ab7; }
        .post-details { border: 1px solid #ccc; padding: 15px; margin-bottom: 20px; background-color: #f9f9f9; }
        .post-details p { margin: 5px 0; }
        .buttons a, .buttons input {
            display: inline-block;
            padding: 10px 15px;
            margin-right: 10px;
            text-decoration: none;
            font-size: 14px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
        }
        .confirm-btn { background-color: #5cb85c; color: white; }
        .cancel-btn { background-color: #f0ad4e; color: white; }
    </style>
</head>
<body>
    <h1>게시글 작성 확인</h1>
    <p>아래 내용으로 게시글을 작성하시겠습니까?</p>

    <div class="post-details">
        <p><strong>카테고리:</strong> <%= category %></p>
        <p><strong>제목:</strong> <%= title %></p>
        <p><strong>작성자:</strong> <%= writer %></p>
        <p><strong>내용:</strong></p>
        <div style="white-space: pre-wrap; padding: 10px; background: #fff; border: 1px solid #ddd;"><%= content %></div>
    </div>

    <form action="write_ok.jsp" method="post">
        <!-- 사용자가 입력한 데이터를 hidden 필드로 유지 -->
        <input type="hidden" name="category" value="<%= category %>">
        <input type="hidden" name="title" value="<%= title %>">
        <input type="hidden" name="writer" value="<%= writer %>">
        <input type="hidden" name="content" value="<%= content %>">
        <!-- 실제 저장을 위한 액션 파라미터 -->
        <input type="hidden" name="action" value="confirm">

        <div class="buttons">
            <input type="submit" value="확인" class="confirm-btn">
            <a href="list.jsp" class="cancel-btn">취소</a>
        </div>
    </form>
</body>
</html>
