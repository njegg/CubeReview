<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
  <head>	
    <meta charset="UTF-8">
    <title>Search</title>
	
	<%request.setAttribute("root", request.getContextPath());%>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">
    <link rel="stylesheet" href="${root}/styles/style.css">
    <link rel="stylesheet" href="${root}/styles/form.css">
    <link rel="stylesheet" href="${root}/styles/nav.css">
    <link rel="stylesheet" href="${root}/styles/radio.css">
  </head>
<body>
  <jsp:include page="${root}/nav.jsp"></jsp:include>
  
  <main>
    <div id="main-content">
      <form action="/search/users" method="get">
        <input name="query" type="text" placeholder="Type something…">
        <input id="search-button" type="submit" value="Search">
      </form>
      
      <c:if test="${!empty msg}">
        <p class="err">${msg}</p>
      </c:if>
      <br>
      
      <c:if test="${!empty users}">
        <table class="all-table">
          <tr>
            <th>Username</th>
            <th>E-Mail</th>
            <th>Created on</th>
          </tr>
          <c:forEach items="${users}" var="u">
            <tr>
              <td class="cube-name-col">
                <a href="/user/${u.username}">
                  ${u.username}
                </a>
              </td>
              <td>
                ${u.email}
              </td>
              <td>
                ${u.creationTime}
              </td>
            </tr>
          </c:forEach>     
      </table>
      </c:if>

    </div>
  </main>
  <jsp:include page="${root}/footer.jsp"></jsp:include>
</body>
</html>