package group04.gundamshop.controller.client;

//import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class CareServiceController {
    
    @GetMapping("/careservice")
    public String showCareService() {
        return "customer/careservice/careservice";  // This will look for care-service.jsp in your views directory
    }
    
    @GetMapping("/book-service/{type}")
    public String bookService(@PathVariable String type, Model model) {
        // Add booking logic here
        model.addAttribute("serviceType", type);
        return "book-service";  // Create this view for booking form
    }
}