package group04.gundamshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AboutUsController {

    @GetMapping("/aboutus")
    public String aboutUsPage() {
        return "customer/aboutus/aboutus";
    }
}