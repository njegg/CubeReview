package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the CubeType database table.
 * 
 */
@Entity
@NamedQuery(name="CubeType.findAll", query="SELECT c FROM CubeType c")
public class CubeType implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="cube_type_id")
	private int cubeTypeId;

	@Column(name="type_name")
	private String typeName;

	//bi-directional many-to-one association to Cube
	@OneToMany(mappedBy="cubeType")
	private List<Cube> cubes;

	public CubeType() {
	}

	public int getCubeTypeId() {
		return this.cubeTypeId;
	}

	public void setCubeTypeId(int cubeTypeId) {
		this.cubeTypeId = cubeTypeId;
	}

	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public List<Cube> getCubes() {
		return this.cubes;
	}

	public void setCubes(List<Cube> cubes) {
		this.cubes = cubes;
	}

	public Cube addCube(Cube cube) {
		getCubes().add(cube);
		cube.setCubeType(this);

		return cube;
	}

	public Cube removeCube(Cube cube) {
		getCubes().remove(cube);
		cube.setCubeType(null);

		return cube;
	}

}