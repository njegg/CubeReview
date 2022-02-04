package com.njegg.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Cube;
import model.Review;
import model.User;
import model.UserLikeReview;
import model.UserLikeReviewPK;

public interface UserLikeReviewRepo extends JpaRepository<UserLikeReview, UserLikeReviewPK> {
	UserLikeReview findByUserAndReview(User user, Review review);

	List<UserLikeReview> findByUserAndReviewCube(User curUser, Cube cube);
}
