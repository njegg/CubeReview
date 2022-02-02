package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the Cube database table.
 * 
 */
@Entity
@NamedQuery(name="Cube.findAll", query="SELECT c FROM Cube c")
public class Cube implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="cube_id")
	private int cubeId;

	@Column(name="image_path")
	private String imagePath;

	private String name;

	@Column(name="release_year")
	private int releaseYear;

	//bi-directional many-to-one association to CubeType
	@ManyToOne
	@JoinColumn(name="cube_cube_type_id")
	private CubeType cubeType;

	//bi-directional many-to-one association to Review
	@OneToMany(mappedBy="cube")
	private List<Review> reviews;

	//bi-directional many-to-many association to User
	@ManyToMany(mappedBy="cubes")
	private List<User> users;

	public Cube() {
	}

	public int getCubeId() {
		return this.cubeId;
	}

	public void setCubeId(int cubeId) {
		this.cubeId = cubeId;
	}

	public String getImagePath() {
		return this.imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getReleaseYear() {
		return this.releaseYear;
	}

	public void setReleaseYear(int releaseYear) {
		this.releaseYear = releaseYear;
	}

	public CubeType getCubeType() {
		return this.cubeType;
	}

	public void setCubeType(CubeType cubeType) {
		this.cubeType = cubeType;
	}

	public List<Review> getReviews() {
		return this.reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public Review addReview(Review review) {
		getReviews().add(review);
		review.setCube(this);

		return review;
	}

	public Review removeReview(Review review) {
		getReviews().remove(review);
		review.setCube(null);

		return review;
	}

	public List<User> getUsers() {
		return this.users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

}