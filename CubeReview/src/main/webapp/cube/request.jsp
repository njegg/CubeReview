<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
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
    <link rel="stylesheet" href="${root}/styles/review.css">
    
  </head>
<body>
  <jsp:include page="${root}/nav.jsp"></jsp:include>
  
  <main>
    <div id="main-content">
      <h2>Send us a request to add a cube</h2>
      <form action="/request/submit" method="post" id="request-cube-form" name="request-cube-form">
        <input type="text" name="cubeName" placeholder="Cubes name…">
        <br>
        <textarea 
          maxlength="256"
          id="request-text" 
          name="message"
          form="request-cube-form" 
          rows="8" cols="32" 
          placeholder="Write us some more details…"></textarea>
        
        <br>
        <input type="submit" class="submit-button" value="Send">
      </form>
      <br>
      ${msg}
      <br>
      <a href="/">Go back home</a> or look at the <a href="/cube/all">cubes</a>.
    </div>
  </main>
  
  <jsp:include page="${root}/footer.jsp"></jsp:include>
</body>
</html>