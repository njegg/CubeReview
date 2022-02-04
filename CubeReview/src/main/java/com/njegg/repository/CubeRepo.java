package com.njegg.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import model.Cube;

public interface CubeRepo extends JpaRepository<Cube, Integer> {
	List<Cube> findByNameContainsIgnoreCase(String query);

	List<Cube> findByNameContainsIgnoreCaseOrCubeTypeTypeNameContainsIgnoreCaseOrReleaseYearLike(String query, String query2, int year);
}
