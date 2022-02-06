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

import com.njegg.repository.CubeRequestRepo;
import com.njegg.repository.UserRepo;
import com.njegg.security.CustomUserDetail;

import model.CubeRequest;
import model.User;

@Controller
@RequestMapping("/request")
public class RequestController {
	
	@Autowired
	UserRepo userRepo;
	
	@Autowired
	CubeRequestRepo cubeRequestRepo;
	// DB CHANGED 
	
	@PreAuthorize("hasAnyRole('USER', 'MOD', 'ADMIN')")
	@PostMapping("/submit")
	public String submit(Model model, String cubeName, String message) {
		User user = currentUser();
		
		CubeRequest request = new CubeRequest();
		request.setContent(message);
		request.setCubeName(cubeName);
		request.setUser(user);
		
		cubeRequestRepo.save(request);
		model.addAttribute("msg", "Your request has beed sent!");
		
		return "cube/request";
	}

	@PreAuthorize("hasRole('USER')")
	@GetMapping("/userRequests")
	public String userRequests(Model model) {
		User user = currentUser();
		
		List<CubeRequest> requests = cubeRequestRepo.findByUser(user);
		
		model.addAttribute("requests", requests);
		model.addAttribute("normalUser", true);
		model.addAttribute("user", user);
		
		return "cube/request-list";
	}
	
	@PreAuthorize("hasAnyRole('MOD', 'ADMIN')")
	@GetMapping("/{cubeRequestId}/approve")
	public String approve(Model model, Integer approve, @PathVariable Integer cubeRequestId) {
		CubeRequest request = cubeRequestRepo.findById(cubeRequestId).orElse(null);
		if (request == null) {
			return "not-found";
		}
		
		request.setApproved(approve);
		cubeRequestRepo.save(request);
		
		return "redirect:/request/all" + "#" + cubeRequestId;
	}
	
	@PreAuthorize("hasAnyRole('MOD', 'ADMIN')")
	@GetMapping("/all")
	public String allRequests(Model model) {
		List<CubeRequest> requests = cubeRequestRepo.findAll();
		
		model.addAttribute("requests", requests);
		
		return "cube/request-list";
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
