<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
  <head>	
    <meta charset="UTF-8">
    <title>Insert tite here</title>
	
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
      welkome to ris projeka ,.
      <a href="/user/all"> epik </a> <br>
      <a href="/auth/register"> reguste </a> <br>
      <a href="/auth/login">login</a> <br>
      <a href="/cube/all">cubes</a> <br>
      
      <a href="/cube/add-cube">add cube</a> <br>
    </div>
  </main>
  
</body>
</html>