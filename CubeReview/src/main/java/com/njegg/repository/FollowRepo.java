package com.njegg.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import model.FollowUser;
import model.FollowUserPK;
import model.User;

public interface FollowRepo extends JpaRepository<FollowUser, FollowUserPK> {

	Optional<FollowUser> findByUser1AndUser2(User loggedUser, User user);

}
