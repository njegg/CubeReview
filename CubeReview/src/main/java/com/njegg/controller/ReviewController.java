package com.njegg.controller;

import java.util.Date;
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

import com.njegg.repository.CommentRepo;
import com.njegg.repository.CubeRepo;
import com.njegg.repository.ReportRepo;
import com.njegg.repository.ReviewRepo;
import com.njegg.repository.UserLikeReviewRepo;
import com.njegg.repository.UserRepo;
import com.njegg.security.CustomUserDetail;

import model.Cube;
import model.ReportReview;
import model.Review;
import model.ReviewComment;
import model.User;
import model.UserLikeReview;
import model.UserLikeReviewPK;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	CubeRepo cubeRepo;
	
	@Autowired
	UserRepo userRepo;
	
	@Autowired
	ReviewRepo reviewRepo;
	
	@Autowired
	UserLikeReviewRepo ulrRepo;
	
	@Autowired
	CommentRepo commentRepo;
	
	@Autowired
	ReportRepo reportRepo;
	
	@PostMapping("/post-review")
	public String postReview(Model model, Integer cubeId, String content, Integer rating, Integer edit) {
		Cube c = cubeRepo.findById(cubeId).orElseThrow();
		User u = currentUser();
		if (c == null || u == null) return "redirect:/error";
		
		Review review;
		
		if (edit == 1) {
			review = reviewRepo.findByCubeAndUser(c, u);
			// if edited, just update content and rating
		} else {
			review = new Review();
			review.setUser(u);
			review.setCube(c);
			review.setCreationTime(new Date());
			
			u.addReview(review);
			c.addReview(review);
		}
		
		review.setContent(content);
		review.setRating(rating);
		reviewRepo.save(review);
	
		model.addAttribute("cube", c);
		
		return "redirect:/cube/" + cubeId + "#" + review.getReviewId();
	}
	
	
	@GetMapping("/{reviewId}/like")
	public String like(Model model, @PathVariable Integer reviewId) {
		return updateLikes(model, reviewId, true);
	}

	
	@GetMapping("/{reviewId}/dislike")
	public String dislike(Model model, @PathVariable Integer reviewId) {
		return updateLikes(model, reviewId, false);
	}
	
	private String updateLikes(Model model, int reviewId, boolean like) {
		User user = currentUser();
		Review review = reviewRepo.findById(reviewId).orElse(null);
		
		if (review == null) {
			model.addAttribute("obj", "Review with id" + reviewId);
			return "not-found";
		}
		
		if (user == null) {
			model.addAttribute("msgerr", "You must log in first");
			return "auth/login";
		}
		
		Cube cube = review.getCube();

		UserLikeReview likes = ulrRepo.findByUserAndReview(user, review);;
		
		// (dis)liked before
		if (likes != null) {
			boolean removeRelation = false;
			
			if (likes.getLikes() == 1) {
				if (like) {
					// liked and liked before
					review.setVotes(review.getVotes() - 1);
					// remove relation
					removeRelation = true;
				} else {
					// liked and disliked before
					review.setVotes(review.getVotes() - 2);
					// updates the state to disliked
					likes.setLikes((byte) 0);
				}
			} else {
				if (like) {
					// liked and disliked before
					review.setVotes(review.getVotes() + 2);
					likes.setLikes((byte) 1);
				} else {
					// disliked and disliked before
					review.setVotes(review.getVotes() + 1);
					removeRelation = true;
				}
			}
			
			if (removeRelation) {
				review.removeUserLikeReview(likes);
				user.removeUserLikeReview(likes);
				ulrRepo.delete(likes);
			}
			
			model.addAttribute(like ? "liked" : "disliked", false);
		} else {
			// didnt like or dislike before
			UserLikeReviewPK pk = new UserLikeReviewPK();
			pk.setLikeReviewId(reviewId);
			pk.setLikeUserId(user.getUserId());
			
			likes = new UserLikeReview();
			likes.setId(pk);
			likes.setUser(user);
			likes.setReview(review);
			likes.setLikes((byte) (like ? 1 : 0));
			
			ulrRepo.save(likes);
			
			user.addUserLikeReview(likes);
			review.addUserLikeReview(likes);
			
			review.setVotes(review.getVotes() + (like ? 1 : -1));
			
			model.addAttribute(like ? "liked" : "disliked", true);
		}
		
		reviewRepo.save(review);
		userRepo.save(user);
		
		return "redirect:/cube/" + cube.getCubeId() + "#" + reviewId;
	}
	
	@GetMapping("/delete-for-cube-and-logger-user")
	public String deleteFromLoggerUser(Integer cubeId, Model model) {
		User user = currentUser();
		if (user == null) {
			return "error";
		}
		
		Cube cube = cubeRepo.findById(cubeId).orElseThrow();
		Review review = reviewRepo.findByCubeAndUser(cube, user);
		
		cube.removeReview(review);
		user.removeReview(review);
		
		model.addAttribute("cube", cube);
		reviewRepo.deleteById(review.getReviewId());
		
		return "redirect:/cube/" + cube.getCubeId();
	}
	
	@PreAuthorize("hasAnyRole('ADMIN', 'MOD')")
	@GetMapping("/{reviewId}/delete")
	public String delete(@PathVariable Integer reviewId, Model model) {
		Review review = reviewRepo.findById(reviewId).orElse(null);
		if (review == null) {
			model.addAttribute("obj", "Review with id " + reviewId);
			return "not-found";
		}

		Cube cube = review.getCube();
		model.addAttribute("cube", cube);
		
		review.getUser().removeReview(review);
		cube.removeReview(review);
		
		reviewRepo.deleteById(reviewId);
		
		return "redirect:/cube/" + cube.getCubeId();
	}
	
	@PostMapping("/{reviewId}/comment")
	public String comment(Model m, String content, @PathVariable Integer reviewId) {
		User user = currentUser();
		Review review = reviewRepo.findById(reviewId).orElseThrow();
		Cube cube = review.getCube();
		
		if (user == null) {
			return "auth/login";
		}
		
		ReviewComment comment = new ReviewComment();
		comment.setContent(content);
		comment.setReview(review);
		comment.setUser(user);
		comment.setCommentDate(new Date());
		
		user.addReviewComment(comment);

		commentRepo.save(comment);
		
		return "redirect:/cube/" + cube.getCubeId() + "#comment-" + comment.getCommentId();
	}
	
	@PreAuthorize("hasAnyRole('ADMIN', 'MOD')")
	@GetMapping("/comment/{commentId}/delete")
	public String deleteComment(@PathVariable Integer commentId, Model model) {
		ReviewComment comment = commentRepo.findById(commentId).orElse(null);
		if (comment == null) {
			model.addAttribute("obj", "Comment with id" + commentId);
			return "not-found";
		}
		
		Review review = comment.getReview();
		Cube cube = review.getCube();
		User userWhoCommented = review.getUser();
		
		userWhoCommented.removeReviewComment(comment);
		review.removeReviewComment(comment);
		
		commentRepo.deleteById(commentId);
		
		return "redirect:/cube/" + cube.getCubeId() + "#" + review.getReviewId();
	}
	
	@PreAuthorize("hasAnyRole('ADMIN', 'MOD', 'USER')")
	@GetMapping("/{reviewId}/report")
	public String report(Model model, String content, @PathVariable Integer reviewId) {
		Review review = reviewRepo.findById(reviewId).orElseThrow();
		User user = currentUser();

		if (review == null) {
			model.addAttribute("obj", "Review");
			return "not-found";
		}
		
		if (content == null) {
			model.addAttribute("r", review);
			return "review/report-review";
		}
		
		ReportReview report = new ReportReview();
		report.setContent(content);
		report.setReview(review);
		report.setUser(user);
		
		reportRepo.save(report);
		
		return "redirect:/cube/" + review.getCube().getCubeId() + "#" + reviewId;
	}
	
	@PreAuthorize("hasAnyRole('ADMIN', 'MOD')")
	@GetMapping("/all-reports")
	public String allReports(Model model) {
		List<ReportReview> reports = reportRepo.findAll();
		
		model.addAttribute("reports", reports);
		
		return "review/all-reports";
	}
	
	/* ------------ helpers --------------*/
	
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
