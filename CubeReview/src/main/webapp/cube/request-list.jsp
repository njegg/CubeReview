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
    <link rel="stylesheet" href="${root}/styles/request.css">
    
  </head>
<body>
  <jsp:include page="${root}/nav.jsp"></jsp:include>
  
  <main>
    <div id="main-content">
        <c:if test="${normalUser}">
          Your cube requests, <a href="${root}/user/${user.username}">${user.username}</a>
          <br>
        </c:if>
          
        <c:forEach items="${requests}" var="r">
          <div class="request" id="${r.cubeRequestId}">
            <s:authorize access="hasAnyRole('ADMIN', 'MOD')">
              <span class="approve-links">        
                <c:if test="${r.approved == 0}">
                  <a href="/request/${r.cubeRequestId}/approve?approve=1" class="approve">Approve</a>
                  <a href="/request/${r.cubeRequestId}/approve?approve=-1" class="disapprove">Disapprove</a>
                </c:if>
              </span>
            </s:authorize>
            Approved:
            <c:choose>
              <c:when test="${r.approved == 1}">
                <span class="approve-status-yes">YES</span>
              </c:when>
              <c:when test="${r.approved == -1}">
                 <span class="approve-status-no">NO</span>
              </c:when>
              <c:otherwise>
                <span class="approve-status-pending">PENDING</span>
              </c:otherwise>
            </c:choose>
            <br>
            Cube name: ${r.cubeName}
            <div class="request-msg">
              Message:
              <br>
              <span class="request-msg-content">${r.content}</span>
            </div>              
          </div>
        </c:forEach>          
          
    </div>
  </main>
  
  <jsp:include page="${root}/footer.jsp"></jsp:include>
</body>
</html>