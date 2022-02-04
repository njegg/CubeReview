<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
  <c:forEach items="${reviews}" var="r">
        <div class="review-post">
          <span class="up-down"></span>
          
          <span class="review">
            <a href="/user/${r.user.username}">${r.user.username}  </a>
            <span class="post-time">at: ${r.creationTime}</span>
            <br>
             
            <c:forEach begin="1" end="${r.rating}" varStatus="loop">
                <span class="star">
                  ☆
                </span>
            </c:forEach>
            <br>
  
            ${r.content}
          </span>
        </div>
      </c:forEach>
</body>
</html>