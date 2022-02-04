<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add a new Cube</title>
</head>
<body>
  <h1>Add a new cube</h1>
    
  <f:form action="/cube/save-cube" method="post" modelAttribute="newCube">
    name: <f:input path="name" /> <br>
    release year: <f:input path="releaseYear" /> <br>
    <f:select items="${types}" path="cubeType" itemLabel="typeName" itemValue="cubeTypeId"></f:select> <br>
    <input class="save-button" type="submit" value="Add a cube">
  </f:form>
  
</body>
</html>