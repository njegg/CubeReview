package com.njegg.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.njegg.repository.UserRepo;

import model.User;

@Service("userDetailProvider")
public class UserDetailProvider implements UserDetailsService {
	
	@Autowired
	UserRepo ur;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User u = ur.findByUsername(username);
		if (u == null) {
			throw new UsernameNotFoundException("no user");
		}
		UserDetails ud = new CustomUserDetail(u);
		return ud;
	}

}
