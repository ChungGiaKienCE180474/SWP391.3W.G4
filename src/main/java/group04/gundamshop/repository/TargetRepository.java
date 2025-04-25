package group04.gundamshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import group04.gundamshop.domain.Target;

@Repository
public interface TargetRepository extends JpaRepository<Target, Long> {
    Target findByName(String name);
}
