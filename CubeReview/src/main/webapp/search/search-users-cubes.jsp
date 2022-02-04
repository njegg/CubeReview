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
      <form action="/search" method="get">
        <input name="query" type="text" placeholder="Type something">
        <input id="search-button" type="submit" value="Search">

        <p>        
        <input type="radio" id="users" name="type" value="users" checked>
        <label for="users">Users</label>
        
        <input type="radio" id="cubes" name="type" value="cubes">
        <label for="cubes">Cubes</label>
        </p>
        
      </form>
      
      <c:if test="${!empty msg}">
        <p class="err">${msg}</p>
      </c:if>

      <hr>
      
      <c:if test="${!empty users}">
        <c:forEach items="${users}" var="u">
          <b>
            <a href="/user/${u.username}">
              ${u.username}
            </a>
          </b>
          <span class="ver-line">&#65372</span> ${u.email} <span class="ver-line">&#65372</span> ${u.creationTime}
          <br>          
        </c:forEach> 
      </c:if>

      <c:if test="${!empty cubes}">
        <c:forEach items="${cubes}" var="c">
          <b>
            <a href="/cube/${c.cubeId}">
              ${c.name}
            </a>
          </b>
          <span class="ver-line">&#65372</span> ${c.cubeType.typeName} <span class="ver-line">&#65372</span> ${c.releaseYear}
          <br>
        </c:forEach> 
      </c:if>
      
    </div>
  </main>
  <jsp:include page="${root}/footer.jsp"></jsp:include>
</body>
</html>