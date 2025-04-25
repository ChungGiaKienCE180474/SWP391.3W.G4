package group04.gundamshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import group04.gundamshop.domain.Factory;
import group04.gundamshop.repository.FactoryRepository;
import group04.gundamshop.repository.ProductRepository;

@Service
public class FactoryService {

    private final FactoryRepository factoryRepository;
    private final ProductRepository productRepository;

    public FactoryService(FactoryRepository factoryRepository, ProductRepository productRepository) {
        this.factoryRepository = factoryRepository;
        this.productRepository = productRepository;
    }

    public List<Factory> getAllFactories() {
        return factoryRepository.findAll();
    }

    public Optional<Factory> getFactoryById(Long id) {
        return factoryRepository.findById(id);
    }

    public Factory saveFactory(Factory factory) {
        return factoryRepository.save(factory);
    }

    public boolean isFactoryAssigned(Long factoryId) {
        return productRepository.existsByFactoryIdAndStatusTrue(factoryId);
    }

    @org.springframework.transaction.annotation.Transactional
    public void deleteFactory(Long id) {
        productRepository.unsetFactoryByFactoryId(id);
        factoryRepository.deleteById(id);
    }

    public Factory getFactoryByName(String name) {
        return factoryRepository.findByName(name);
    }
}
