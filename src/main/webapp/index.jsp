<!--
	copyright (c) 2016 Optimyth Software Technologies. All rights reserved.
-->

<%@page import="com.kiuwan.authentication.Controller"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf8">
        <title>Kiuwan SSO SAML application</title>

        <link rel="stylesheet" type="text/css" href="styles.css"/>
    </head>
    <body>
		<%
		response.sendRedirect("profile.jsp");		
		%>

		<div>
			<div>Please login</div>
			</br>
            <div>
                <button onclick="location.href = 'profile.jsp'" type="button">Login in Kiuwan</button>
            </div>
        </div>
    </body>
</html>
