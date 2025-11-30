<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.example.ihateweb04.bean.BoardVO" %>
<%@ page import="org.example.ihateweb04.dao.BoardDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");

    String action = "";
    String new_photo_filename_from_review = "";

    BoardVO vo = new BoardVO();
    BoardDAO dao = new BoardDAO();
    String uploadPath = application.getRealPath("upload");
    String newFilename = null;
    String old_photo = "";

    if (ServletFileUpload.isMultipartContent(request)) {
        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String value = item.getString("UTF-8");
                    switch (fieldName) {
                        case "action": action = value; break;
                        case "seq": vo.setSeq(Integer.parseInt(value)); break;
                        case "category": vo.setCategory(value); break;
                        case "title": vo.setTitle(value); break;
                        case "writer": vo.setWriter(value); break;
                        case "content": vo.setContent(value); break;
                        case "old_photo": old_photo = value; vo.setPhoto(value); break;
                        case "new_photo_filename": new_photo_filename_from_review = value; break;
                    }
                } else {
                    if (item.getSize() > 0) {
                        String originalFilename = item.getName();
                        String extension = "";
                        int dotIndex = originalFilename.lastIndexOf(".");
                        if (dotIndex > 0) extension = originalFilename.substring(dotIndex);
                        String baseName = dotIndex > 0 ? originalFilename.substring(0, dotIndex) : originalFilename;
                        newFilename = baseName + "_" + System.currentTimeMillis() + extension;
                        vo.setPhoto(newFilename);

                        File tempDir = new File(uploadPath + File.separator + "temp");
                        if (!tempDir.exists()) tempDir.mkdirs();
                        File tempFile = new File(tempDir, newFilename);
                        item.write(tempFile);
                    }
                }
            }

            if ("confirm_update".equals(action)) {
                if (!new_photo_filename_from_review.isEmpty()) {
                    vo.setPhoto(new_photo_filename_from_review);
                }

                File finalTempFile = new File(uploadPath + File.separator + "temp" + File.separator + vo.getPhoto());

                if (!new_photo_filename_from_review.isEmpty() && finalTempFile.exists()) {
                    File destFile = new File(uploadPath + File.separator + vo.getPhoto());
                    finalTempFile.renameTo(destFile);

                    if (old_photo != null && !old_photo.isEmpty()) {
                        File oldFile = new File(uploadPath + File.separator + old_photo);
                        if (oldFile.exists()) oldFile.delete();
                    }
                }
                
                if (dao.updateBoard(vo) == 1) {
                    response.sendRedirect("list.jsp");
                } else {
                    if (finalTempFile.exists()) finalTempFile.delete();
                    out.println("<script>alert('DB 수정에 실패했습니다.'); history.back();</script>");
                }

            } else {
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>수정 확인</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        h1 { color: #006bb3; } /* Changed color for edit */
        .post-details {
            border: 1px solid #ccc;
            padding: 15px;
            margin-bottom: 20px;
            background-color: #f9f9f9;
        }
        .post-details p, .post-details div { margin: 5px 0; }
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
        .confirm-btn { background-color: #006bb3; color: white; } /* Changed color for edit */
        .cancel-btn { background-color: #5bc0de; color: white; }
    </style>
</head>
<body>
<h1>게시글 수정 확인</h1>
<p>아래 내용으로 정말 수정하시겠습니까?</p>

<form action="edit_ok.jsp" method="post" enctype="multipart/form-data">
    <input type="hidden" name="action" value="confirm_update"/>
    <input type="hidden" name="seq" value="<%= vo.getSeq() %>"/>
    <input type="hidden" name="category" value="<%= vo.getCategory() %>"/>
    <input type="hidden" name="title" value="<%= vo.getTitle() %>"/>
    <input type="hidden" name="writer" value="<%= vo.getWriter() %>"/>
    <input type="hidden" name="content" value="<%= vo.getContent() %>"/>
    <input type="hidden" name="old_photo" value="<%= old_photo %>"/>
    <% if (newFilename != null) { %>
    <input type="hidden" name="new_photo_filename" value="<%= newFilename %>" />
    <% } %>

    <div class="post-details">
        <p><strong>카테고리:</strong> <%= vo.getCategory() %></p>
        <p><strong>제목:</strong> <%= vo.getTitle() %></p>
        <p><strong>작성자:</strong> <%= vo.getWriter() %></p>
        <div><strong>내용:</strong>
            <div style="border:1px solid #eee; padding: 10px; margin-top: 5px;"><%= vo.getContent() %></div>
        </div>
        <% if (newFilename != null) { %>
            <p><strong>새로운 사진:</strong></p>
            <img src="upload/temp/<%= newFilename %>" width="200" alt="New photo preview">
        <% } else { %>
            <p><strong>기존 사진:</strong></p>
            <% if (!old_photo.isEmpty()) { %>
            <img src="upload/<%= old_photo %>" width="200" alt="Current photo">
            <% } else { %>
            (사진 없음)
            <% } %>
        <% } %>
    </div>

    <div class="buttons">
        <input type="submit" value="확인" class="confirm-btn">
        <a href="javascript:history.back()" class="cancel-btn">취소</a>
    </div>
</form>
</body>
</html>
<%
            }
        } catch (Exception e) {
            out.println("오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
    }
%>