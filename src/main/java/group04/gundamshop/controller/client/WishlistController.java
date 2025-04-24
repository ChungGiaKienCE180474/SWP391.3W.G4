package group04.gundamshop.controller.client;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.User;
import group04.gundamshop.service.UserService;
import group04.gundamshop.service.WishlistService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/wishlist") // Định nghĩa route cơ bản cho tất cả các phương thức trong controller này là
                             // /wishlist
public class WishlistController {

    private final UserService userService; // Dịch vụ để tương tác với đối tượng User trong hệ thống
    private final WishlistService wishlistService; // Dịch vụ để quản lý các hành động với danh sách yêu thích
                                                   // (wishlist)

    // Constructor để inject các dịch vụ vào controller
    public WishlistController(UserService userService, WishlistService wishlistService) {
        this.userService = userService;
        this.wishlistService = wishlistService;
    }

    /**
     * Lấy đối tượng User từ session (nếu có).
     * 
     * @param session Phiên làm việc của người dùng.
     * @return Optional chứa User nếu có, ngược lại trả về Optional rỗng.
     */
    private Optional<User> getUserFromSession(HttpSession session) {
        String email = (String) session.getAttribute("email"); // Lấy email của người dùng từ session
        if (email == null || email.isEmpty()) { // Kiểm tra xem email có tồn tại trong session không
            System.out.println("No email found in session."); // Nếu không có email, in ra thông báo
            return Optional.empty(); // Trả về Optional rỗng
        }

        Optional<User> userOptional = userService.getUserByEmail(email); // Lấy thông tin người dùng từ cơ sở dữ liệu
                                                                         // bằng email
        if (userOptional.isEmpty()) { // Kiểm tra xem người dùng có tồn tại trong hệ thống không
            System.out.println("User not found for email: " + email); // Nếu không, in ra thông báo
        }
        return userOptional; // Trả về đối tượng Optional chứa User
    }

    /**
     * Hiển thị trang Wishlist của người dùng.
     * Nếu người dùng chưa đăng nhập, chuyển hướng về trang đăng nhập.
     * 
     * @param session Phiên làm việc của người dùng.
     * @param model   Đối tượng Model để truyền dữ liệu sang JSP.
     * @return Tên file JSP để hiển thị wishlist hoặc redirect về login.
     */
    @GetMapping("") // Phương thức xử lý GET yêu cầu đến /wishlist
    public String getWishlistPage(HttpSession session, Model model) {
        Optional<User> userOpt = getUserFromSession(session); // Lấy người dùng từ session
        if (userOpt.isEmpty()) { // Kiểm tra nếu người dùng không có trong session
            return "redirect:/login"; // Chuyển hướng đến trang đăng nhập nếu không có người dùng
        }

        User user = userOpt.get(); // Lấy đối tượng người dùng
        List<Product> wishlist = wishlistService.getWishlist(user); // Lấy danh sách các sản phẩm trong wishlist của
                                                                    // người dùng
        if (wishlist == null) { // Kiểm tra nếu wishlist là null
            wishlist = new ArrayList<>(); // Khởi tạo danh sách trống nếu null
        }

        model.addAttribute("wishlist", wishlist); // Truyền danh sách wishlist vào model để hiển thị trên trang JSP
        return "customer/wishlist/show"; // Trả về tên view JSP để hiển thị trang wishlist
    }

    /**
     * Lấy danh sách Wishlist dưới dạng JSON.
     * Dùng để gọi từ client-side nếu cần API.
     * 
     * @param session Phiên làm việc của người dùng.
     * @return ResponseEntity chứa danh sách sản phẩm trong wishlist hoặc lỗi 401
     *         nếu chưa đăng nhập.
     */
    @GetMapping("/json") // Phương thức xử lý GET yêu cầu đến /wishlist/json
    @ResponseBody // Đảm bảo trả về dữ liệu dạng JSON
    public ResponseEntity<?> getWishlist(HttpSession session) {
        Optional<User> userOpt = getUserFromSession(session); // Lấy người dùng từ session
        if (userOpt.isEmpty()) { // Nếu người dùng không có trong session
            return ResponseEntity.status(401).body("User not logged in"); // Trả về mã lỗi 401 nếu chưa đăng nhập
        }

        List<Product> wishlist = wishlistService.getWishlist(userOpt.get()); // Lấy danh sách wishlist của người dùng
        return ResponseEntity.ok(wishlist); // Trả về danh sách wishlist dưới dạng JSON
    }

    /**
     * Thêm sản phẩm vào wishlist của người dùng.
     * 
     * @param productId ID của sản phẩm cần thêm.
     * @param session   Phiên làm việc của người dùng.
     * @return ResponseEntity chứa thông báo thành công hoặc thất bại.
     */
    @PostMapping("/add/{productId}")
    @ResponseBody
    @Transactional
    public ResponseEntity<?> addToWishlist(@PathVariable Long productId, HttpSession session) {
        // Lấy thông tin người dùng từ session
        Optional<User> userOpt = getUserFromSession(session);

        // Nếu chưa đăng nhập, trả về lỗi 401 (Unauthorized)
        if (userOpt.isEmpty()) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "User not logged in");
            return ResponseEntity.status(401) // Trạng thái HTTP 401
                    .contentType(MediaType.APPLICATION_JSON) // Trả về dưới dạng JSON
                    .body(errorResponse); // Gửi thông điệp lỗi
        }

        // Nếu người dùng đã đăng nhập, lấy đối tượng User
        User user = userOpt.get();
        System.out.println("Adding product ID: " + productId + " to wishlist for user: " + user.getEmail());

        // Gọi service để thêm sản phẩm vào wishlist
        boolean added = wishlistService.addToWishlist(user, productId);

        // Cập nhật lại số lượng sản phẩm trong wishlist và lưu vào session
        int wishlistSize = wishlistService.getWishlist(user).size();
        session.setAttribute("wishlistSize", wishlistSize);

        // Nếu sản phẩm đã tồn tại trong wishlist, trả về lỗi 400 (Bad Request)
        if (!added) {
            System.out.println("Product already in wishlist!");
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "Already in Wishlist!");
            return ResponseEntity.status(400) // Trạng thái HTTP 400
                    .contentType(MediaType.APPLICATION_JSON) // Trả về dưới dạng JSON
                    .body(errorResponse); // Gửi thông điệp lỗi
        }

        // Nếu thêm thành công, tạo map chứa thông tin phản hồi
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("message", "Add to wishlist successfully!"); // Thông báo thành công
        responseMap.put("redirectUrl", "/product/details/" + productId); // URL chuyển hướng (nếu cần)
        responseMap.put("wishlistSize", wishlistSize); // Số lượng sản phẩm hiện tại trong wishlist

        // Trả về phản hồi thành công với mã HTTP 200
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON) // Trả về dưới dạng JSON
                .body(responseMap); // Gửi dữ liệu phản hồi
    }

    /**
     * Xóa sản phẩm khỏi wishlist.
     * 
     * @param productId          ID của sản phẩm cần xóa.
     * @param session            Phiên làm việc của người dùng.
     * @param redirectAttributes Dùng để gửi thông báo khi redirect.
     * @return Redirect về trang wishlist.
     */
    @PostMapping("/remove/{productId}") // Phương thức xử lý POST yêu cầu xóa sản phẩm khỏi wishlist
    @Transactional // Đảm bảo việc thay đổi trong cơ sở dữ liệu được thực hiện như một giao dịch
    public String removeFromWishlist(@PathVariable Long productId, HttpSession session,
            RedirectAttributes redirectAttributes) {
        Optional<User> userOpt = getUserFromSession(session); // Lấy người dùng từ session
        if (userOpt.isEmpty()) { // Nếu người dùng không có trong session
            redirectAttributes.addFlashAttribute("error", "User not logged in"); // Thêm thông báo lỗi vào
                                                                                 // FlashAttributes
            return "redirect:/wishlist"; // Chuyển hướng về trang wishlist
        }

        User user = userOpt.get(); // Lấy đối tượng người dùng
        boolean removed = wishlistService.removeFromWishlist(user, productId); // Thực hiện xóa sản phẩm khỏi wishlist

        if (!removed) { // Nếu không thể xóa (sản phẩm không có trong wishlist)
            redirectAttributes.addFlashAttribute("error", "Product not in wishlist!"); // Thêm thông báo lỗi vào
                                                                                       // FlashAttributes
        } else {
            redirectAttributes.addFlashAttribute("success", "Product removed successfully"); // Thêm thông báo thành
                                                                                             // công vào FlashAttributes
            // Cập nhật lại số lượng sản phẩm trong wishlist vào session
            int wishlistSize = wishlistService.getWishlist(user).size(); // Lấy số lượng sản phẩm trong wishlist
            session.setAttribute("wishlistSize", wishlistSize); // Cập nhật vào session
        }

        return "redirect:/wishlist"; // Chuyển hướng về trang wishlist
    }
}
