<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
  <head>
  <meta charset="UTF-8">
  <title>${user.username}'s profile</title>

  <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">
  
  <%request.setAttribute("root", request.getContextPath());%>
  <link rel="stylesheet" href="${root}/styles/style.css">
  <link rel="stylesheet" href="${root}/styles/form.css">
  <link rel="stylesheet" href="${root}/styles/nav.css">
  <link rel="stylesheet" href="${root}/styles/review.css">
  
</head>
<body>
  <jsp:include page="${root}/nav.jsp"></jsp:include>
  
  <main>
    <div id="main-content">
      
      <c:if test="${owner}">
	    <h3>This is your profile</h3>
        <h1>${user.username}</h1>
      </c:if>
      
      <c:if test="${!owner}">
	    <h1>${user.username}'s profile</h1>
      </c:if>
      
      <s:authorize access="hasRole('ADMIN')">
        
        <c:if test="${!editRole}">
          <a href="/user/${user.username}/edit-role">edit role</a>
        </c:if>
        
        <c:if test="${editRole}">
          <form action="/user/${user.username}/save-role" method="post">
            
            <select name="roleId">
              <c:forEach items="${roles}" var="r">
                <option value="${r.roleId}">${r.name}</option>
              </c:forEach>
            </select>
            
            <input type="submit" class="save-button" value="save">
            
          </form>		        
        </c:if>
	  </s:authorize>
      <br>
      
      <c:if test="${!owner}">
        <c:choose>
          <c:when test="${followed}">
            <span class="following-you">${user.username} is following you!</span>
          </c:when>
          <c:otherwise>
            ${user.username} is not following you            
          </c:otherwise>
        </c:choose>
        <br>
        <a href="/user/${user.username}/follow" class="follow-link">
          <c:choose>
            <c:when test="${following}">
              Unfollow
            </c:when>
            <c:otherwise>
              Follow    
            </c:otherwise>
          </c:choose>
        </a>
      </c:if>
      <hr>

	  <span class="main-heading">About me</span>
	  
	  <c:if test="${owner}">
	    <c:if test="${!edit}">
          <a id="edit-about" href="/user/${user.username}/edit-about">
	        Edit
	      </a>
	    </c:if>

	    <c:if test="${edit}">
	      <form id="save-form" name="save-form" action="/user/${user.username}/save-about" method="post">
            <input class="submit-button float-right" type="submit" value="save">
	      </form>
          <textarea maxlength="256" id="about" name="about" form="save-form" rows="8" cols="32" placeholder="Write something about yourself">${user.about}</textarea>
          
          <button class="delete-button" onclick="confirmDelete()">Delete Account</button>
          <script>
        		function confirmDelete() {
              	let text = "Are you sure you want to delete this account?";
                  if (confirm(text) == true) {
                  	window.location.replace("${root}/user/${user.userId}/delete");
                  }
        		}
  		  </script>
	    </c:if>
	  </c:if>
      
      <c:if test="${admin && !owner}">
        <button class="delete-button float-right" onclick="confirmDelete()">Delete Account</button>
        <script>
            function confirmDelete() {
                let text = "Are you sure you want to delete this account?";
                  if (confirm(text) == true) {
                    window.location.replace("${root}/user/${user.userId}/delete");
                  }
            }
        </script>
      </c:if>

	  <c:if test="${!edit}">
        <span id="user-about">${user.about}</span>
        <br>
        <c:if test="${owner}">
          <h3>Your reviews</h3>
        </c:if>
      </c:if>
	  <br>
      
      
      <c:if test="${!owner}">
        <h3>
          <a href="/user/${user.username}">${user.username}</a>'s reviews:
        </h3>
      </c:if>
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
    </div>
  </main>
  
  <jsp:include page="${root}/footer.jsp"></jsp:include>
</body>
</html>