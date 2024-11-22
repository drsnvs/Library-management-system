package LmsDB;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Admin
 */
public class LmsDbConnection {
     Connection con = null;
     Statement st = null;
     ResultSet rs = null;
     PreparedStatement ps = null;
     
     private String EmailId;
     private String EmailProtect;
     public LmsDbConnection(){
         try{
             System.out.println("1");
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/liabrarymanagenentsystem", "root", "");   
            if(con!=null){
                System.out.println("Con Suc");
            }
        }  catch (SQLException ex) {
            System.out.println(ex);
             Logger.getLogger(LmsDbConnection.class.getName()).log(Level.SEVERE, null, ex);
         }catch (ClassNotFoundException ex) {
             System.out.println(ex);
             Logger.getLogger(LmsDbConnection.class.getName()).log(Level.SEVERE, null, ex);
         } catch(NullPointerException ne){
             System.out.println(ne);
            Logger.getLogger(LmsDbConnection.class.getName()).log(Level.SEVERE, null, ne);
        }
        catch(Exception e){
            Logger.getLogger(LmsDbConnection.class.getName()).log(Level.SEVERE, null, e);
        }
     }
    public PreparedStatement PsStatment(String url){
        try{
            System.out.println("2");
            ps = con.prepareStatement(url);
        } catch (SQLException ex) {
             Logger.getLogger(LmsDbConnection.class.getName()).log(Level.SEVERE, null, ex);
         }
         return ps;
    }
    public Statement StStatment(){
        try{
             if(con != null){
                st= con.createStatement(); 
             }
             
        } catch (SQLException ex) {
             Logger.getLogger(LmsDbConnection.class.getName()).log(Level.SEVERE, null, ex);
         }
         return st;
    }
    
    
  
}