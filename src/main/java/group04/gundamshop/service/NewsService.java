package group04.gundamshop.service;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import group04.gundamshop.domain.News;
import group04.gundamshop.repository.NewsRepository;

@Service
public class NewsService {
    private static final Logger logger = LoggerFactory.getLogger(NewsService.class);
    private final NewsRepository newsRepository;

    @Autowired
    public NewsService(NewsRepository newsRepository) {
        this.newsRepository = newsRepository;
    }

    public List<News> getAllNews() {
        logger.info("Fetching all news...");
        return newsRepository.findAll();
    }

    public List<News> getActiveNews() {
        logger.info("Fetching active news with status = true...");
        return newsRepository.findByStatusTrue();
    }

    public News getNewsById(Long id) {
        return newsRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("News not found with id: " + id));
    }


    public News saveNews(News news) {
        logger.info("Saving news: {}", news.getTitle());
        if (news.getTitle() == null || news.getTitle().trim().isEmpty()) {
            throw new IllegalArgumentException("News title cannot be empty");
        }
        if (news.getContent() == null || news.getContent().trim().isEmpty()) {
            throw new IllegalArgumentException("News content cannot be empty");
        }
        return newsRepository.save(news);
    }

    public java.util.List<News> getNewsByTitle(String title) {
        return newsRepository.findByTitle(title);
    }

    public java.util.List<News> getNewsByTitleIgnoreCase(String title) {
        return newsRepository.findByTitleIgnoreCase(title);
    }

    public void deleteNews(Long id) {
        logger.info("Deleting news with ID: {}", id);
        if (!newsRepository.existsById(id)) {
            throw new RuntimeException("Cannot delete: News with id " + id + " not found");
        }
        newsRepository.deleteById(id);
    }
}