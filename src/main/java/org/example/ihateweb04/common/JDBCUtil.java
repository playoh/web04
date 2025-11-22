package org.example.ihateweb04.common;

import java.sql.Connection;
import java.sql.DriverManager;


public class JDBCUtil {
    public static Connection getConnection(){
        Connection con=null;
        try{
            Class.forName("org.mariadb.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mariadb://walab.handong.edu:8080/W25_22400445", "W25_22400445", "chui2E");
        }catch(Exception e){
            System.out.println(e);
        }
        return con;
    }


    public static void main(String ars[]) {
        Connection conn = getConnection();
        if(conn != null)
            System.out.println("DB 연결됨!");
        else
            System.out.println("DB 연결중 오류 !");
    }
}