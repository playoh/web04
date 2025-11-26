package org.example.ihateweb04.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JDBCUtil {
    public static Connection getConnection(){
        Connection con=null;
        try{
            Class.forName("org.mariadb.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mariadb://walab.handong.edu:3306/W25_22400445?characterEncoding=utf8", "W25_22400445", "chui2E");
        }catch(Exception e){
            System.out.println(e);
        }
        return con;
    }

    public static void close(PreparedStatement stmt, Connection conn) {
        if (stmt != null) {
            try {
                stmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static void close(ResultSet rs, PreparedStatement stmt, Connection conn) {
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        close(stmt, conn);
    }

    public static void main(String ars[]) {
        Connection conn = getConnection();
        if(conn != null)
            System.out.println("DB 연결됨!");
        else
            System.out.println("DB 연결중 오류 !");
    }
}