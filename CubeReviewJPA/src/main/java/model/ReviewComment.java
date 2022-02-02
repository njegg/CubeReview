package model;

import java.io.Serializable;
import javax.persistence.*;

import org.hibernate.type.TrueFalseType;

import java.util.Date;


/**
 * The persistent class for the ReviewComment database table.
 * 
 */
@Entity
@NamedQuery(name="ReviewComment.findAll", query="SELECT r FROM ReviewComment r")
public class ReviewComment implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private ReviewCommentPK id;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="commnet_date")
	private Date commnetDate;

	private String content;

	//bi-directional many-to-one association to Review
	@ManyToOne
	@JoinColumn(name="comment_review_id", insertable = false, updatable = false)
	private Review review;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="comment_user_id", insertable = false, updatable = false)
	private User user;

	public ReviewComment() {
	}

	public ReviewCommentPK getId() {
		return this.id;
	}

	public void setId(ReviewCommentPK id) {
		this.id = id;
	}

	public Date getCommnetDate() {
		return this.commnetDate;
	}

	public void setCommnetDate(Date commnetDate) {
		this.commnetDate = commnetDate;
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