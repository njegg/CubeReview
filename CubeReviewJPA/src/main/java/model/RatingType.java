package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the RatingType database table.
 * 
 */
@Entity
@NamedQuery(name="RatingType.findAll", query="SELECT r FROM RatingType r")
public class RatingType implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="rating_type_id")
	private int ratingTypeId;

	private int rating;

	@Column(name="rating_name")
	private String ratingName;

	//bi-directional many-to-many association to Review
	@ManyToMany(mappedBy="ratingTypes")
	private List<Review> reviews;

	public RatingType() {
	}

	public int getRatingTypeId() {
		return this.ratingTypeId;
	}

	public void setRatingTypeId(int ratingTypeId) {
		this.ratingTypeId = ratingTypeId;
	}

	public int getRating() {
		return this.rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getRatingName() {
		return this.ratingName;
	}

	public void setRatingName(String ratingName) {
		this.ratingName = ratingName;
	}

	public List<Review> getReviews() {
		return this.reviews;
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

}