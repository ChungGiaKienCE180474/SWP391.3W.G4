package group04.gundamshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import group04.gundamshop.domain.Factory;

@Repository
public interface FactoryRepository extends JpaRepository<Factory, Long> {
    Factory findByName(String name);
}
