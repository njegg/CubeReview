package com.njegg.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.njegg.repository.RoleRepo;
import com.njegg.repository.UserRepo;

import model.Role;
import model.User;

@Controller
@ControllerAdvice
@RequestMapping("/auth")
public class LoginController {
		
	@Autowired
	RoleRepo roleRepo;
	
	@Autowired
	UserRepo userRepo;
	
	@GetMapping("/login")
	public String login() {
		return "auth/login";
	}
	
	@GetMapping("/login-error")
	public String loginError(Model m) {
		m.addAttribute("msgerr", "Wrong credentials");
		return "auth/login";
	}
	
	@ModelAttribute("newUser")
	public User newUser() {
		User newUser = new User();
		Role role = roleRepo.findByName("USER");
		
		newUser.setRole(role);
		newUser.setCreationTime(new Date());
		
		return newUser;
	}
	
	@GetMapping("/register")
	public String forwardRegister() {
		return "auth/register";
	}
	
	@PostMapping("/save-user")
	public String saveUser(@ModelAttribute("newUser") User newUser, Model m) {
		if (userRepo.findByUsername(newUser.getUsername()) != null) {
			m.addAttribute("msgerr", "Username not available");
			return "auth/register";
		}

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		newUser.setPassword(encoder.encode(newUser.getPassword()));
		
		userRepo.save(newUser);
		m.addAttribute("msgsucc", "Registration succesful");
		
		return "auth/login";
	}
	
	@GetMapping("/logout")
    public String logoutPage (HttpServletRequest request, HttpServletResponse response){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null){    
            SecurityContextHolder.getContext().setAuthentication(null);
        }
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        return "redirect:/auth/login";
    }
	
	@GetMapping("/egg")
	public String egg(Model m) {
		m.addAttribute("u", userRepo.findAll());
		
		return "kaka";
	}
}
