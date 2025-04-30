package group04.gundamshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import group04.gundamshop.domain.User;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    void deleteById(long id);

    List<User> findByRoleId(Long roleId);

    List<User> findAllByRole_Id(long roleId);

    List<User> findAllByRole_IdAndStatus(long roleId, boolean status);

    Optional<User> findById(Long id); // Sửa lại từ `User findById(long id);`

    boolean existsByEmail(String email);

    Optional<User> findByEmail(String email); // Đây là cách đúng thay vì `findOneByEmail(String email)`

    boolean existsById(Long id);

    void deleteById(Long id);
}
