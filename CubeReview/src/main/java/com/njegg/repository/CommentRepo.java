package com.njegg.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import model.ReviewComment;

public interface CommentRepo extends JpaRepository<ReviewComment, Integer> {

}
