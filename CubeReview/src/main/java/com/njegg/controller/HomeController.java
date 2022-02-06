package com.njegg.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.njegg.repository.ReviewRepo;
import com.njegg.repository.UserRepo;
import com.njegg.security.CustomUserDetail;

import model.Review;
import model.User;

@Controller
@RequestMapping("/")
public class HomeController {
	
	@Autowired
	UserRepo userRepo;
	
	@Autowired
	ReviewRepo reviewRepo;
	
	@GetMapping("")
	public String home(Model model) {
		User loggedUser = currentUser();

		if (loggedUser != null) {
			// find followers reviews
			
			List<Review> reviewsFromPeopleUserFollows = reviewRepo.findByUserFollowers(loggedUser);
			
			System.err.println("reviews:");
			reviewsFromPeopleUserFollows.forEach(System.err::println);
			
			model.addAttribute("reviews", reviewsFromPeopleUserFollows);
			model.addAttribute("user", loggedUser);
		}
		
		return "index";
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
}
