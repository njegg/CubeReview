package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the UserLikeReview database table.
 * 
 */
@Entity
@NamedQuery(name="UserLikeReview.findAll", query="SELECT u FROM UserLikeReview u")
public class UserLikeReview implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private UserLikeReviewPK id;

	private byte likes;

	//bi-directional many-to-one association to Review
	@ManyToOne
	@JoinColumn(name="like_review_id", insertable = false, updatable = false)
	private Review review;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="like_user_id", insertable = false, updatable = false)
	private User user;

	public UserLikeReview() {
	}

	public UserLikeReviewPK getId() {
		return this.id;
	}

	public void setId(UserLikeReviewPK id) {
		this.id = id;
	}

	public byte getLikes() {
		return this.likes;
	}

	public void setLikes(byte likes) {
		this.likes = likes;
	}

	public Review getReview() {
		return this.review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}