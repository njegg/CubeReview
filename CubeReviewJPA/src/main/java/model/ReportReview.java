package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the ReportReview database table.
 * 
 */
@Entity
@NamedQuery(name="ReportReview.findAll", query="SELECT r FROM ReportReview r")
public class ReportReview implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="report_review_id")
	private int reportReviewId;

	private String content;

	//bi-directional many-to-one association to Review
	@ManyToOne
	@JoinColumn(name="report_review_review_id")
	private Review review;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="report_review_id_user")
	private User user;

	public ReportReview() {
	}

	public int getReportReviewId() {
		return this.reportReviewId;
	}

	public void setReportReviewId(int reportReviewId) {
		this.reportReviewId = reportReviewId;
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