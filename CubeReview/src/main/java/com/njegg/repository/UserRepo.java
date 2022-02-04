package com.njegg.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import model.User;

public interface UserRepo extends JpaRepository<User, Integer> {
	User findByUsername(String username);
	List<User> findByUsernameContainsIgnoreCase(String query);
}
