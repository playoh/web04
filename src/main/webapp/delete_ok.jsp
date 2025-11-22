<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="org.example.ihateweb04.dao.BoardDAO, org.example.ihateweb04.bean.BoardVO" %>

<%
    // POST 요청 처리 (실제 삭제 수행)
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String sid = request.getParameter("seq");
        if (sid != null && !sid.isEmpty()) {
            int id = Integer.parseInt(sid);
            BoardVO vo = new BoardVO();
            vo.setSeq(id);
            BoardDAO boardDAO = new BoardDAO();
            boardDAO.deleteBoard(vo);
        }
        response.sendRedirect("list.jsp");
        return; // POST 처리 후 페이지의 나머지 부분 렌더링을 방지
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>삭제 확인</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        h1 { color: #d9534f; }
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
        .confirm-btn { background-color: #d9534f; color: white; }
        .cancel-btn { background-color: #5bc0de; color: white; }
    </style>
</head>
<body>

<%
    // GET 요청 처리 (삭제 확인 페이지 표시)
    BoardDAO boardDAO = new BoardDAO();
    String sid = request.getParameter("id");
    BoardVO u = null;
    boolean hasError = false;

    if (sid != null && !sid.isEmpty()) {
        try {
            u = boardDAO.getBoard(Integer.parseInt(sid));
            if (u.getTitle() == null) { // getBoard가 유효한 데이터를 찾지 못한 경우
                u = null; // 유효하지 않은 데이터이므로 null 처리
            }
        } catch (NumberFormatException e) {
            hasError = true;
        }
    } else {
        hasError = true;
    }

    if (hasError || u == null) {
%>
    <h1>오류</h1>
    <p>삭제할 게시물을 찾을 수 없거나 잘못된 요청입니다.</p>
    <a href="list.jsp">목록으로 돌아가기</a>
<%
    } else {
%>
    <h1>게시글 삭제 확인</h1>
    <p>아래 게시글을 정말로 삭제하시겠습니까?</p>

    <div class="post-details">
        <p><strong>ID:</strong> <%= u.getSeq() %></p>
        <p><strong>카테고리:</strong> <%= u.getCategory() %></p>
        <p><strong>제목:</strong> <%= u.getTitle() %></p>
        <p><strong>작성자:</strong> <%= u.getWriter() %></p>
    </div>

    <form action="delete_ok.jsp" method="post" style="display: inline;">
        <input type="hidden" name="seq" value="<%= u.getSeq() %>">
        <div class="buttons">
            <input type="submit" value="확인" class="confirm-btn">
            <a href="list.jsp" class="cancel-btn">취소</a>
        </div>
    </form>
<%
    }
%>

</body>
</html>