-- DDL --

-- ROLE --
select * from Role;

INSERT INTO `CubeReview`.`Role` (`name`) VALUES ('ADMIN');

INSERT INTO `CubeReview`.`Role` (`name`) VALUES ('MODERATOR');

INSERT INTO `CubeReview`.`Role` (`name`) VALUES ('USER');

-- CUBETYPE --
SELECT * FROM CubeType;

INSERT INTO `CubeReview`.`CubeType` (`type_name`) VALUES ('2x2');

INSERT INTO `CubeReview`.`CubeType` (`type_name`) VALUES ('3x3');

INSERT INTO `CubeReview`.`CubeType` (`type_name`) VALUES ('4x4');

INSERT INTO `CubeReview`.`CubeType` (`type_name`) VALUES ('5x5');

INSERT INTO `CubeReview`.`CubeType` (`type_name`) VALUES ('Pyraminx');

INSERT INTO `CubeReview`.`CubeType` (`type_name`) VALUES ('Megaminx');

INSERT INTO `CubeReview`.`CubeType` (`type_name`) VALUES ('Skewb');

-- CUBE --
SELECT * FROM Cube;

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('epik cube', '2021', 'img', '2');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('speed cube', '2021', 'img', '1');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('big cube', '2021', 'img', '3');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('epik cube', '2021', 'img', '2');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('epik cube', '2021', 'img', '2');
