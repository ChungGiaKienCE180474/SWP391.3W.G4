package group04.gundamshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import group04.gundamshop.domain.News;
import java.util.Optional;

@Repository
public interface NewsRepository extends JpaRepository<News, Long> {
    java.util.List<News> findByStatusTrue();
    java.util.List<News> findByTitle(String title);
    java.util.List<News> findByTitleIgnoreCase(String title);
}
