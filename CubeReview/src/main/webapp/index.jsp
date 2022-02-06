<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html>
<html>
  <head>	
    <meta charset="UTF-8">
    <title>CubeReview</title>
	
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
        </s:authorize>
      </div>
      <hr>
      
      Check out all the <a href="/cube/all">cubes</a>!
            
      <hr>
      <s:authorize access="isAuthenticated()">
        <c:choose>
          <c:when test="${empty reviews}">
            Follow some people to see their reviews:
            <a href="/search/users"> search users</a>
          </c:when>
          
          <c:otherwise>
            Reviews from people you follow:
            <br>
            <c:forEach items="${reviews}" var="r">
          <div id="${r.reviewId}" class="review-post">
            <span class="up-down">
              <span class="review-votes">${r.votes}</span>
            </span>
            <span class="review">
              <span class="cube-name-review"><a href="/cube/${r.cube.cubeId}">${r.cube.name}</a></span>
              <br>
              <a href="/user/${r.user.username}">${r.user.username}  </a>
              <span class="post-time">at: ${r.creationTime}</span>
              <br>
               
              <c:forEach begin="1" end="${r.rating}" varStatus="loop">
                  <span class="star">
                    ☆
                  </span>
              </c:forEach>
              <c:forEach begin="1" end="${5 - r.rating}" varStatus="loop">
                  <span>
                    ☆
                  </span>
              </c:forEach>
              <br>
              
              <a href="/cube/${r.cube.cubeId}#${r.reviewId}" class="review-content">
                <span>${r.content}</span>
              </a>
            </span>
          </div>
        </c:forEach>
          </c:otherwise>
        </c:choose>
      </s:authorize>
    </div>
  </main>
  
  <jsp:include page="${root}/footer.jsp"></jsp:include>
</body>
</html>