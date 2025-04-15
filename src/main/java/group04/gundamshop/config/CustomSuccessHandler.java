package group04.gundamshop.config;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import group04.gundamshop.domain.User;
import group04.gundamshop.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CustomSuccessHandler implements AuthenticationSuccessHandler {
    @Autowired
    private UserService userService;

    protected String determineTargetUrl(final Authentication authentication) {

        Map<String, String> roleTargetUrlMap = new HashMap<>();
        roleTargetUrlMap.put("ROLE_CUSTOMER", "/");
        roleTargetUrlMap.put("ROLE_EMPLOYEE", "/employee/order");
        roleTargetUrlMap.put("ROLE_ADMIN", "/admin");

        final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (final GrantedAuthority grantedAuthority : authorities) {
            String authorityName = grantedAuthority.getAuthority();
            if (roleTargetUrlMap.containsKey(authorityName)) {
                return roleTargetUrlMap.get(authorityName);
            }
        }

        throw new IllegalStateException();
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request, Authentication authentication) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        // get email
        String email = authentication.getName();
        // query
        User user = userService.getUserByEmail(email).orElse(null);
        if (user != null) {
            session.setAttribute("username", user.getEmail());
            session.setAttribute("avatar", user.getAvatar());
            session.setAttribute("id", user.getId());
            session.setAttribute("email", user.getEmail());
            int sum = user.getCart() == null ? 0 : user.getCart().getSum();
            session.setAttribute("sum", sum);

        }

    }

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        // Get the email from the authentication object
        String email = authentication.getName();

        // Query the user based on the email
        User user = userService.getUserByEmail(email).orElse(null);

        // Redirect to /login?locked if the account is disabled
        if (!user.isStatus()) {
            // Redirect to login with a parameter indicating the account is locked
            response.sendRedirect("/login?locked");
            return;
        }
        // If the account is active, determine the target URL based on the role
        String targetUrl = determineTargetUrl(authentication);

        // Check if the response has already been committed
        if (response.isCommitted()) {
            return;
        }

        // Redirect to the target URL
        redirectStrategy.sendRedirect(request, response, targetUrl);

        // Clear authentication attributes (e.g., exceptions) and set user details in
        // the session
        clearAuthenticationAttributes(request, authentication);

    }

}

