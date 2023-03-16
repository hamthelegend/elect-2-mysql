DROP SCHEMA IF EXISTS fitnessapp;

CREATE SCHEMA fitnessapp;

USE fitnessapp;

CREATE TABLE users
(
    username          VARCHAR(20) NOT NULL,
    profile_image     BLOB        NULL,
    password          TEXT        NOT NULL,
    fitness_objective TEXT        NULL,
    PRIMARY KEY (username)
);

CREATE TABLE exercises
(
    exercise_id INT         NOT NULL AUTO_INCREMENT,
    name        VARCHAR(20) NOT NULL,
    description TEXT        NOT NULL,
    category    VARCHAR(20) NOT NULL,
    PRIMARY KEY (exercise_id)
);

CREATE TABLE programs
(
    program_id  INT         NOT NULL AUTO_INCREMENT,
    name        VARCHAR(20) NOT NULL,
    description TEXT,
    PRIMARY KEY (program_id)
);

CREATE TABLE program_contents
(
    program_content_id INT NOT NULL AUTO_INCREMENT,
    program_id         INT NOT NULL,
    exercise_id        INT NOT NULL,
    sets               INT NOT NULL,
    reps               INT NOT NULL,
    weights            DECIMAL(10, 2),
    PRIMARY KEY (program_content_id),
    INDEX fk_program_id_idx (program_id ASC) VISIBLE,
    CONSTRAINT fk_program_id
        FOREIGN KEY (program_id)
            REFERENCES programs (program_id)
            ON DELETE CASCADE
            ON UPDATE RESTRICT,
    INDEX fk_exercise_id_idx (exercise_id ASC) VISIBLE,
    CONSTRAINT fk_exercise_id
        FOREIGN KEY (exercise_id)
            REFERENCES exercises (exercise_id)
            ON DELETE CASCADE
            ON UPDATE RESTRICT
);

CREATE TABLE log
(
    log_id     INT         NOT NULL AUTO_INCREMENT,
    start_time DATETIME    NOT NULL,
    end_time   DATETIME    NOT NULL,
    username   VARCHAR(20) NOT NULL,
    -- You can get both the data and the duration from start_time and end_time
    PRIMARY KEY (log_id),
    INDEX fk_username_idx (username ASC) VISIBLE,
    CONSTRAINT fk_username
        FOREIGN KEY (username)
            REFERENCES users (username)
            ON DELETE CASCADE
            ON UPDATE RESTRICT
);

CREATE TABLE log_contents
(
    log_content_id INT NOT NULL AUTO_INCREMENT,
    log_id         INT NOT NULL,
    exercise_id    INT NOT NULL,
    sets           INT NOT NULL,
    reps           INT NOT NULL,
    weights        DECIMAL(10, 2),
    PRIMARY KEY (log_content_id),
    INDEX fk_log_id_idx (log_id ASC) VISIBLE,
    CONSTRAINT fk_log_log_id
        FOREIGN KEY (log_id)
            REFERENCES log (log_id)
            ON DELETE CASCADE
            ON UPDATE RESTRICT,
    INDEX fk_exercise_id_idx (exercise_id ASC) VISIBLE,
    CONSTRAINT fk_log_exercise_id
        FOREIGN KEY (exercise_id)
            REFERENCES exercises (exercise_id)
            ON DELETE CASCADE
            ON UPDATE RESTRICT
);