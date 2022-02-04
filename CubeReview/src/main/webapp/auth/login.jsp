<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="en"><head>
  <meta charset="UTF-8">
  <title>Login to CubeReview</title>
  
  <%request.setAttribute("root", request.getContextPath());%>
  <link rel="stylesheet" href="${root}/styles/style.css">
  <link rel="stylesheet" href="${root}/styles/form.css">
  <link rel="stylesheet" href="${root}/styles/nav.css">

  <!-- icons -->
  <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  
</head>
<body>

  <jsp:include page="${root}/nav.jsp"></jsp:include>
  <div class="grid">
	
	<c:if test="${!empty msgerr}">
      <p class="login-error">
        <span>
          <i class="material-icons" style="color: #b71234">error_outline</i>
        </span>
        <span id="login-error-text">
          ${msgerr}
        </span>
      </p>
	</c:if>
	
	<c:if test="${!empty msgsucc}">
      <p class="login-error">
        <span>
          <i class="fa fa-check" id="succ-reg" style="color: #009b48"></i>
        </span>
        <span id="login-error-text">
          ${msgsucc}
        </span>
      </p>
	</c:if>
	
    <form action="/login" method="post" class="form login">
	  
	
      <div class="form__field">
        <label for="login__username">
			<i class='fas fa-user-circle' style='color: #b71234'></i>
		</label>
        <input id="login__username" type="text" name="username" class="form__input" placeholder="username" required="">
      </div>

      <div class="form__field">
        <label for="login__password">
        	<i class='fas fa-shield-alt' style='color: #009b48'></i>
        </label>
        <input id="login__password" type="password" name="password" class="form__input" placeholder="********" required="">
      </div>

      <div class="form__field">
        <input type="submit" value="Log In">
      </div>

    </form>

    <p class="text--center">
    	Don't have an account?<br>
    	<a href="/auth/register">Join the CubeReview community!</a>
    </p>

  </div>
  
</body>
</html>