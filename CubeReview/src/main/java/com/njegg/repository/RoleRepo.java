package com.njegg.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Role;

public interface RoleRepo extends JpaRepository<Role, Integer> {
	Role findByName(String string);

	List<Role> findAllByNameNotLike(String string);
}
