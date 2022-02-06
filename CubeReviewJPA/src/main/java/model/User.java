package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the User database table.
 * 
 */
@Entity
@NamedQuery(name="User.findAll", query="SELECT u FROM User u")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="user_id")
	private int userId;

	private String about;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="creation_time")
	private Date creationTime;

	private String email;

	private String password;

	private String username;

	//bi-directional many-to-one association to CubeRequest
	@OneToMany(mappedBy="user", cascade = CascadeType.REMOVE)
	private List<CubeRequest> cubeRequests;

	//bi-directional many-to-one association to FollowUser
	@OneToMany(mappedBy="user1", cascade = CascadeType.REMOVE)
	private List<FollowUser> followUsers1;

	//bi-directional many-to-one association to FollowUser
	@OneToMany(mappedBy="user2", cascade = CascadeType.REMOVE)
	private List<FollowUser> followUsers2;

	//bi-directional many-to-one association to Review
	@OneToMany(mappedBy="user", cascade = CascadeType.REMOVE)
	private List<Review> reviews;

	//bi-directional many-to-one association to ReviewComment
	@OneToMany(mappedBy="user", cascade = CascadeType.REMOVE)
	private List<ReviewComment> reviewComments;

	//bi-directional many-to-many association to Cube
	@ManyToMany
	@JoinTable(
		name="FavoriteCube"
		, joinColumns={
			@JoinColumn(name="favourite_user_id")
			}
		, inverseJoinColumns={
			@JoinColumn(name="favourite_cube_id")
			}
		)
	private List<Cube> cubes;

	//bi-directional many-to-one association to Role
	@ManyToOne
	@JoinColumn(name="user_role_id")
	private Role role;

	//bi-directional many-to-one association to UserLikeReview
	@OneToMany(mappedBy="user", cascade = CascadeType.REMOVE)
	private List<UserLikeReview> userLikeReviews;

	//bi-directional many-to-one association to ReportReview
	@OneToMany(mappedBy="user", cascade = CascadeType.REMOVE)
	private List<ReportReview> reportReviews;

	public User() {
	}

	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getAbout() {
		return this.about;
	}

	public void setAbout(String about) {
		this.about = about;
	}

	public Date getCreationTime() {
		return this.creationTime;
	}

	public void setCreationTime(Date creationTime) {
		this.creationTime = creationTime;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public List<CubeRequest> getCubeRequests() {
		return this.cubeRequests;
	}

	public void setCubeRequests(List<CubeRequest> cubeRequests) {
		this.cubeRequests = cubeRequests;
	}

	public CubeRequest addCubeRequest(CubeRequest cubeRequest) {
		getCubeRequests().add(cubeRequest);
		cubeRequest.setUser(this);

		return cubeRequest;
	}

	public CubeRequest removeCubeRequest(CubeRequest cubeRequest) {
		getCubeRequests().remove(cubeRequest);
		cubeRequest.setUser(null);

		return cubeRequest;
	}

	public List<FollowUser> getFollowUsers1() {
		return this.followUsers1;
	}

	public void setFollowUsers1(List<FollowUser> followUsers1) {
		this.followUsers1 = followUsers1;
	}

	public FollowUser addFollowUsers1(FollowUser followUsers1) {
		getFollowUsers1().add(followUsers1);
		followUsers1.setUser1(this);

		return followUsers1;
	}

	public FollowUser removeFollowUsers1(FollowUser followUsers1) {
		getFollowUsers1().remove(followUsers1);
		followUsers1.setUser1(null);

		return followUsers1;
	}

	public List<FollowUser> getFollowUsers2() {
		return this.followUsers2;
	}

	public void setFollowUsers2(List<FollowUser> followUsers2) {
		this.followUsers2 = followUsers2;
	}

	public FollowUser addFollowUsers2(FollowUser followUsers2) {
		getFollowUsers2().add(followUsers2);
		followUsers2.setUser2(this);

		return followUsers2;
	}

	public FollowUser removeFollowUsers2(FollowUser followUsers2) {
		getFollowUsers2().remove(followUsers2);
		followUsers2.setUser2(null);

		return followUsers2;
	}

	public List<Review> getReviews() {
		return this.reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public Review addReview(Review review) {
		getReviews().add(review);
		review.setUser(this);

		return review;
	}

	public Review removeReview(Review review) {
		getReviews().remove(review);
		review.setUser(null);

		return review;
	}

	public List<ReviewComment> getReviewComments() {
		return this.reviewComments;
	}

	public void setReviewComments(List<ReviewComment> reviewComments) {
		this.reviewComments = reviewComments;
	}

	public ReviewComment addReviewComment(ReviewComment reviewComment) {
		getReviewComments().add(reviewComment);
		reviewComment.setUser(this);

		return reviewComment;
	}

	public ReviewComment removeReviewComment(ReviewComment reviewComment) {
		getReviewComments().remove(reviewComment);
		reviewComment.setUser(null);

		return reviewComment;
	}

	public List<Cube> getCubes() {
		return this.cubes;
	}

	public void setCubes(List<Cube> cubes) {
		this.cubes = cubes;
	}

	public Role getRole() {
		return this.role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public List<UserLikeReview> getUserLikeReviews() {
		return this.userLikeReviews;
	}

	public void setUserLikeReviews(List<UserLikeReview> userLikeReviews) {
		this.userLikeReviews = userLikeReviews;
	}

	public UserLikeReview addUserLikeReview(UserLikeReview userLikeReview) {
		getUserLikeReviews().add(userLikeReview);
		userLikeReview.setUser(this);

		return userLikeReview;
	}

	public UserLikeReview removeUserLikeReview(UserLikeReview userLikeReview) {
		getUserLikeReviews().remove(userLikeReview);
		userLikeReview.setUser(null);

		return userLikeReview;
	}

	public List<ReportReview> getReportReviews() {
		return this.reportReviews;
	}

	public void setReportReviews(List<ReportReview> reportReviews) {
		this.reportReviews = reportReviews;
	}

	public ReportReview addReportReview(ReportReview reportReview) {
		getReportReviews().add(reportReview);
		reportReview.setUser(this);

		return reportReview;
	}

	public ReportReview removeReportReview(ReportReview reportReview) {
		getReportReviews().remove(reportReview);
		reportReview.setUser(null);

		return reportReview;
	}

}