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
  <link rel="stylesheet" href="${root}/styles/review.css">
  
  <script type="text/javascript" src="${root}/js/confirm-delete.js"></script>
  <script type="text/javascript" src="${root}/js/toggle-div-by-id.js"></script>
  
</head>
<body>
  <jsp:include page="${root}/nav.jsp"></jsp:include>
  
  <main>
    <div id="main-content">
      
      <c:choose>
        <c:when test="${!edit}">
          <table class="cube-detail-table">
            <tr>
              <td>Name:</td>
              <th>${cube.name}</th>
            </tr>
            <tr>
              <td>Type:</td>
              <td>${cube.cubeType.typeName}</td>
            </tr>
            <tr>
              <td>Year:</td>
              <td>${cube.releaseYear}</td>
            </tr>
          </table>
          <s:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MOD')">
            <a href="/cube/${cube.cubeId}?edit=1">Edit cube info</a>
          </s:authorize>
        </c:when>
         
        <c:otherwise>
          <form action="/cube/${cube.cubeId}/edit" method="post">
            Edit cube details
            <br>
            <table class="edit-table">
            <tr>
              <td>Name:</td>
              <td>
                <input type="text" name="name" value="${cube.name}">
              </td>
            </tr>
            <tr>
              <td>Type:</td>
              <td>
                <select name="typeId">
                  <c:forEach items="${types}" var="t">
                    <!-- preselect current type -->
                    <c:choose>
                      <c:when test="${cube.cubeType.cubeTypeId == t.cubeTypeId}">
                        <option value="${t.cubeTypeId}" selected="selected">${t.typeName}</option>
                      </c:when>
                      
                      <c:otherwise>
                        <option value="${t.cubeTypeId}">${t.typeName}</option>
                      </c:otherwise>
                    </c:choose>
                  </c:forEach>
                </select>
              </td>
            </tr>
            <tr>
              <td>Year:</td>
              <td>
                <input type="text" name="year" value="${cube.releaseYear}">
              </td>
            </tr>
          </table>
          <input class="save-button" type="submit" value="Save">
          </form>
         
          <button class="delete-button" 
            onclick="confirmDelete('Are you sure you want to delete this cube?', '${root}/cube/${cube.cubeId}/delete')">
              Delete Cube
          </button>
        </c:otherwise>
      </c:choose>
      <hr>
      
      <s:authorize access="!isAuthenticated()">
        <a href="/auth/login">Log in</a> to write a review
      </s:authorize>
      
      <!-- if loged in and not reviewd, post new, if reviewd, edit review  -->
      <s:authorize access="isAuthenticated()">
        <c:if test="${!hasReviewed}">
          Write a review as
          <a href="/user/${user.username}">${user.username}</a>
          
          <form id="save-form" name="save-form" action="/review/post-review?cubeId=${cube.cubeId}&edit=0" method="post">     
        </c:if>
        
        <c:if test="${hasReviewed}">
          Edit your review of ${cube.name}
          <form id="save-form" name="save-form" action="/review/post-review?cubeId=${cube.cubeId}&edit=1" method="post">
        </c:if>
        
          <textarea maxlength="300"
                    id="review-form" 
                    name="content"  
                    form="save-form" 
                    rows="8" cols="32" 
                    placeholder="Your review of ${cube.name}">${content}</textarea>
          <!-- stars -->
          <span class="quality-name">Overal rating of the cube:</span>
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
              
          <input class="submit-button" type="submit" value="Post"><br>
          <c:if test="${hasReviewed}">
            <a class="delete-button" 
              onclick="confirmDelete('Are you sure you want to delete your review?', '${root}/review/delete-for-cube-and-logger-user?cubeId=${cube.cubeId}')">
              Delete your review
            </a>
          </c:if>
        </form>
        
      </s:authorize>      
      
      <hr>

      <h3>User reviews:</h3>      
      <br>
            
      <c:forEach items="${reviews}" var="r">
        <div id="${r.reviewId}" class="review-post">
          <span class="up-down">
            <a href="/review/${r.reviewId}/like">
              <c:choose>
                <c:when test="${likeMap[r.reviewId] == 1}">
                  <span class="liked-arrow">◼</span>
                </c:when>
                
                <c:otherwise>
                  <span class="clear-arrow">◼</span>
                </c:otherwise>
              </c:choose>
            </a>
            <br>
            <span class="review-votes">${r.votes}</span>
            <br>
            <a href="/review/${r.reviewId}/dislike">
              <c:choose>
                <c:when test="${likeMap[r.reviewId] == 0}">
                  <span class="disliked-arrow">◼</span>
                </c:when>
                
                <c:otherwise>
                  <span class="clear-arrow">◼</span>
                </c:otherwise>
              </c:choose>
            </a>
          </span>
          
          <span class="review">
            <span class="rating-id">[${r.reviewId}]</span>
            <a href="/user/${r.user.username}">${r.user.username}  </a>
            <span class="post-time">at: ${r.creationTime}</span>
            <br>
             
            <!-- rated stars -->
            <c:forEach begin="1" end="${r.rating}" varStatus="loop">
                <span class="star">
                  ☆
                </span>
            </c:forEach>
            <!-- left of rated stars -->
            <c:forEach begin="1" end="${5 - r.rating}" varStatus="loop">
                <span>
                  ☆
                </span>
            </c:forEach>
            <br>
  
            ${r.content}
            
          </span>
          
          <div class="under-review">
            <s:authorize access="hasRole('ADMIN')">
              <a onclick="confirmToDelete('Are you sure you want to delete review of user: ${r.user.username}?', '${root}/review/${r.reviewId}/delete')" class="under-review-content">Delete review</a>
            </s:authorize>
            
            <!-- toggle all comments -->
            <!-- toggle post comment form -->
            <a onclick='toggle_div_by_id("review-comments-${r.reviewId}")' class="under-review-content">Toggle comments</a>
          </div>

          <div class="review-comments" id="review-comments-${r.reviewId}">
            <textarea maxlength="300"
                  id="comment-text-${r.reviewId}"
                  name="content"
                  form="comment-form-${r.reviewId}" 
                  rows="8" cols="32"
                  placeholder="Comment here…"></textarea>
          
            <form action="/review/${r.reviewId}/comment" method="post" id="comment-form-${r.reviewId}" name="comment-form-${r.reviewId}">
              <input type="submit" class="submit-button" value="Post">
              <br>            
            </form>
          
            <c:forEach items="${r.reviewComments}" var="c">
              <div class="comment" id="comment-${c.commentId}">
                <a href="/user/${c.user.username}">${c.user.username} </a>
                <span class="post-time">at ${c.commentDate}</span>
                <br>
                <span class="comment-content">
                  ${c.content}
                </span>
                <br>
                <s:authorize access="hasAnyRole('ADMIN', 'MOD')">
                  <button 
                      class="delete-comment-button delete-button" 
                      onclick="confirmDelete('Are you sure you want to delete this comment?', '${root}/review/comment/${c.commentId}/delete')">
                      Delete comment
                  </button>
                </s:authorize>
              </div>
            </c:forEach>
          </div>
          
        </div>
        <br>
      </c:forEach>
              
    </div>
  </main>
  <jsp:include page="${root}/footer.jsp"></jsp:include>
  
  <script>
    function confirmToDelete(text, path) {
      if (confirm(text) == true) window.location.replace(path);
  	}
  </script>
</body>
</html>