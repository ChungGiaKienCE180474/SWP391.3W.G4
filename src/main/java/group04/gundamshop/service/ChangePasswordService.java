package group04.gundamshop.service;

import org.springframework.stereotype.Service;

import group04.gundamshop.repository.UserRepository;

@Service
public class ChangePasswordService {
    private final UserRepository userRepository;

    public ChangePasswordService(UserRepository userRepository) {
        this.userRepository = userRepository;

    }

    public boolean checkEmailExist(String email) {
        return this.userRepository.existsByEmail(email);
    }

}
