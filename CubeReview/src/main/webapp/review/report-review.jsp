<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Report a review</title>
    
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
      Write a report for a 
      <a href="${root}/cube/${review.cube.cubeId}#${review.reviewId}">review id ${review.reviewId}</a>     
      <br>
      <div class="review-post">
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
            
      <form action="/review/${r.reviewId}/report" method="get" id="report-review-form" name="report-review-form">
        <textarea 
          maxlength="256"
          id="report-text" 
          name="content"
          form="report-review-form" 
          rows="8" cols="32" 
          placeholder="Report reason…"></textarea>
        
        <br>
        <input type="submit" class="submit-button" value="Send">
      </form>
      <br>
      
      <h4>${msg}</h4>
      Go back <a href="/">home</a>
      </div>
    </main>

    <jsp:include page="${root}/footer.jsp"></jsp:include>
  </body>
</html>