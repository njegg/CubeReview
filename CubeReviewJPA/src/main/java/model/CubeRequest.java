package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the CubeRequest database table.
 * 
 */
@Entity
@NamedQuery(name="CubeRequest.findAll", query="SELECT c FROM CubeRequest c")
public class CubeRequest implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="cube_request_id")
	private int cubeRequestId;

	private int approved;

	private String content;

	@Column(name="cube_name")
	private String cubeName;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="cube_request_user_id")
	private User user;

	public CubeRequest() {
	}

	public int getCubeRequestId() {
		return this.cubeRequestId;
	}

	public void setCubeRequestId(int cubeRequestId) {
		this.cubeRequestId = cubeRequestId;
	}

	public int getApproved() {
		return this.approved;
	}

	public void setApproved(int approved) {
		this.approved = approved;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCubeName() {
		return this.cubeName;
	}

	public void setCubeName(String cubeName) {
		this.cubeName = cubeName;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}