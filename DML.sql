-- DDL --

-- ROLE --

INSERT INTO `CubeReview`.`Role` (`name`) VALUES ('ADMIN');

INSERT INTO `CubeReview`.`Role` (`name`) VALUES ('MODERATOR');

INSERT INTO `CubeReview`.`Role` (`name`) VALUES ('USER');

-- CUBETYPE --

INSERT INTO `CubeReview`.`CubeType` (`type_name`) VALUES ('2x2');

INSERT INTO `CubeReview`.`CubeType` (`type_name`) VALUES ('3x3');

INSERT INTO `CubeReview`.`CubeType` (`type_name`) VALUES ('4x4');

INSERT INTO `CubeReview`.`CubeType` (`type_name`) VALUES ('Pyraminx');

INSERT INTO `CubeReview`.`CubeType` (`type_name`) VALUES ('Skewb');

-- CUBE --

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('GAN 356 M', '2021', 'img', '2');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('Cubelelo Little Magic', '2021', 'img', '2');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('MFJS RS3M', '2020', 'img', '2');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('GAN 11 M', '2021', 'img', '2');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('Meilong 4x4 Elite M', '2022', 'img', '3');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('YJ ZhiLong Mini 4x4', '2019', 'img', '3');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('Meilong 2M', '2022', 'img', '1');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('GAN 251 M', '2021', 'img', '1');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('GAN Pyraminx', '2020', 'img', '4');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('QiYi Bell Pyraminx v2', '2021', 'img', '4');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('Meilong Pyraminx Magnetic', '2021', 'img', '4');

INSERT INTO `CubeReview`.`Cube` (`name`, `release_year`, `image_path`, `cube_cube_type_id`)
VALUES ('The MoYu skewb', '2020', 'img', '5');

