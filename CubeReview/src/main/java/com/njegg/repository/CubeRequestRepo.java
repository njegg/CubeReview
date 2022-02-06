package com.njegg.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import model.CubeRequest;
import model.User;

public interface CubeRequestRepo extends JpaRepository<CubeRequest, Integer> {
	List<CubeRequest> findByUser(User user);
}
