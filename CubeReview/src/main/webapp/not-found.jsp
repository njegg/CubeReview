<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
  <head>	
    <meta charset="UTF-8">
    <title>User not found</title>
		
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">
    <link rel="stylesheet" href="../styles/style.css">
    <link rel="stylesheet" href="../styles/form.css">
    <link rel="stylesheet" href="../styles/nav.css">
  </head>
<body>
  <%@include  file="../nav.jsp" %>
  
  <main>
    <div id="main-content">
      <h1 class="err">${obj} not found</h1>
    </div>
  </main>
  
</body>
</html>