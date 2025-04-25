package group04.gundamshop.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import group04.gundamshop.service.NewsService;

/**
 * Controller for customer news pages.
 */
@Controller
public class CustomerNewsController {

    private final NewsService newsService;

    @Autowired
    public CustomerNewsController(NewsService newsService) {
        this.newsService = newsService;
    }

    /**
     * Show list of active news for customers.
     * @param model Model to hold attributes.
     * @return customer news list view.
     */
    @GetMapping("/customer/news")
    public String showActiveNewsList(Model model) {
        model.addAttribute("newsList", newsService.getActiveNews());
        return "customer/news/list";
    }
}
