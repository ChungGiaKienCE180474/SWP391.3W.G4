package group04.gundamshop.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;


@Service
public class UploadNewsService {
    // Thư mục gốc để lưu ảnh (nằm trong thư mục static)
    private static final String UPLOAD_DIR = "src/main/resources/static/upload/";

    public String handleSaveUploadFile(MultipartFile file, String targetFolder) {
        if (file.isEmpty()) {
            return ""; // Không có file upload
        }

        try {
            // Tạo thư mục nếu chưa tồn tại
            Path uploadPath = Paths.get(UPLOAD_DIR + targetFolder);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Tạo tên file duy nhất
            String fileName = UUID.randomUUID().toString() + "-" + file.getOriginalFilename();

            // Lưu file vào thư mục
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(file.getInputStream(), filePath);

            // Trả về đường dẫn tương đối để truy cập từ trình duyệt
            return "/upload/" + targetFolder + "/" + fileName;
        } catch (IOException e) {
            e.printStackTrace();
            return ""; // Xử lý lỗi
        }
    }
}
