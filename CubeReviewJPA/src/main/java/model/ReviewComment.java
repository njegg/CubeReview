package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the ReviewComment database table.
 * 
 */
@Entity
@NamedQuery(name="ReviewComment.findAll", query="SELECT r FROM ReviewComment r")
public class ReviewComment implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="comment_id")
	private int commentId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="comment_date")
	private Date commentDate;

	private String content;

	//bi-directional many-to-one association to Review
	@ManyToOne
	@JoinColumn(name="comment_review_id")
	private Review review;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="comment_user_id")
	private User user;

	public ReviewComment() {
	}

	public int getCommentId() {
		return this.commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public Date getCommentDate() {
		return this.commentDate;
	}

	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
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