<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<html lang="en">
<head>
<meta charset="UTF-8">
<title>Join CubeReview</title>
<link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700"
  rel="stylesheet">

<%request.setAttribute("root", request.getContextPath());%>
<link rel="stylesheet" href="${root}/styles/style.css">
<link rel="stylesheet" href="${root}/styles/form.css">
<link rel="stylesheet" href="${root}/styles/nav.css">

<!-- icons -->
<script src='https://kit.fontawesome.com/a076d05399.js'
  crossorigin='anonymous'></script>
<link rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
  rel="stylesheet">

</head>
<body>
  <jsp:include page="${root}/nav.jsp"></jsp:include>
  <div class="grid">

    <c:if test="${!empty msgerr}">
      <p class="login-error">
        <span> <i class="material-icons" style="color: #b71234">error_outline</i>
        </span> <span id="login-error-text"> ${msgerr} </span>
      </p>
    </c:if>

    <f:form action="/auth/save-user" method="post"
      modelAttribute="newUser" class="form login">

      <div class="form__field">
        <label for="login__username"> <span> <i
            class='fas fa-user-circle' style='color: #b71234'></i>
        </span>
        </label>
        <f:input id="login__username" type="text" path="username"
          class="form__input" placeholder="username" required="" />
      </div>

      <div class="form__field">
        <label for="login__password"> <span> <i
            class='fas fa-shield-alt' style='color: #009b48'></i>
        </span>
        </label>
        <f:input id="login__password" type="password" path="password"
          class="form__input" placeholder="********" required="" />
      </div>

      <div class="form__field">
        <label for="login__username"> <span> <i
            class="fa fa-envelope-o" style="color: #1d58ad"></i>
        </span>
        </label>
        <f:input id="login__username" type="text" path="email"
          class="form__input" placeholder="Email" required="" />
      </div>

      <div class="form__field">
        <input type="submit" value="Sign Up">
      </div>

    </f:form>

    <p class="text--center">
      Already have an account?<br> <a href="/auth/login">Log
        in!</a>
    </p>

  </div>
</body>
</html>