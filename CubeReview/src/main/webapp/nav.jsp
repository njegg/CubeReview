<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./styles/nav.css" />
    <title>Navigation bar</title>
    
    <script>
	  function toggleMobileMenu(menu) {
	    menu.classList.toggle('open');
	  }
    </script>
  </head>
  <body>
    <header>
    <div class="rainbow-text" style="text-align: center;">
		<span class="block-line">CubeReview</span>
	</div>
     <!--  <div id="brand"><a href="/">CubeReview </a></div> -->
      <nav>
        <ul>
          <li><a href="/">Home</a></li>
          
          <s:authorize access="isAuthenticated()">
          
            <li>
              <a href="/user/<s:authentication property="principal.username" />">
                 <s:authentication property="principal.username" />
              </a>
            </li>
            
            <li id="login">
              <a href="/auth/logout" >
                Log out
              </a>
            </li>
		  
		  </s:authorize>
		  
		  <s:authorize access="!isAuthenticated()">
          
            <li id="login"><a href="/auth/login" >Log in</a></li>
            <li id="signup"><a href="/auth/register">Sign up</a></li>
          
		  </s:authorize>
        </ul>
      </nav>
      <div id="hamburger-icon" onclick="toggleMobileMenu(this)">
        <div class="bar1"></div>
        <div class="bar2"></div>
        <div class="bar3"></div>
        <ul class="mobile-menu">
          <li><a href="/">Home</a></li>
          
          <s:authorize access="isAuthenticated()">
          
            <li>
              <a href="/">
                <s:authentication property="principal.username" /> 
              </a>
            </li>
            
            <li id="login">
              <a href="/auth/logout" >
                Log out
              </a>
            </li>
		  
		  </s:authorize>
		  
		  <s:authorize access="!isAuthenticated()">
          
            <li id="login"><a href="/auth/login" >Log in</a></li>
            <li id="signup"><a href="/auth/register">Sign up</a></li>
          
		  </s:authorize>
        </ul>
      </div>
    </header>
    
  </body>
</html>
