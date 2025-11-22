<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        .button-container {
            margin-top: 20px;
        }
        .button-container a {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
            font-size: 16px;
            text-decoration: none;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .button-container a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <h1>게시판 웹 애플리케이션</h1>
    <div class="button-container">
        <a href="list.jsp">게시글 목록 보기 (list.jsp)</a>
        <a href="write.jsp">새 게시글 작성 (write.jsp)</a>
        <a href="view.jsp?id=5">게시글 상세 보기 (view.jsp)</a>
        <a href="edit.jsp?id=5">게시글 수정 (edit.jsp)</a>
        <a href="delete_ok.jsp?id=5">게시글 삭제 처리 (delete_ok.jsp)</a>
        <a href="write_ok.jsp">게시글 작성 처리 (write_ok.jsp)</a>
        <a href="edit_ok.jsp">게시글 수정 처리 (edit_ok.jsp)</a>
    </div>

</body>
</html>