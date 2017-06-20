/**
 * copyright (c) 2016 Optimyth Software Technologies. All rights reserved.
 */
package com.kiuwan.authentication;

import javax.servlet.http.HttpServletRequest;
import org.keycloak.adapters.saml.SamlPrincipal;

/**
 * Controller simplifies access to the server environment from the JSP.
 */
public class Controller {

    public static String getFirstName(HttpServletRequest req) {
        return getFriendlyAttrib(req, "givenName");
    }

    public static String getLastName(HttpServletRequest req) {
        return getFriendlyAttrib(req, "surname");
    }

    public static String getEmail(HttpServletRequest req) {
        return getFriendlyAttrib(req, "email");
    }

    public static String getUsername(HttpServletRequest req) {
    	String username = null;
    	String usernameAttributeName = "uid";
        SamlPrincipal principal = (SamlPrincipal)req.getUserPrincipal();
 
        if (null != principal) {
            for (String attributeName: principal.getAttributeNames()) {
            	System.out.println("AttributeName: '" + attributeName + ", AttributeValue: '" + principal.getAttribute(attributeName) + "'");
            }
            username = principal.getAttribute(usernameAttributeName);
        } else {
        	System.out.println("ERROR: Principal is null.");        	
        }
        
        return username;
    }

    private static String getFriendlyAttrib(HttpServletRequest req, String attribName) {
        SamlPrincipal principal = getAccount(req);
        return principal.getFriendlyAttribute(attribName);
    }

    private static SamlPrincipal getAccount(HttpServletRequest req) {
        SamlPrincipal principal = (SamlPrincipal)req.getUserPrincipal();
        return principal;
    }

    public static boolean isLoggedIn(HttpServletRequest req) {
        return getAccount(req) != null;
    }
    
}
