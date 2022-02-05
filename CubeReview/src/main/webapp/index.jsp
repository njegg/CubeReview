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
  </head>
<body>
  <jsp:include page="${root}/nav.jsp"></jsp:include>
  
  <main>
    <div id="main-content">
      <div class="title">
        <div class="rainbow-text title-cr" style="text-align: center;">
          <span class="block-line">CubeReview</span>
        </div>
      </div>
      
      <div id="main-links">
        <s:authorize access="!isAuthenticated()">
          <a href="/auth/login">Log In</a>
          <br>
          Or
          <br>
          <a href="/auth/register">Sign Up</a>
        </s:authorize>

        <s:authorize access="isAuthenticated()">
          Welcome back, 
          <a href="/user/<s:authentication property="principal.username"/>" >
            <s:authentication property="principal.username" />
          </a>
          <hr>
          <c:choose>
            <c:when test="${empty followerReviews}">
              Follow some people to see their reviews:
              <a href="#"> search users</a>
            </c:when>
            
            <c:otherwise>
              Reviews from people you follow:
            </c:otherwise>
        </c:choose>
        <br>
        
        </s:authorize>
      </div>
    </div>
  </main>
  
</body>
</html>