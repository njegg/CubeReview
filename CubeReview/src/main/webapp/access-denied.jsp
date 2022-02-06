<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
  <head>	
    <meta charset="UTF-8">
    <title>Access Denied</title>
	
	<%request.setAttribute("root", request.getContextPath());%>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">
    <link rel="stylesheet" href="${root}/styles/style.css">
    <link rel="stylesheet" href="${root}/styles/form.css">
    <link rel="stylesheet" href="${root}/styles/nav.css">
  </head>
<body>
  <jsp:include page="${root}/nav.jsp"></jsp:include>
  
  <main>
    <div id="main-content">
      <h1 class="err">Access Denied</h1>
      <hr>
      <a href="/">Go home</a>
    </div>
  </main>
  
</body>
</html>
