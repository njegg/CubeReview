package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the FollowUser database table.
 * 
 */
@Entity
@NamedQuery(name="FollowUser.findAll", query="SELECT f FROM FollowUser f")
public class FollowUser implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private FollowUserPK id;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="follow_date")
	private Date followDate;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="follower_id", updatable = false, insertable = false)
	private User user1;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="followed_id", updatable = false, insertable = false)
	private User user2;

	public FollowUser() {
	}

	public FollowUserPK getId() {
		return this.id;
	}

	public void setId(FollowUserPK id) {
		this.id = id;
	}

	public Date getFollowDate() {
		return this.followDate;
	}

	public void setFollowDate(Date followDate) {
		this.followDate = followDate;
	}

	public User getUser1() {
		return this.user1;
	}

	public void setUser1(User user1) {
		this.user1 = user1;
	}

	public User getUser2() {
		return this.user2;
	}

	public void setUser2(User user2) {
		this.user2 = user2;
	}

}