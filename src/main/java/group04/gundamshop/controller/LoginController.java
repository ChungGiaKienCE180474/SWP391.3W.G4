package group04.gundamshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {
    @GetMapping("/login")
    public String getLogin(Model model) {
        return "authentication/login";
    }

    @GetMapping("/access-deny")
    public String getDeny(Model model) {
        return "authentication/deny";
    }

}
