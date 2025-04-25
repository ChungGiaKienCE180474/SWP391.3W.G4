package group04.gundamshop.config;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.session.security.web.authentication.SpringSessionRememberMeServices;
import group04.gundamshop.domain.User;
import group04.gundamshop.service.UserService;
import group04.gundamshop.service.validator.CustomUserDetailsService;
import jakarta.servlet.DispatcherType;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Configuration
@EnableMethodSecurity(securedEnabled = true) // Bật hỗ trợ bảo mật phương thức (method security), cho phép sử dụng
                                             // @Secured trong các controller
public class SecurityConfiguration {

        @Autowired
        private UserService userService; // Inject service UserService vào để truy vấn dữ liệu người dùng

        @Bean
        public PasswordEncoder passwordEncoder() {
                // Định nghĩa PasswordEncoder sử dụng BCryptPasswordEncoder để mã hóa mật khẩu
                return new BCryptPasswordEncoder();
        }

        @Bean
        public UserDetailsService userDetailsService(UserService userService) {
                // Cung cấp CustomUserDetailsService với UserService để load dữ liệu người dùng
                // từ database
                return new CustomUserDetailsService(userService);
        }

        @Bean
        public DaoAuthenticationProvider authProvider(
                        PasswordEncoder passwordEncoder,
                        UserDetailsService userDetailsService) {

                DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
                authProvider.setUserDetailsService(userDetailsService); // Sử dụng userDetailsService đã định nghĩa
                authProvider.setPasswordEncoder(passwordEncoder); // Sử dụng PasswordEncoder
                authProvider.setHideUserNotFoundExceptions(false); // Đảm bảo khi người dùng không tìm thấy sẽ không bị
                                                                   // ẩn lỗi

                return authProvider;
        }

        @Bean
        public AuthenticationSuccessHandler customSuccessHandler() {
                // Định nghĩa handler để xử lý sau khi người dùng đăng nhập thành công
                return new CustomSuccessHandler();
        }

        @Bean
        public SpringSessionRememberMeServices rememberMeServices() {
                SpringSessionRememberMeServices rememberMeServices = new SpringSessionRememberMeServices();
                rememberMeServices.setAlwaysRemember(true); // Đảm bảo rằng người dùng luôn được nhớ khi đăng nhập
                return rememberMeServices;
        }

        @Bean
        SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

                http
                                .authorizeHttpRequests(authorize -> authorize
                                                // Quy định các URL mà không cần xác thực (cho phép mọi người truy cập)
                                                .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE)
                                                .permitAll()
                                                .requestMatchers("/", "/login", "/register", "/client/**", "/css/**",
                                                                "/js/**", "/images/**", "/upload/**",
                                                                "/forgotpassword", "/authentication/**", "/product/**",
                                                                "/products",
                                                                "/search/**", "/authentication/enterRegisterOTP",
                                                                "/aboutus", "/voucher/**",
                                                                "/category/**", "/news/**", "/careservice/**")
                                                .permitAll()
                                                // Quy định các URL yêu cầu quyền truy cập theo vai trò người dùng
                                                .requestMatchers("/admin/**").hasRole("ADMIN")
                                                .requestMatchers("/employee/**").hasRole("EMPLOYEE")
                                                .requestMatchers("/customer/**").hasRole("CUSTOMER")
                                                .anyRequest().authenticated()) // Yêu cầu xác thực cho tất cả các yêu
                                                                               // cầu khác

                                .sessionManagement(sessionManagement -> sessionManagement
                                                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED) // Chỉ tạo
                                                                                                          // session nếu
                                                                                                          // cần thiết
                                                .invalidSessionUrl("/logout?expired") // Nếu session hết hạn, chuyển
                                                                                      // hướng tới logout
                                                .maximumSessions(1) // Chỉ cho phép 1 session cho mỗi người dùng
                                                .maxSessionsPreventsLogin(false)) // Không chặn người dùng đăng nhập nếu
                                                                                  // đã đạt số lượng session tối đa

                                .logout(logout -> logout
                                                .deleteCookies("JSESSIONID") // Xóa cookie khi đăng xuất
                                                .invalidateHttpSession(true)) // Xóa session khi đăng xuất

                                .rememberMe(r -> r
                                                .rememberMeServices(rememberMeServices())) // Cấu hình dịch vụ "Nhớ tôi"
                                                                                           // (remember me)

                                .formLogin(formLogin -> formLogin
                                                .loginPage("/login") // Chỉ định trang đăng nhập
                                                .failureHandler(this::handleLoginFailure) // Xử lý lỗi khi đăng nhập
                                                                                          // thất bại
                                                .successHandler(customSuccessHandler()) // Xử lý sau khi đăng nhập thành
                                                                                        // công
                                                .permitAll()) // Cho phép truy cập trang đăng nhập mà không cần xác thực

                                .exceptionHandling(ex -> ex
                                                .accessDeniedPage("/access-deny")); // Trang lỗi khi người dùng không có
                                                                                    // quyền truy cập

                return http.build();
        }

        // Phương thức xử lý khi đăng nhập thất bại
        private void handleLoginFailure(HttpServletRequest request, HttpServletResponse response,
                        org.springframework.security.core.AuthenticationException exception) throws IOException {
                String email = request.getParameter("username");
                User user = userService.getUserByEmail(email).orElse(null); // Kiểm tra thông tin người dùng qua email

                if (user != null) {
                        if (!user.isStatus()) {
                                // Nếu tài khoản bị khóa, thông báo cho người dùng
                                request.getSession().setAttribute("message", "Your Account was BAN");
                                response.sendRedirect("/login?locked"); // Chuyển hướng tới trang đăng nhập với thông
                                                                        // báo khóa tài khoản
                        } else {
                                response.sendRedirect("/login?error"); // Chuyển hướng tới trang đăng nhập với thông báo
                                                                       // lỗi
                        }
                } else {
                        response.sendRedirect("/login?error"); // Nếu người dùng không tồn tại, chuyển hướng tới trang
                                                               // đăng nhập với lỗi
                }
        }
}
