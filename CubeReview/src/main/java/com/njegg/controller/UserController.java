package com.njegg.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.njegg.repository.FollowRepo;
import com.njegg.repository.ReviewRepo;
import com.njegg.repository.RoleRepo;
import com.njegg.repository.UserRepo;
import com.njegg.security.CustomUserDetail;

import model.FollowUser;
import model.FollowUserPK;
import model.Review;
import model.Role;
import model.User;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	UserRepo userRepo;
	
	@Autowired
	RoleRepo roleRepo;
	
	@Autowired
	ReviewRepo reviewRepo;
	
	@Autowired
	FollowRepo followRepo;
	
	/* ------ PROFILES --------*/
	
	@GetMapping("/{username}")
	public String profile(@PathVariable String username, Model model, HttpServletRequest request) {
		User user = userRepo.findByUsername(username);
		if (user == null) {
			model.addAttribute("obj", "User " + username);
			return "not-found";
		}
		
		// only registered users can look profiles
		User loggedUser = currentUser();
		if (loggedUser == null) {
			model.addAttribute("msgerr", "You must log in first");
			return "auth/login";
		}
		
		boolean owner = loggedUser.getUsername().equals(username);
		
		List<Review> usersReviews = reviewRepo.findByUser(user);
		
		// check if logged user is following this user
		if (!owner) {
			// logged user is following owner
			FollowUser following = followRepo.findByUser1AndUser2(loggedUser, user).orElse(null);
			// logged user is being followed by owner
			FollowUser followed  = followRepo.findByUser1AndUser2(user, loggedUser).orElse(null);
			
			model.addAttribute("following", following != null);
			model.addAttribute("followed",  followed  != null);
		}
		
		model.addAttribute("reviews", usersReviews);
		model.addAttribute("user", user);
		model.addAttribute("owner", owner);
		model.addAttribute("admin", request.isUserInRole("ROLE_ADMIN"));
		
		return "user/profile";
	}
	
	@GetMapping("/{username}/edit-about")
	public String editAbout(@PathVariable("username") String username, Model model) {
		User user = userRepo.findByUsername(username);
		if (user == null) {
			model.addAttribute("obj", "User");
			return "not-found";
		}
		
		boolean owner = currentUser().getUsername().equals(username);
		if (!owner) {
			return "access-denied";
		}
		
		model.addAttribute("user", user);
		model.addAttribute("owner", owner);
		model.addAttribute("edit", true);
		
		return "user/profile";
	}
	
	@PostMapping("/{username}/save-about")
	public String saveAbout(@PathVariable String username, Model model, String about) {
		User user = userRepo.findByUsername(username);
		if (user == null) {
			model.addAttribute("obj", "User");
			return "not-found";
		}
		
		User loggedUser = currentUser();
		if (loggedUser == null || !loggedUser.getUsername().equals(username)) {
			return "access-denied";
		}
		
		user.setAbout(about);
		userRepo.save(user);
		
		return "redirect:/user/" + username;
	}
	
	@GetMapping("/{userId}/delete")
	public String delete(@PathVariable Integer userId, HttpServletRequest request) {
		User toDelete = userRepo.findById(userId).orElseThrow();
		User curUser = currentUser();
		if (curUser == null) return "access-denied";
		
		if (curUser.getUserId() == toDelete.getUserId() || request.isUserInRole("ROLE_ADMIN")) {
			userRepo.deleteById(userId);
		} else {
			return "acces-denied";
		}
		
		
		return "redirect:/auth/logout";
	}
	
	public User currentUser() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetail userDetail;
		
		try {
			userDetail = (CustomUserDetail) auth.getPrincipal();
			return userRepo.findByUsername(userDetail.getUsername());
		} catch (Exception e) {
			return null;
		}
	}
	
	@GetMapping("/all")
	public String allUsers(Model model) {
		List<User> users = userRepo.findAll();
		
		model.addAttribute("users", users);

		return "user/all-users";
	}

	/* ------ admin edit role --------*/

	@GetMapping("/{username}/edit-role")
	@PreAuthorize("hasRole('ADMIN')")
	public String editRole(@PathVariable("username") String username, Model model) {
		User user = userRepo.findByUsername(username);
		if (user == null) {
			model.addAttribute("obj", "User");
			return "not-found";
		}
		model.addAttribute("user", user);
		
		List<Role> roles = roleRepo.findAllByNameNotLike("ADMIN");
		
		model.addAttribute("roles", roles);
		model.addAttribute("editRole", true);
		
		return "user/profile";
	}
	

	@PostMapping("/{username}/save-role")
	@PreAuthorize("hasRole('ADMIN')")
	public String saveRole(@PathVariable String username, Model model, Integer roleId) {
		User user = userRepo.findByUsername(username);
		if (user == null) {
			model.addAttribute("obj", "User");
			return "not-found";
		}
		
		Role role = roleRepo.getById(roleId);
		user.setRole(role);
		userRepo.save(user);
		
		model.addAttribute("ediRole", false);
		model.addAttribute("user", user);
		
		return "redirect:/user/" + username;
	}
	
	/* ----------- FOLLOW ---------------*/
	
	@GetMapping("/{username}/follow")
	public String followOrUnfollow(@PathVariable String username, Model model) {
		User userToFollow = userRepo.findByUsername(username);
		if (userToFollow == null) {
			model.addAttribute("obj", "User " + username);
			return "not-found";
		}
		
		User loggedUser = currentUser();
		if (loggedUser == null) {
			return "auth/login";
		}
		
		FollowUserPK pk = new FollowUserPK();
		pk.setFollowerId(loggedUser.getUserId());
		pk.setFollowedId(userToFollow.getUserId());
		
		FollowUser follow = followRepo.findById(pk).orElse(null);
		
		if (follow == null) {
			follow = new FollowUser();
			follow.setId(pk);
			follow.setFollowDate(new Date());
			follow.setUser1(loggedUser);
			follow.setUser2(userToFollow);
			
			loggedUser.addFollowUsers1(follow);
			userToFollow.addFollowUsers2(follow);
			
			followRepo.save(follow);
		} else {
			loggedUser.removeFollowUsers1(follow);
			userToFollow.removeFollowUsers2(follow);
			
			followRepo.delete(follow);
		}
		
		return "redirect:/user/" + username;
	}
	
}
