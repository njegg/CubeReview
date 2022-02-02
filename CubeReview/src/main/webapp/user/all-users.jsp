<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
  <head>	
    <meta charset="UTF-8">
    <title>List of all registered users</title>
		
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
      
      <h1>All registered users</h1>
      <hr>
      
      <c:forEach items="${users}" var="u">
        <b><a href="/user/${u.username}">${u.username}</a></b>
        &#65372 ${u.email} &#65372 ${u.creationTime}
        <hr>
      </c:forEach>     
     
    </div>
  </main>
  
</body>
</html>
