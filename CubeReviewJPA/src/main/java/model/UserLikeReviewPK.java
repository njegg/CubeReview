package model;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the UserLikeReview database table.
 * 
 */
@Embeddable
public class UserLikeReviewPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="like_user_id", insertable=false, updatable=false)
	private int likeUserId;

	@Column(name="like_review_id", insertable=false, updatable=false)
	private int likeReviewId;

	public UserLikeReviewPK() {
	}
	public int getLikeUserId() {
		return this.likeUserId;
	}
	public void setLikeUserId(int likeUserId) {
		this.likeUserId = likeUserId;
	}
	public int getLikeReviewId() {
		return this.likeReviewId;
	}
	public void setLikeReviewId(int likeReviewId) {
		this.likeReviewId = likeReviewId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof UserLikeReviewPK)) {
			return false;
		}
		UserLikeReviewPK castOther = (UserLikeReviewPK)other;
		return 
			(this.likeUserId == castOther.likeUserId)
			&& (this.likeReviewId == castOther.likeReviewId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.likeUserId;
		hash = hash * prime + this.likeReviewId;
		
		return hash;
	}
}