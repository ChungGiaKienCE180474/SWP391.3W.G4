package group04.gundamshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import group04.gundamshop.domain.Target;
import group04.gundamshop.repository.TargetRepository;
import group04.gundamshop.repository.ProductRepository;

@Service
public class TargetService {

    private final TargetRepository targetRepository;
    private final ProductRepository productRepository;

    public TargetService(TargetRepository targetRepository, ProductRepository productRepository) {
        this.targetRepository = targetRepository;
        this.productRepository = productRepository;
    }

    public List<Target> getAllTargets() {
        return targetRepository.findAll();
    }

    public Optional<Target> getTargetById(Long id) {
        return targetRepository.findById(id);
    }

    public Target saveTarget(Target target) {
        return targetRepository.save(target);
    }

    public boolean isTargetAssigned(Long targetId) {
        return productRepository.existsByTargetIdAndStatusTrue(targetId);
    }

    @org.springframework.transaction.annotation.Transactional
    public void deleteTarget(Long id) {
        productRepository.unsetTargetByTargetId(id);
        targetRepository.deleteById(id);
    }

    public Target getTargetByName(String name) {
        return targetRepository.findByName(name);
    }
}
