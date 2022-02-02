package model;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the FollowUser database table.
 * 
 */
@Embeddable
public class FollowUserPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="follower_id", insertable=false, updatable=false)
	private int followerId;

	@Column(name="followed_id", insertable=false, updatable=false)
	private int followedId;

	public FollowUserPK() {
	}
	public int getFollowerId() {
		return this.followerId;
	}
	public void setFollowerId(int followerId) {
		this.followerId = followerId;
	}
	public int getFollowedId() {
		return this.followedId;
	}
	public void setFollowedId(int followedId) {
		this.followedId = followedId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof FollowUserPK)) {
			return false;
		}
		FollowUserPK castOther = (FollowUserPK)other;
		return 
			(this.followerId == castOther.followerId)
			&& (this.followedId == castOther.followedId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.followerId;
		hash = hash * prime + this.followedId;
		
		return hash;
	}
}