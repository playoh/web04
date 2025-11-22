<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 25. 11. 22.
  Time: 오후 9:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="org.example.ihateweb04.dao.BoardDAO, org.example.ihateweb04.bean.BoardVO"%>
<%
    String sid = request.getParameter("id");
    if (sid != ""){
        int id = Integer.parseInt(sid);
        BoardVO u = new BoardVO();
        u.setSeq(id);
        BoardDAO boardDAO = new BoardDAO();
        boardDAO.deleteBoard(u);
    }
    response.sendRedirect("list.jsp");
%>