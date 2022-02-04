package com.njegg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.njegg.repository.CubeRepo;
import com.njegg.repository.CubeTypeRepo;
import com.njegg.repository.ReviewRepo;
import com.njegg.repository.UserLikeReviewRepo;
import com.njegg.repository.UserRepo;
import com.njegg.security.CustomUserDetail;

import model.Cube;
import model.CubeType;
import model.Review;
import model.User;
import model.UserLikeReview;

@Controller
@RequestMapping("/cube")
public class CubeController {
	
	@Autowired
	CubeRepo cubeRepo;
	
	@Autowired
	CubeTypeRepo cubeTypeRepo;

	@Autowired
	UserRepo userRepo;
	
	@Autowired
	ReviewRepo reviewRepo;
	
	@Autowired
	UserLikeReviewRepo ulrRepo;
	
	@GetMapping("/all")
	public String allCubes(Model model) {
		List<Cube> cubes = cubeRepo.findAll(); 
		
		model.addAttribute("cubes", cubes);
		
		return "cube/all-cubes";
	}
	
	@GetMapping("/sorted-rating")
	public String sortedByRating(Model model) {
		List<Cube> cubes = cubeRepo.findAll(); 
		HashMap<Cube, Double> map = new HashMap<Cube, Double>();
		
		// map every cube to average rating
		for (Cube c : cubes) {
			List<Review> cubeReviews = reviewRepo.findByCube(c);
			int cubeRatingSum = cubeReviews
				.stream()
				.mapToInt(Review::getRating)
				.sum()
			;
			map.put(c, 1.0 * cubeRatingSum / cubeReviews.size());
		}
		
		// sort the map by avg rating and convert back to list
		cubes =  map.entrySet()
			.stream()
			.sorted(Map.Entry.<Cube, Double> comparingByValue().reversed())
			.map(Map.Entry::getKey)
			.collect(Collectors.toList())
			.stream()
			.limit(20)
			.toList()
		;		
		
		model.addAttribute("cubes", cubes);
		model.addAttribute("showBest", true);
		
		return "cube/all-cubes";
	}
	
	@ModelAttribute("newCube")
	public Cube newCube() {
		Cube c = new Cube();
		c.setImagePath("");
		return c;
	}
	
	@ModelAttribute("types")
	public List<CubeType> getCubeTypes() {
		return cubeTypeRepo.findAll();
	}

	@GetMapping("/add-cube")
	@PreAuthorize("hasAnyRole('ADMIN', 'MOD')")
	public String addCube() {
		return "cube/add-cube";
	}
	
	@PostMapping("/save-cube")
	@PreAuthorize("hasAnyRole('ADMIN', 'MOD')")
	public String saveCube(@ModelAttribute("newCube") Cube newCube) {
		if (newCube == null) {
			return "error";
		}
		
		cubeRepo.save(newCube);
		
		return "redirect:/cube/" + newCube.getCubeId();
	}
	
	@GetMapping("/{cubeId}")
	public String cubeDatails(@PathVariable Integer cubeId, Model model, HttpServletRequest request, Integer edit) {
		Cube cube = cubeRepo.findById(cubeId).orElse(null);
		if (cube == null) {
			model.addAttribute("obj", "Cube with id " + cubeId);
			return "not-found";
		}
		
		User curUser = currentUser();
		if (curUser != null) {
			request.getSession().setAttribute("user", curUser);
			Review review = reviewRepo.findByCubeAndUser(cube, curUser);
			
			// if user reviewd the cube, he can only edit it, cant make new
			if (review != null) {
				model.addAttribute("hasReviewed", review != null);
				model.addAttribute("content", review.getContent());
			}
			
			List<UserLikeReview> likedRev = ulrRepo.findByUserAndReviewCube(curUser, cube);
			Map<Integer, Byte> likeMap = new HashMap<>();
			
			for (UserLikeReview ulr : likedRev) {
				likeMap.put(ulr.getReview().getReviewId(), ulr.getLikes());
			}
			
			model.addAttribute("likeMap", likeMap);
		}
		
		model.addAttribute("cube", cube);
		
		// reviews of the cube
		List<Review> reviews = reviewRepo.findByCube(cube);
		model.addAttribute("reviews", reviews);
		
		if ((isRole(curUser, "ADMIN") || isRole(curUser, "MOD")) && edit != null && edit == 1) {
			model.addAttribute("edit", true);
		}
		
		return "cube/cube-details";
	}
	
	@GetMapping("/search")
	public String search(String query, Model model) {
		List<Cube> cubes;
		
		if (query == null || query.trim().isEmpty()) {
			cubes = cubeRepo.findAll();
		} else {
			int year;
			try {
				year = Integer.parseInt(query);
			} catch (NumberFormatException e) {
				year = -1;
			}
			
			// name or type contains query or equals release year
			cubes = cubeRepo.findByNameContainsIgnoreCaseOrCubeTypeTypeNameContainsIgnoreCaseOrReleaseYearLike(query, query, year);
		}
		
		model.addAttribute("cubes", cubes);
		
		return "cube/all-cubes";
	}
	
	@PostMapping("/{cubeId}/edit")
	@PreAuthorize("hasAnyRole('ADMIN', 'MOD')")
	public String edit(@PathVariable Integer cubeId, Model m, String name, String year, Integer typeId, Model model) {
		int releaseYear;
		CubeType type;
		try {
			releaseYear = Integer.parseInt(year);
			type = cubeTypeRepo.findById(typeId).orElseThrow();
		} catch (Exception e) {
			return "error";
		}
		
		Cube cube = cubeRepo.findById(cubeId).orElseThrow();
		cube.setName(name);
		cube.setCubeType(type);
		cube.setReleaseYear(releaseYear);
		
		cubeRepo.save(cube);
		
		return "redirect:/cube/" + cube.getCubeId();
	}
	
	@GetMapping("/{cubeId}/delete")
	@PreAuthorize("hasAnyRole('ADMIN', 'MOD')")
	public String delete(@PathVariable Integer cubeId) {
		Cube cube = cubeRepo.findById(cubeId).orElseThrow();
		
		cubeRepo.delete(cube);
		
		return "redirect:/";
	}
	
	/* --------- helpers -----------*/
	
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
	
	private boolean isRole(User u, String role) {
		return u != null && u.getRole().getName().equals(role);
	}
}
