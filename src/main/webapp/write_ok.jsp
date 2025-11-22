<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="org.example.ihateweb04.dao.BoardDAO,
                 org.example.ihateweb04.bean.BoardVO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Write OK</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String category = request.getParameter("category");
    String title    = request.getParameter("title");
    String writer   = request.getParameter("writer");
    String content  = request.getParameter("content");

    BoardVO vo = new BoardVO();
    vo.setCategory(category);
    vo.setTitle(title);
    vo.setWriter(writer);
    vo.setContent(content);

    BoardDAO dao = new BoardDAO();
    int result = dao.insertBoard(vo);   // ★ 여기서 INSERT 수행
%>

<h1>Write OK</h1>

<%
    if (result == 1) {
%>
<p>게시글이 성공적으로 등록되었습니다.</p>
<a href="list.jsp">목록으로 돌아가기</a>
<%
} else {
%>
<p>게시글 등록에 실패했습니다.</p>
<a href="write.jsp">다시 작성하기</a>
<%
    }
%>

</body>
</html>
