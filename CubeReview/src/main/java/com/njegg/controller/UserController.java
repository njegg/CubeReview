package com.njegg.controller;

import java.util.List;

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

import com.njegg.repository.RoleRepo;
import com.njegg.repository.UserRepo;
import com.njegg.security.CustomUserDetail;

import model.Role;
import model.User;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	UserRepo userRepo;
	
	@Autowired
	RoleRepo roleRepo;
	
	/* ------ PROFILES --------*/
	
	@GetMapping("/{username}")
	public String profile(@PathVariable String username, Model model) {
		User user = userRepo.findByUsername(username);
		if (user == null) {
			model.addAttribute("obj", "User");
			return "not-found";
		}
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (!(principal instanceof CustomUserDetail)) {
			model.addAttribute("msgerr", "You must log in first");
			return "auth/login";
		}
		
		model.addAttribute("user", user);
		model.addAttribute("owner", isOwner(username));
		
		return "user/profile";
	}
	
	@GetMapping("/{username}/edit-about")
	public String editAbout(@PathVariable("username") String username, Model model) {
		User user = userRepo.findByUsername(username);
		if (user == null) {
			model.addAttribute("obj", "User");
			return "not-found";
		}
		model.addAttribute("user", user);
		
		boolean owner = isOwner(username);
		if (!owner) {
			return "access-denied";
		}
		
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
		
		if (!isOwner(username)) {
			return "access-denied";
		}
		
		user.setAbout(about);
		userRepo.save(user);
		
		model.addAttribute("edit", false);
		model.addAttribute("user", user);
		
		return "redirect:/user/" + username;
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
	
	private boolean isOwner(String username) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetail userDetail;
		
		try {
			userDetail = (CustomUserDetail) auth.getPrincipal();
		} catch (Exception e) {
			return false;
		}

		return userDetail.getUsername().equals(username);
	}
	
	private boolean isAdmin(User u) {
		return u != null && u.getRole().getName().equals("ADMIN");
	}
	
	/* ------ --------*/
	
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
	
}
