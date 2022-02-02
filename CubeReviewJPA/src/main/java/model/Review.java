package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the Review database table.
 * 
 */
@Entity
@NamedQuery(name="Review.findAll", query="SELECT r FROM Review r")
public class Review implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="review_id")
	private int reviewId;

	private String content;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="creation_time")
	private Date creationTime;

	//bi-directional many-to-one association to Cube
	@ManyToOne
	@JoinColumn(name="review_cube_id")
	private Cube cube;

	//bi-directional many-to-many association to RatingType
	@ManyToMany
	@JoinTable(
		name="RaviewRating"
		, joinColumns={
			@JoinColumn(name="review_rating_id_review")
			}
		, inverseJoinColumns={
			@JoinColumn(name="review_rating_id_rating_type")
			}
		)
	private List<RatingType> ratingTypes;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="review_user_id")
	private User user;

	//bi-directional many-to-one association to ReviewComment
	@OneToMany(mappedBy="review")
	private List<ReviewComment> reviewComments;

	//bi-directional many-to-one association to UserLikeReview
	@OneToMany(mappedBy="review")
	private List<UserLikeReview> userLikeReviews;

	public Review() {
	}

	public int getReviewId() {
		return this.reviewId;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreationTime() {
		return this.creationTime;
	}

	public void setCreationTime(Date creationTime) {
		this.creationTime = creationTime;
	}

	public Cube getCube() {
		return this.cube;
	}

	public void setCube(Cube cube) {
		this.cube = cube;
	}

	public List<RatingType> getRatingTypes() {
		return this.ratingTypes;
	}

	public void setRatingTypes(List<RatingType> ratingTypes) {
		this.ratingTypes = ratingTypes;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<ReviewComment> getReviewComments() {
		return this.reviewComments;
	}

	public void setReviewComments(List<ReviewComment> reviewComments) {
		this.reviewComments = reviewComments;
	}

	public ReviewComment addReviewComment(ReviewComment reviewComment) {
		getReviewComments().add(reviewComment);
		reviewComment.setReview(this);

		return reviewComment;
	}

	public ReviewComment removeReviewComment(ReviewComment reviewComment) {
		getReviewComments().remove(reviewComment);
		reviewComment.setReview(null);

		return reviewComment;
	}

	public List<UserLikeReview> getUserLikeReviews() {
		return this.userLikeReviews;
	}

	public void setUserLikeReviews(List<UserLikeReview> userLikeReviews) {
		this.userLikeReviews = userLikeReviews;
	}

	public UserLikeReview addUserLikeReview(UserLikeReview userLikeReview) {
		getUserLikeReviews().add(userLikeReview);
		userLikeReview.setReview(this);

		return userLikeReview;
	}

	public UserLikeReview removeUserLikeReview(UserLikeReview userLikeReview) {
		getUserLikeReviews().remove(userLikeReview);
		userLikeReview.setReview(null);

		return userLikeReview;
	}

}