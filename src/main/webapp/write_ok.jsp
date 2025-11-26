<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.example.ihateweb04.bean.BoardVO" %>
<%@ page import="org.example.ihateweb04.dao.BoardDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    BoardVO vo = new BoardVO();
    BoardDAO dao = new BoardDAO();

    String filename = "";
    String uploadPath = application.getRealPath("upload");

    if (ServletFileUpload.isMultipartContent(request)) {
        try {
            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    // 폼 필드 처리
                    String fieldName = item.getFieldName();
                    String value = item.getString("UTF-8");
                    if ("category".equals(fieldName)) {
                        vo.setCategory(value);
                    } else if ("title".equals(fieldName)) {
                        vo.setTitle(value);
                    } else if ("writer".equals(fieldName)) {
                        vo.setWriter(value);
                    } else if ("content".equals(fieldName)) {
                        vo.setContent(value);
                    }
                } else {
                    // 파일 처리
                    String fieldName = item.getFieldName();
                    String contentType = item.getContentType();

                    if(fieldName.equals("photo") && item.getSize() > 0) {
                        // 1. 이미지 파일인지 확인
                        if (contentType == null || !contentType.startsWith("image/")) {
                            out.println("<script>alert('이미지 파일만 업로드할 수 있습니다.'); history.back();</script>");
                            return; // 처리 중단
                        }

                        // 2. 중복 방지를 위한 새로운 파일명 생성
                        String originalFilename = item.getName();
                        String extension = "";
                        int dotIndex = originalFilename.lastIndexOf(".");
                        if (dotIndex > 0) {
                            extension = originalFilename.substring(dotIndex);
                        }
                        String baseName = dotIndex > 0 ? originalFilename.substring(0, dotIndex) : originalFilename;
                        long timestamp = new java.util.Date().getTime();
                        String newFilename = baseName + "_" + timestamp + extension;

                        vo.setPhoto(newFilename);
                        File uploadedFile = new File(uploadPath + File.separator + newFilename);
                        item.write(uploadedFile);
                    }
                }
            }

            // DB에 저장
            if (dao.insertBoard(vo) == 1) {
                response.sendRedirect("list.jsp");
            } else {
                out.println("<script>alert('글 작성에 실패했습니다.'); history.back();</script>");
            }

        } catch (Exception e) {
            // e.printStackTrace(); // 서버 로그에 스택 트레이스 출력
            // 디버깅을 위해 오류 정보를 웹 페이지에 직접 출력
            out.println("<html><body>");
            out.println("<h2>파일 업로드 오류 발생</h2>");
            out.println("<hr>");
            out.println("<b>오류 메시지:</b><br>");
            out.println(e.getMessage());
            out.println("<br><br><b>스택 트레이스:</b><br>");
            out.println("<pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
            out.println("</pre>");
            out.println("</body></html>");
        }
    }
%>
