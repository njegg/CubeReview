<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html>
<html>
<head>	
  <meta charset="UTF-8">
  <title>Review reports</title>
  
  <%request.setAttribute("root", request.getContextPath());%>
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">
  <link rel="stylesheet" href="${root}/styles/style.css">
  <link rel="stylesheet" href="${root}/styles/form.css">
  <link rel="stylesheet" href="${root}/styles/nav.css">
  <link rel="stylesheet" href="${root}/styles/review.css">
  
  <script type="text/javascript" src="${root}/js/confirm-delete.js"></script>
  
</head>
<body>
  <jsp:include page="${root}/nav.jsp"></jsp:include>
  
  <main>
    <div id="main-content">
      <h3>All review reports by users</h3>
      <br>
      
      <c:forEach items="${reports}" var="r">
        <div class="report-content">
          Report by <a href="/user/${r.user.username}">${r.user.username}</a>
          <br>
          Message:
          <br>
          <span class="report-message">
            ${r.content}
          </span>
        </div>
      
        <div id="${r.review.reviewId}" class="review-post">
          <span class="review">
            <span class="rating-id">[${r.review.reviewId}]</span>
            <a href="/user/${r.review.user.username}">${r.review.user.username}  </a>
            <span class="post-time">at: ${r.review.creationTime}</span>
            <br>
             
            <!-- rated stars -->
            <c:forEach begin="1" end="${r.review.rating}" varStatus="loop">
                <span class="star">
                  ☆
                </span>
            </c:forEach>
            <!-- left of rated stars -->
            <c:forEach begin="1" end="${5 - r.review.rating}" varStatus="loop">
                <span>
                  ☆
                </span>
            </c:forEach>
            <br>
            
            <a href="/cube/${r.review.cube.cubeId}#${r.review.reviewId}" class="review-content">
                <span>${r.review.content}</span>
            </a>
          </span>
          
          <div class="under-review">
            <s:authorize access="hasAnyRole('ADMIN', 'MOD')">
              <a onclick="confirmDelete('Are you sure you want to delete review of user: ${r.review.user.username}?', '${root}/review/${r.review.reviewId}/delete')" class="under-review-content">Delete review</a>
            </s:authorize>
          </div>
          
        </div>
        <br>
      </c:forEach>
      
    </div>
  </main>
  
  <jsp:include page="${root}/footer.jsp"></jsp:include>
</body>
</html>