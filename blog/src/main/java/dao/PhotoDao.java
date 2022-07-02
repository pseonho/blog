package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.Photo;

public class PhotoDao {
	public PhotoDao() {} // 생성자 메서드
	
	//이미지 이름을 반환하는 메서드
	public String selectPhotoName(int photoNo) {
		String photoName= "";
		return photoName;
	}
	//SELECT photo_name FROM photo
	
	// 이미지 입력 코드
	public void insertPhoto(Photo photo) throws Exception {
		// MySql 드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "mariadb1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		// SQL 쿼리를 문자열로 저장
		String sql = "INSERT INTO photo(photo_name, photo_original_name, photo_type, photo_pw, writer, create_date, update_date) VALUES(?,?,?,?,?,NOW(),NOW())";
		
		// photo 쿼리를 저장
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, photo.getPhotoName());
		stmt.setString(2, photo.getPhotoOriginalName());
		stmt.setString(3, photo.getPhotoType());
		stmt.setString(4, photo.getPhotoPw());
		stmt.setString(5, photo.getWriter());
		
		int row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
	}
	
	// 이미지 삭제 코드
		public int deletePhoto(int photoNo, String photoPw) throws Exception { 
			int row = 0; // 함수 결과값(쩡수) 반환해줄 변수 선언 후 초기화
			
			// MySql 드라이버 로딩
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			
			// MySql RDBMS에 접속(IP주소, 접속계정 아이디, 패스워드)
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "mariadb1234";
			conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
			
			// SQL 쿼리를 문자열로 저장
			String sql = 
				"DELETE FROM photo WHERE photo_no=? AND photo_pw=?";
			
			// photo 쿼리를 저장
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, photoNo);
			stmt.setString(2, photoPw);
			// 디버깅 코드
			System.out.println(stmt + " <-- sql deletePhoto"); 
			
			// 쿼리를 실행 후 결과값(테이블모양의 ResultSet타입)을 리턴
			row = stmt.executeUpdate();
			
			// DB 자원들 반환, 종료
			stmt.close();
			conn.close();
			
			// 정수값 반환
			return row;
		}
	//이미지 목록
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
	      ArrayList<Photo> list = new ArrayList<Photo>();
	      Class.forName("org.mariadb.jdbc.Driver");
	      Connection conn = null;
	      PreparedStatement stmt = null;
	      ResultSet rs = null;
	      conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/blog","root","mariadb1234");
	      String sql = "SELECT photo_no photoNo, photo_name photoName FROM photo ORDER BY create_date DESC LIMIT ?,?";
	      stmt = conn.prepareStatement(sql);
	      stmt.setInt(1, beginRow);
	      stmt.setInt(2, rowPerPage);
	      rs = stmt.executeQuery();
	      while(rs.next()) {
	         Photo p = new Photo();
	         p.setPhotoNo(rs.getInt("photoNo"));
	         p.setPhotoName(rs.getString("photoName"));
	         list.add(p);
	      }
	      return list;
	   
	   }
	// 전체 행의 수
	public int selectPhotoTotalRow() throws Exception {
		int total = 0; // 총 행의 갯수 저장하는 변수 선언
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "mariadb1234"; // DB 패스워드
		String sql = "SELECT COUNT(*) cnt FROM photo";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		rs = stmt.executeQuery(); // 쿼리 저장
		
		if(rs.next()) { // 데이터가 있을때
			total = rs.getInt("cnt"); // 몇행인지 받아서 저장
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return total;
	}
	
	//  이미지 상세보기
	public Photo selectPhotoOne(int photoNo) throws Exception {
		Photo photo = null; // 객체 생성 준비
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // DB 주소
		String dbuser = "root"; // DB 아이디
		String dbpw = "mariadb1234"; // DB 패스워드
		String sql = "SELECT photo_no photoNo, photo_name photoName, writer, create_date createDate, update_date updateDate FROM photo WHERE photo_no=?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB접속
		stmt = conn.prepareStatement(sql); // 쿼리 작성
		stmt.setInt(1, photoNo); // 이미지의 번호를 이용해 사용자가 어떤 이미지를 보고 있는지 판단
		
		System.out.println("sql selectPhotoOne : " + stmt); // 디버깅
		
		rs = stmt.executeQuery(); // 쿼리 저장
		
		if(rs.next()) { // 사용자에게 보여줄 정보가 있을때 객체를 이용해 멤버변수에 저장
			photo = new Photo();
			photo.setPhotoNo(rs.getInt("photoNo"));
			photo.setPhotoName(rs.getString("photoName"));
			photo.setWriter(rs.getString("writer"));
			photo.setCreateDate(rs.getString("createDate"));
			photo.setUpdateDate( rs.getString("updateDate"));
		}
		
		
		// 반납
		rs.close();
		conn.close();
		stmt.close();
		
		return photo;
	}
}
