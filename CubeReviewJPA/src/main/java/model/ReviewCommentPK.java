package model;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the ReviewComment database table.
 * 
 */
@Embeddable
public class ReviewCommentPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="comment_user_id", insertable=false, updatable=false)
	private int commentUserId;

	@Column(name="comment_review_id", insertable=false, updatable=false)
	private int commentReviewId;

	public ReviewCommentPK() {
	}
	public int getCommentUserId() {
		return this.commentUserId;
	}
	public void setCommentUserId(int commentUserId) {
		this.commentUserId = commentUserId;
	}
	public int getCommentReviewId() {
		return this.commentReviewId;
	}
	public void setCommentReviewId(int commentReviewId) {
		this.commentReviewId = commentReviewId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof ReviewCommentPK)) {
			return false;
		}
		ReviewCommentPK castOther = (ReviewCommentPK)other;
		return 
			(this.commentUserId == castOther.commentUserId)
			&& (this.commentReviewId == castOther.commentReviewId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.commentUserId;
		hash = hash * prime + this.commentReviewId;
		
		return hash;
	}
}