DROP SCHEMA IF EXISTS onlinebookstore;

CREATE SCHEMA onlinebookstore;

USE onlinebookstore;

CREATE TABLE authors
(
    author_id INT  NOT NULL AUTO_INCREMENT,
    name      TEXT NOT NULL,
    biography TEXT NULL,
    PRIMARY KEY (author_id)
);

CREATE TABLE publishers
(
    publisher_id INT  NOT NULL AUTO_INCREMENT,
    name         TEXT NOT NULL,
    address      TEXT NOT NULL,
    PRIMARY KEY (publisher_id)
);

CREATE TABLE books
(
    isbn             VARCHAR(13)    NOT NULL,
    title            TEXT           NOT NULL,
    publication_date DATE           NOT NULL,
    price            DECIMAL(10, 2) NOT NULL,
    description      TEXT           NULL,
    author_id        INT            NOT NULL,
    publisher_id     INT            NOT NULL,
    PRIMARY KEY (isbn),
    INDEX fk_author_id_idx (author_id ASC) VISIBLE,
    CONSTRAINT fk_author_id
        FOREIGN KEY (author_id)
            REFERENCES authors (author_id)
            ON DELETE CASCADE
            ON UPDATE RESTRICT,
    INDEX fk_publisher_id_idx (publisher_id ASC) VISIBLE,
    CONSTRAINT fk_publisher_id
        FOREIGN KEY (publisher_id)
            REFERENCES publishers (publisher_id)
            ON DELETE CASCADE
            ON UPDATE RESTRICT
);

CREATE TABLE customers
(
    customer_id   INT  NOT NULL AUTO_INCREMENT,
    name          TEXT NOT NULL,
    email_address TEXT NOT NULL,
    password      TEXT NOT NULL,
    PRIMARY KEY (customer_id)
);

CREATE TABLE orders
(
    order_id         INT         NOT NULL AUTO_INCREMENT,
    date             DATE        NOT NULL,
    status           VARCHAR(20) NOT NULL,
    -- total_price can be generated from book prices
    shipping_address TEXT        NOT NULL,
    customer_id      INT         NOT NULL,
    PRIMARY KEY (order_id),
    INDEX fk_customer_id_idx (customer_id ASC) VISIBLE,
    CONSTRAINT fk_customer_id
        FOREIGN KEY (customer_id)
            REFERENCES customers (customer_id)
            ON DELETE CASCADE
            ON UPDATE RESTRICT
);

-- Bridge table that relates books to orders
CREATE TABLE order_contents
(
    order_content_id INT         NOT NULL AUTO_INCREMENT,
    order_id         INT         NOT NULL,
    book_isbn        VARCHAR(13) NOT NULL,
    INDEX fk_order_id_idx (order_id ASC) VISIBLE,
    PRIMARY KEY (order_content_id),
    CONSTRAINT fk_order_id
        FOREIGN KEY (order_id)
            REFERENCES orders (order_id)
            ON DELETE CASCADE
            ON UPDATE RESTRICT,
    INDEX fk_book_isbn_idx (book_isbn ASC) VISIBLE,
    CONSTRAINT fk_book_isbn
        FOREIGN KEY (book_isbn)
            REFERENCES books (isbn)
            ON DELETE CASCADE
            ON UPDATE RESTRICT
);

CREATE TABLE shipments
(
    tracking_number VARCHAR(40) NOT NULL,
    shipping_date   DATE        NOT NULL,
    delivery_date   DATE        NOT NULL,
    status          VARCHAR(20) NOT NULL,
    order_id        INT         NOT NULL,
    PRIMARY KEY (tracking_number),
    INDEX fk_order_id_idx (order_id ASC) VISIBLE,
    CONSTRAINT fk_shipment_order_id
        FOREIGN KEY (order_id)
            REFERENCES orders (order_id)
            ON DELETE CASCADE
            ON UPDATE RESTRICT
);