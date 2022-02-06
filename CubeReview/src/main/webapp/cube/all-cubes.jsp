<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
  <head>	
    <meta charset="UTF-8">
    <title>List of all cubes</title>
		
    <%request.setAttribute("root", request.getContextPath());%>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">
    <link rel="stylesheet" href="${root}/styles/style.css">
    <link rel="stylesheet" href="${root}/styles/form.css">
    <link rel="stylesheet" href="${root}/styles/nav.css">
  </head>
<body>
  <jsp:include page="${root}/nav.jsp"></jsp:include>
  
  <main>
    <div id="main-content">
      
      <c:choose>
        <c:when test="${showBest}">
          <h2>Best rated cubes</h2>   
          <a href="/cube/all">Show all</a>   
        </c:when>
        
        <c:otherwise>
          <h2>All cubes</h2>   
          <a href="/cube/sorted-rating">Show best rated</a>   
        </c:otherwise>
      </c:choose>
      
      <s:authorize access="hasAnyRole('ADMIN', 'MOD')">
        <br>
        <a href="/cube/add-cube">Add a new cube</a> 
      </s:authorize>

      <form action="/cube/search" method="get">
        <input name="query" type="text" class="search-text" placeholder="Search by name, type or release year">
        <input id="search-button" type="submit" value="Search">
      </form>
      <br>
      <hr>
      
      <table class="all-table">
          <tr>
            <th>Cube</th>
            <th>Type</th>
            <th>Release Year</th>
          </tr>
        <c:forEach items="${cubes}" var="c">
          <tr>
            <td class="cube-name-col">
              <a href="/cube/${c.cubeId}">${c.name}</a>
            </td>
            <td>
              ${c.cubeType.typeName}
            </td>
            <td>
              ${c.releaseYear}
            </td>
          </tr>
        </c:forEach>     
      </table>
      <hr>
      
      <s:authorize access="hasRole('USER')">
        Cant find your cube? Send us a request <a href="/cube/request.jsp">here</a>!
        <br>
        You can also check <a href="/request/userRequests">all your past requests</a>
      </s:authorize>
      <s:authorize access="!isAuthenticated()">
        Cant find your cube? <a href="/auth/login">Log in </a> to send us a request.
      </s:authorize>
      
      <s:authorize access="hasAnyRole('MOD', 'ADMIN')">
        List of <a href="/request/all">all user cube requests</a>
      </s:authorize>
    </div>
  </main>
  
  <jsp:include page="${root}/footer.jsp"></jsp:include>
</body>
</html>
