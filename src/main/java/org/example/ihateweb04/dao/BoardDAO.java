package org.example.ihateweb04.dao;

import org.example.ihateweb04.bean.BoardVO;
import org.example.ihateweb04.common.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    private final String BOARD_INSERT = "insert into BOARD (category, title, writer, content, photo) values (?,?,?,?,?)";
    private final String BOARD_UPDATE = "update BOARD set category=?, title=?, writer=?, content=?, photo=? where seq=?";
    private final String BOARD_DELETE = "delete from BOARD  where seq=?";
    private final String BOARD_GET = "select * from BOARD  where seq=?";
    // private final String BOARD_LIST = "select * from BOARD order by seq desc"; // No longer needed

    public int insertBoard(BoardVO vo) {
        System.out.println("===> JDBC로 insertBoard() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_INSERT);
            stmt.setString(1, vo.getCategory());
            stmt.setString(2, vo.getTitle());
            stmt.setString(3, vo.getWriter());
            stmt.setString(4, vo.getContent());
            stmt.setString(5, vo.getPhoto());
            stmt.executeUpdate();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn);
        }
        return 0;
    }

    public void deleteBoard(BoardVO vo) {
        System.out.println("===> JDBC로 deleteBoard() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_DELETE);
            stmt.setInt(1, vo.getSeq());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn);
        }
    }

    public int updateBoard(BoardVO vo) {
        System.out.println("===> JDBC로 updateBoard() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_UPDATE);
            stmt.setString(1, vo.getCategory());
            stmt.setString(2, vo.getTitle());
            stmt.setString(3, vo.getWriter());
            stmt.setString(4, vo.getContent());
            stmt.setString(5, vo.getPhoto());
            stmt.setInt(6, vo.getSeq());
            stmt.executeUpdate();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn);
        }
        return 0;
    }

    public BoardVO getBoard(int seq) {
        BoardVO one = new BoardVO();
        System.out.println("===> JDBC로 getBoard() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_GET);
            stmt.setInt(1, seq);
            rs = stmt.executeQuery();
            if (rs.next()) {
                one.setSeq(rs.getInt("seq"));
                one.setCategory(rs.getString("category"));
                one.setTitle(rs.getString("title"));
                one.setWriter(rs.getString("writer"));
                one.setContent(rs.getString("content"));
                one.setPhoto(rs.getString("photo"));
                one.setCnt(rs.getInt("cnt"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(rs, stmt, conn);
        }
        return one;
    }

    public List<String> getCategories() {
        List<String> categories = new ArrayList<>();
        System.out.println("===> JDBC로 getCategories() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement("SELECT DISTINCT category FROM BOARD ORDER BY category");
            rs = stmt.executeQuery();
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(rs, stmt, conn);
        }
        return categories;
    }

    public int getBoardCount(String category, String searchCondition, String keyword) {
        int count = 0;
        System.out.println("===> JDBC로 getBoardCount() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            StringBuilder sql = new StringBuilder("SELECT count(*) FROM BOARD");
            List<String> params = new ArrayList<>();

            StringBuilder whereSql = new StringBuilder();
            if (category != null && !category.isEmpty() && !category.equals("all")) {
                whereSql.append(" category = ?");
                params.add(category);
            }

            if (keyword != null && !keyword.isEmpty()) {
                if (whereSql.length() > 0) whereSql.append(" AND");
                if ("title".equals(searchCondition)) {
                    whereSql.append(" title LIKE ?");
                } else if ("writer".equals(searchCondition)) {
                    whereSql.append(" writer LIKE ?");
                }
                params.add("%" + keyword + "%");
            }

            if (whereSql.length() > 0) {
                sql.append(" WHERE").append(whereSql);
            }

            stmt = conn.prepareStatement(sql.toString());

            for(int i = 0; i < params.size(); i++) {
                stmt.setString(i + 1, params.get(i));
            }

            rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(rs, stmt, conn);
        }
        return count;
    }

    public List<BoardVO> getBoardList(String category, String searchCondition, String keyword) {
        List<BoardVO> list = new ArrayList<>();
        System.out.println("===> JDBC로 getBoardList() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            StringBuilder sql = new StringBuilder("SELECT * FROM BOARD");
            List<String> params = new ArrayList<>();

            StringBuilder whereSql = new StringBuilder();
            if (category != null && !category.isEmpty() && !category.equals("all")) {
                whereSql.append(" category = ?");
                params.add(category);
            }

            if (keyword != null && !keyword.isEmpty()) {
                if (whereSql.length() > 0) whereSql.append(" AND");
                if ("title".equals(searchCondition)) {
                    whereSql.append(" title LIKE ?");
                } else if ("writer".equals(searchCondition)) {
                    whereSql.append(" writer LIKE ?");
                }
                params.add("%" + keyword + "%");
            }

            if (whereSql.length() > 0) {
                sql.append(" WHERE").append(whereSql);
            }
            sql.append(" ORDER BY seq DESC");

            stmt = conn.prepareStatement(sql.toString());

            for(int i = 0; i < params.size(); i++) {
                stmt.setString(i + 1, params.get(i));
            }

            rs = stmt.executeQuery();
            while (rs.next()) {
                BoardVO one = new BoardVO();
                one.setSeq(rs.getInt("seq"));
                one.setCategory(rs.getString("category"));
                one.setTitle(rs.getString("title"));
                one.setWriter(rs.getString("writer"));
                one.setContent(rs.getString("content"));
                one.setRegdate(rs.getDate("regdate"));
                one.setPhoto(rs.getString("photo"));
                one.setCnt(rs.getInt("cnt"));
                list.add(one);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(rs, stmt, conn);
        }
        return list;
    }
}

