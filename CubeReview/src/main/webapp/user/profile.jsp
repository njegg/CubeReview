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
            
            <input type="submit" class="submit-button" value="save">
            
          </form>		        
        </c:if>
	  </s:authorize>
      
      <hr>
      
	  <span class="main-heading">About me</span>
	  
	  <c:if test="${owner}">
	    <c:if test="${!edit}">
          <a id="edit-about" href="/user/${user.username}/edit-about">
	        edit
	      </a>
	    </c:if>

	    <c:if test="${edit}">
	      <form id="save-form" name="save-form" action="/user/${user.username}/save-about" method="post">
            <input class="submit-button" type="submit" value="save">
	      </form>
          <textarea maxlength="256" id="about" name="about" form="save-form" rows="8" cols="32" placeholder="Write something about yourself">${user.about}</textarea>
	    </c:if>	    
	  </c:if>

	  <br>
	  
	  <c:if test="${!edit}">
        <span id="user-about">${user.about}</span>
        <hr>
      </c:if>
	  
	  
	  <!--
	  edit-> user/profile/edit -> vrati nazad sa bool edit true -> if edit naravi textfield za prewriten about
	  
	  save-> user/profle/save-about
	  -->
	  	  
	  <br><br>
	  reviews go here
	  
    </div>
  </main>
  
</body>
</html>