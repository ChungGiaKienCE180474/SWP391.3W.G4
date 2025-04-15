package group04.gundamshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import group04.gundamshop.domain.News;

@Repository
public interface NewsRepository extends JpaRepository<News, Long> {
}