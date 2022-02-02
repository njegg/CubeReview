package com.njegg.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.njegg.repository.UserRepo;
import com.njegg.security.CustomUserDetail;

import model.Cube;
import model.CubeType;
import model.User;

@Controller
@RequestMapping("/cube")
public class CubeController {
	
	@Autowired
	CubeRepo cubeRepo;
	
	@Autowired
	CubeTypeRepo cubeTypeRepo;

	@Autowired
	UserRepo userRepo;
	
	@GetMapping("/all")
	public String allCubes(Model model) {
		List<Cube> cubes = cubeRepo.findAll(); 
		
		model.addAttribute("cubes", cubes);
		
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
	public String cubeDatails(@PathVariable Integer cubeId, Model model, HttpServletRequest request) {
		Cube cube = cubeRepo.findById(cubeId).orElse(null);
		if (cube == null) {
			model.addAttribute("obj", "Cube with id " + cubeId);
			return "not-found";
		}
		
		request.getSession().setAttribute("user", currentUser());
		model.addAttribute("cube", cube);
		
		return "cube/cube-details";
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
