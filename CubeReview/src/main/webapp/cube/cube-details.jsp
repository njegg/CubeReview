<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
  <head>
  <meta charset="UTF-8">
  <title>${cube.name}</title>

  <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">
  
  <%request.setAttribute("root", request.getContextPath());%>
  <link rel="stylesheet" href="${root}/styles/style.css">
  <link rel="stylesheet" href="${root}/styles/form.css">
  <link rel="stylesheet" href="${root}/styles/nav.css">
  <link rel="stylesheet" href="${root}/styles/stars.css">
</head>
<body>
  <jsp:include page="${root}/nav.jsp"></jsp:include>
  
  <main>
    <div id="main-content">
      <!-- make a table -->
      <h1>${cube.name}</h1>      
      type: ${cube.cubeType.typeName}
      released: ${cube.releaseYear}
      <hr>
      <b>reviews:</b>
      <hr>      
      
      <s:authorize access="!isAuthenticated()">
        <a href="/auth/login">Log in</a> to write a review
      </s:authorize>
      
      <s:authorize access="isAuthenticated()">
      
        Write a review as <a href="/user/${user.userId}">${user.username}</a>
        <br>
        
        <form id="save-form" name="save-form" action="/review/post-review" method="post">
            <textarea maxlength="300" id="review-form" name="content" form="save-form" rows="8" cols="32" placeholder="Your review of ${cube.name}">${user.about}</textarea>
        

            <span class="quality-name">quality1</span>
            <fieldset id="rating">
              <span class="star-cb-group">
                    <input type="radio" id="rating-5" name="rating" value="5" /><label for="rating-5">5</label>
                    <input type="radio" id="rating-4" name="rating" value="4" checked="checked" /><label for="rating-4">4</label>
                    <input type="radio" id="rating-3" name="rating" value="3" /><label for="rating-3">3</label>
                    <input type="radio" id="rating-2" name="rating" value="2" /><label for="rating-2">2</label>
                    <input type="radio" id="rating-1" name="rating" value="1" /><label for="rating-1">1</label>
                    <input type="radio" id="rating-0" name="rating" value="0" class="star-cb-clear" /><label for="rating-0">0</label>
                  </span>
                </fieldset>
                <span class="quality-name">quality2</span>
                <fieldset id="rating2">
                  <span class="star-cb-group">
                    <input type="radio" id="rating-5-2" name="rating2" value="5" /><label for="rating-5">5</label>
                    <input type="radio" id="rating-4-2" name="rating2" value="4" checked="checked" /><label for="rating-4">4</label>
                    <input type="radio" id="rating-3-2" name="rating2" value="3" /><label for="rating-3">3</label>
                    <input type="radio" id="rating-2-2" name="rating2" value="2" /><label for="rating-2">2</label>
                    <input type="radio" id="rating-1-2" name="rating2" value="1" /><label for="rating-1">1</label>
                    <input type="radio" id="rating-0-2" name="rating2" value="0" class="star-cb-clear" /><label for="rating-0">0</label>
                  </span>
                </fieldset>
                <span class="quality-name">quality3</span>
                <fieldset id="rating3">
                  <span class="star-cb-group">
                    <input type="radio" id="rating-5-3" name="rating3" value="5" /><label for="rating-5">5</label>
                    <input type="radio" id="rating-4-3" name="rating3" value="4" checked="checked" /><label for="rating-4">4</label>
                    <input type="radio" id="rating-3-3" name="rating3" value="3" /><label for="rating-3">3</label>
                    <input type="radio" id="rating-2-3" name="rating3" value="2" /><label for="rating-2">2</label>
                    <input type="radio" id="rating-1-3" name="rating3" value="1" /><label for="rating-1">1</label>
                    <input type="radio" id="rating-0-3" name="rating3" value="0" class="star-cb-clear" /><label for="rating-0">0</label>
                  </span>
                </fieldset>
                
                <input class="submit-button" type="submit" value="save"><br>
        </form>
        
      </s:authorize>      
      
      <hr>
    </div>
  </main>
  
</body>
</html>