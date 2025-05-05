package group04.gundamshop.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.dto.ProductCriteriaDTO;
import group04.gundamshop.service.ProductService;

@Controller
public class ProductSearchController {

    private final ProductService productService;

    public ProductSearchController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/search/advanced")
    public String advancedSearch(
            @RequestParam(value = "scale", required = false) List<String> scales,
            @RequestParam(value = "material", required = false) List<String> materials,
            @RequestParam(value = "dimensionsMin", required = false) Double dimensionsMin,
            @RequestParam(value = "dimensionsMax", required = false) Double dimensionsMax,
            @RequestParam(value = "weightMin", required = false) Double weightMin,
            @RequestParam(value = "weightMax", required = false) Double weightMax,
            @RequestParam(value = "priceMin", required = false) Double priceMin,
            @RequestParam(value = "priceMax", required = false) Double priceMax,
            @RequestParam(value = "price", required = false) List<String> prices,
            @RequestParam(value = "sort", required = false) String sort,
            @RequestParam(value = "factory", required = false) List<String> factories,
            @RequestParam(value = "target", required = false) List<String> targets,
            @RequestParam(value = "page", defaultValue = "0") int page,
            Model model) {

        // Validate inputs: no negative numbers, priceMin and priceMax >= 1000
        if (dimensionsMin != null && dimensionsMin < 0) {
            dimensionsMin = 0.0;
        }
        if (dimensionsMax != null && dimensionsMax < 0) {
            dimensionsMax = 0.0;
        }
        if (weightMin != null && weightMin < 0) {
            weightMin = 0.0;
        }
        if (weightMax != null && weightMax < 0) {
            weightMax = 0.0;
        }
        if (priceMin != null && priceMin < 1000) {
            priceMin = 1000.0;
        }
        if (priceMax != null && priceMax < 1000) {
            priceMax = 1000.0;
        }

        Pageable pageable = PageRequest.of(page, 9);

        boolean noFilters = (scales == null || scales.isEmpty()) &&
                            (materials == null || materials.isEmpty()) &&
                            dimensionsMin == null &&
                            dimensionsMax == null &&
                            weightMin == null &&
                            weightMax == null &&
                            priceMin == null &&
                            priceMax == null &&
                            (sort == null || sort.isEmpty()) &&
                            (factories == null || factories.isEmpty()) &&
                            (targets == null || targets.isEmpty());

        // Build queryString for pagination links to preserve filters
        StringBuilder queryStringBuilder = new StringBuilder();

        if (scales != null && !scales.isEmpty()) {
            queryStringBuilder.append("&scale=").append(String.join(",", scales));
        }
        if (materials != null && !materials.isEmpty()) {
            queryStringBuilder.append("&material=").append(String.join(",", materials));
        }
        if (factories != null && !factories.isEmpty()) {
            for (String factory : factories) {
                queryStringBuilder.append("&factory=").append(factory);
            }
        }
        if (targets != null && !targets.isEmpty()) {
            for (String target : targets) {
                queryStringBuilder.append("&target=").append(target);
            }
        }
        if (dimensionsMin != null) {
            queryStringBuilder.append("&dimensionsMin=").append(dimensionsMin);
        }
        if (dimensionsMax != null) {
            queryStringBuilder.append("&dimensionsMax=").append(dimensionsMax);
        }
        if (weightMin != null) {
            queryStringBuilder.append("&weightMin=").append(weightMin);
        }
        if (weightMax != null) {
            queryStringBuilder.append("&weightMax=").append(weightMax);
        }
        if (prices != null && !prices.isEmpty()) {
            for (String price : prices) {
                queryStringBuilder.append("&price=").append(price);
            }
        }
        if (sort != null && !sort.isEmpty()) {
            queryStringBuilder.append("&sort=").append(sort);
        }

        ProductCriteriaDTO criteria = new ProductCriteriaDTO();

        // Set scale filter
        if (scales != null && !scales.isEmpty()) {
            criteria.setScale(java.util.Optional.of(scales));
        }

        // Set material filter
        if (materials != null && !materials.isEmpty()) {
            criteria.setMaterial(java.util.Optional.of(materials));
        }

        // Set factory filter
        if (factories != null && !factories.isEmpty()) {
            criteria.setFactory(java.util.Optional.of(factories));
        }

        // Set target filter
        if (targets != null && !targets.isEmpty()) {
            criteria.setTarget(java.util.Optional.of(targets));
        }

        // Set range filters
        if (dimensionsMin != null) {
            criteria.setDimensionsMin(java.util.Optional.of(dimensionsMin));
        }
        if (dimensionsMax != null) {
            criteria.setDimensionsMax(java.util.Optional.of(dimensionsMax));
        }
        if (weightMin != null) {
            criteria.setWeightMin(java.util.Optional.of(weightMin));
        }
        if (weightMax != null) {
            criteria.setWeightMax(java.util.Optional.of(weightMax));
        }
        if (priceMin != null) {
            criteria.setPriceMin(java.util.Optional.of(priceMin));
        }
        if (priceMax != null) {
            criteria.setPriceMax(java.util.Optional.of(priceMax));
        }

        if (prices != null && !prices.isEmpty()) {
            criteria.setPrice(java.util.Optional.of(prices));
        }

        // Set sort parameter
        if (sort != null && !sort.isEmpty()) {
            criteria.setSort(java.util.Optional.of(sort));
        }

        // Set page parameter as string
        criteria.setPage(java.util.Optional.of(String.valueOf(page)));

        // First fetch to get total pages
        Page<Product> initialProductPage = productService.fetchProductsWithSpec(pageable, criteria);

        // Adjust page if requested page exceeds total pages
        if (page >= initialProductPage.getTotalPages() && initialProductPage.getTotalPages() > 0) {
            pageable = PageRequest.of(initialProductPage.getTotalPages() - 1, 9);
        }

        Page<Product> productPage = productService.fetchProductsWithSpec(pageable, criteria);

        model.addAttribute("products", productPage.getContent());
        model.addAttribute("currentPage", pageable.getPageNumber());
        model.addAttribute("totalPages", productPage.getTotalPages());

        // Add filter values back to model for form repopulation
        model.addAttribute("selectedScales", scales != null ? scales : new java.util.ArrayList<>());
        model.addAttribute("selectedMaterials", materials != null ? materials : new java.util.ArrayList<>());
        model.addAttribute("selectedFactories", factories != null ? factories : new java.util.ArrayList<>());
        model.addAttribute("selectedTargets", targets != null ? targets : new java.util.ArrayList<>());
        model.addAttribute("selectedPrices", prices != null ? prices : new java.util.ArrayList<>());
        model.addAttribute("dimensionsMin", dimensionsMin);
        model.addAttribute("dimensionsMax", dimensionsMax);
        model.addAttribute("weightMin", weightMin);
        model.addAttribute("weightMax", weightMax);
        model.addAttribute("priceMin", priceMin);
        model.addAttribute("priceMax", priceMax);
        model.addAttribute("sort", sort);

        model.addAttribute("factories", productService.getAllFactoryObjects());
        model.addAttribute("targets", productService.getAllTargetObjects());
        model.addAttribute("scales", productService.getAllScales());
        model.addAttribute("materials", productService.getAllMaterials());

        model.addAttribute("queryString", queryStringBuilder.toString());

        return "customer/search/advanced_search";
    }
}
