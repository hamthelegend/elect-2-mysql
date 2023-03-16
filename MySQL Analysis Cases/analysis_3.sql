DROP SCHEMA IF EXISTS blog;

CREATE SCHEMA blog;

USE blog;

CREATE TABLE users
(
    username      VARCHAR(20) NOT NULL,
    email_address TEXT        NOT NULL,
    password      TEXT        NOT NULL,
    profile_photo BLOB        NULL,
    PRIMARY KEY (username)
);

CREATE TABLE blogs
(
    blog_id         INT         NOT NULL AUTO_INCREMENT,
    title           VARCHAR(20) NOT NULL,
    body            TEXT        NOT NULL,
    creation_date   DATE,
    author_username VARCHAR(20) NOT NULL,
    PRIMARY KEY (blog_id),
    INDEX fk_username_idx (author_username ASC) VISIBLE,
    CONSTRAINT fk_username
        FOREIGN KEY (author_username)
            REFERENCES users (username)
            ON DELETE CASCADE
            ON UPDATE RESTRICT
);

CREATE TABLE comments
(
    comment_id      INT         NOT NULL AUTO_INCREMENT,
    body            TEXT        NOT NULL,
    creation_date   DATE,
    author_username VARCHAR(20) NOT NULL,
    blog_id         INT         NOT NULL,
    PRIMARY KEY (comment_id),
    INDEX fk_username_idx (author_username ASC) VISIBLE,
    CONSTRAINT fk_comment_username
        FOREIGN KEY (author_username)
            REFERENCES users (username)
            ON DELETE CASCADE
            ON UPDATE RESTRICT,
    INDEX fk_blog_id_idx (blog_id ASC) VISIBLE,
    CONSTRAINT fk_blog_id
        FOREIGN KEY (blog_id)
            REFERENCES blogs (blog_id)
            ON DELETE CASCADE
            ON UPDATE RESTRICT
);