<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//커넥션 pool을 이용한 커넥션 객체 사용
	//-톰캣 서버가 커넥션 pool에 미리 생성해 놓은 Connection 객체를 갖다 사용하는것
	//1]InitialContext 객체 생성(Context > InitialContext)
	Context ctx = new InitialContext();
	
	//2]InitialContext 객체로 JNDI서비스 구조의 초기 ROOT디렉토리 얻기
	//Loolup해서 각 Was서버의 서비스 루트 디렉토리를 얻는다.
	//ctx = (Context)ctx.lookup("java:comp/env");
	
	//3] Context.xml에 등록한 네이밍을 lookup / 톰캣의 context.xml에 등록한 네이밍으로 Datasource를 얻는다.
	//DataSource source = (DataSource)ctx.lookup("jsp");
	
	//풀경로로 접근하기
	DataSource source = (DataSource)ctx.lookup("java:comp/env/jsp");
	
	//4] 커넥션 pool에서 톰캣 서버가 생성해 놓은 Connection객체를 갖다 쓰자
	// DataSource의 getConnection()메소드로 톰캣이 pool에 미리 생성해 놓은 Connection 객체를 가져다 쓴다.
	
	Connection conn = source.getConnection();
	String connString;
	if(conn != null) connString="<h3>데이터 베이스 연결 성공</h3>";
	else connString="<h3>데이터 베이스 연결 실패</h3>";
	
	//5]커넥션 풀에 사용한 커넥션 객체 다시 반납(메모리 해제가 아님)
	conn.close();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ConnectionPool.jsp</title>
</head>
<body>
	<fieldset>
		<legend>커넥션 풀</legend>
		<%=connString %>
	</fieldset>
</body>
</html>