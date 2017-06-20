<!--
	copyright (c) 2016 Optimyth Software Technologies. All rights reserved.
-->

<%@page import="java.net.URLEncoder"%>
<%@page import="com.kiuwan.authentication.User"%>
<%@page import="com.kiuwan.authentication.TokenHandler"%>
<%@page import="org.keycloak.adapters.saml.SamlPrincipal"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
	/* User configuration section */
	/* Edit according your kiuwan user preferences */
	String ownerUsername = "owner@gmail.com";
	String clientId = "auth_1";
	String secretKey = "47isbdfdf2sjei5ug3vh34tll7k4s85g3ksu0i2ou09g1d8n2osats5uv8p5jguat7fm0e8ggjgn9lcjavfrvgd1s8v2iq3osj2jl1n";
	String kiuwanURL = "http://www.kiuwan.com/saas/web/dashboard/dashboard";
	String loginURL = "http://localhost:8080/kiuwan-sso-saml/error.jsp";
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf8">
        <title>Kiuwan SSO SAML application</title>

        <link rel="stylesheet" type="text/css" href="styles.css"/>
    </head>
    
    <body>
		<%
		System.out.println("profile.jsp ...");
    	String username = null;
        SamlPrincipal principal = (SamlPrincipal)request.getUserPrincipal();
 
        if (null != principal) {
            for (String attributeName: principal.getAttributeNames()) {
            	System.out.println("AttributeName: '" + attributeName + ", AttributeValue: '" + principal.getAttribute(attributeName) + "'");
            }
            username = principal.getAttribute("uid");
        } else {
        	System.out.println("ERROR: Principal is null.");        	
        }

        if (username == null ||  username.isEmpty()) {
			System.out.println("'username' is null or empty. Remote Address: " + request.getRemoteAddr());
			response.setStatus(HttpServletResponse.SC_FORBIDDEN);
			response.sendRedirect("index.jsp?error=USERNAME_IS_NULL_OR_EMPTY");
			return;
		}
		
		User user = new User(username);
		System.out.println("Authentication successfully: " + username + "(" + request.getRemoteAddr() + ")");
			
		TokenHandler.initSecret(secretKey);		
		String token = TokenHandler.createTokenForUser(user);
		
		response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
		
		String tokenParam = TokenHandler.TOKEN_PARAM_NAME + "=" + URLEncoder.encode(token, "UTF-8");
		String userParam = TokenHandler.USER_PARAM_NAME + "=" + URLEncoder.encode(ownerUsername, "UTF-8");
		String clientParam = TokenHandler.CLIENT_PARAM_NAME + "=" + URLEncoder.encode(clientId, "UTF-8");
		String loginUrlParam = TokenHandler.LOGIN_URL_PARAM_NAME + "=" + URLEncoder.encode(loginURL, "UTF-8");
		
		String location = kiuwanURL + "?" + userParam + "&" + clientParam + "&" + loginUrlParam + "&" + tokenParam;
		System.out.println("Redirecting to: " + location);
		
		response.setHeader("Location", location);
		%>

    </body>
</html>
