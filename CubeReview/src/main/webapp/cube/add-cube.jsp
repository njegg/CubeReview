<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>  
  
  
<!DOCTYPE html>
<html>
  <head>  
    <meta charset="UTF-8">
    <title>Add a cube</title>
  
    <%request.setAttribute("root", request.getContextPath());%>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">
    <link rel="stylesheet" href="${root}/styles/style.css">
    <link rel="stylesheet" href="${root}/styles/form.css">
    <link rel="stylesheet" href="${root}/styles/nav.css">
    <link rel="stylesheet" href="${root}/styles/review.css">
    
  </head>
  <body>
    <jsp:include page="${root}/nav.jsp"></jsp:include>
    
    <main>
      <div id="main-content">
        <h1>Add a new cube</h1>
      
        <f:form action="/cube/save-cube" method="post" modelAttribute="newCube">
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
                  <f:select items="${types}" path="cubeType" itemLabel="typeName" itemValue="cubeTypeId"></f:select> <br>
                </td>
              </tr>
              <tr>
                <td>Year:</td>
                <td>
                  <f:input path="releaseYear" />
                </td>
              </tr>
            </table>
            <input class="save-button" type="submit" value="Add a cube">
        </f:form>
      </div>
    </main>
  
    <jsp:include page="${root}/footer.jsp"></jsp:include>
  </body>
</html>