package com.njegg.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import model.Cube;
import model.Review;
import model.User;

public interface ReviewRepo extends JpaRepository<Review, Integer> {
	List<Review> findByCube(Cube cube);
	Review findByCubeAndUser(Cube c, User u);
	List<Review> findByUser(User user);
	
	@Query(
		"select r from Review r "
	  + "where r in "
      + "(select ulr.review from UserLikeReview ulr "
      + "where ulr.review.cube like :c "
      + "and   ulr.user like :u "
      + "and ulr.likes = :l)"
	)
	List<Review> findByUserLikedReviewOfCube(@Param("u") User curUser, @Param("c") Cube cube, @Param("l") int like);
	
	
	Review findByCubeAndUserUsername(Cube cube, String username);
	
	@Query(
		"select r from Review r where r.user in "
	  + "(select fu.user2 from FollowUser fu "
	  + "where fu.user1 like :u)"
	)
	List<Review> findByUserFollowers(@Param("u") User u);
}
