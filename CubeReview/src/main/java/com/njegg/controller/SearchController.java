package com.njegg.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.njegg.repository.CubeRepo;
import com.njegg.repository.UserRepo;

import model.Cube;
import model.User;

@Controller
@RequestMapping("/search")
public class SearchController {

	@Autowired
	CubeRepo cubeRepo;
	
	@Autowired
	UserRepo userRepo;
	
	
	@GetMapping("")
	public String search(String query, String type, Model model) {
		if (query == null) return "search/search-users-cubes";
		
		if (query.length() < 2) {
			model.addAttribute("msg", "You must input at least 2 characters");
			return "search/search-users-cubes";
		}
		
		int count = 0;
		
		if (type.equals("cubes")) {
			List<Cube> cubes = cubeRepo.findByNameContainsIgnoreCase(query);
			model.addAttribute("cubes", cubes);
			count = cubes.size();
		} else if (type.equals("users")) {
			List<User> users = userRepo.findByUsernameContainsIgnoreCase(query);
			model.addAttribute("users", users);
			count = users.size();
		}
		
		if (count == 0 ) {
			model.addAttribute("msg", "Nothing was found");
		}
		
		return "search/search-users-cubes";
	}
	
}
