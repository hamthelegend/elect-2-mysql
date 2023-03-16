DROP SCHEMA IF EXISTS corporation;

CREATE SCHEMA corporation;

USE corporation;

CREATE TABLE departments
(
    department_id   INT         NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(40) NOT NULL,
    PRIMARY KEY (department_id)
);

CREATE TABLE employees
(
    employee_id    INT            NOT NULL AUTO_INCREMENT,
    -- Personal Information
    last_name      TEXT           NOT NULL,
    first_name     TEXT           NOT NULL,
    middle_name    TEXT           NULL,
    birthdate      DATETIME       NOT NULL,
    address        TEXT           NOT NULL,
    contact_number VARCHAR(11)    NOT NULL,
    email_address  TEXT           NOT NULL,
    -- Work Information
    department_id  INT            NOT NULL, -- FK
    position       VARCHAR(20)    NOT NULL,
    -- Salary Information
    hourly_rate    DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (employee_id),
    INDEX fk_department_id_idx (department_id ASC) VISIBLE,
    CONSTRAINT fk_department_id
        FOREIGN KEY (department_id)
            REFERENCES departments (department_id)
            ON DELETE CASCADE
            ON UPDATE RESTRICT
);

CREATE TABLE performance_reviews
(
    performance_review_id INT     NOT NULL AUTO_INCREMENT,
    employee_id           INT     NOT NULL, -- FK
    rating                TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    remarks               TEXT    NOT NULL,
    review_date           DATE    NOT NULL,
    PRIMARY KEY (performance_review_id),
    INDEX fk_employee_id_idx (employee_id ASC) VISIBLE,
    CONSTRAINT fk_performance_employee_id
        FOREIGN KEY (employee_id)
            REFERENCES employees (employee_id)
            ON DELETE CASCADE
            ON UPDATE RESTRICT
);

CREATE TABLE leaves
(
    leave_id    INT  NOT NULL AUTO_INCREMENT,
    employee_id INT  NOT NULL, -- FK
    start_date  DATE NOT NULL,
    end_date    DATE NOT NULL,
    is_paid     BOOL NOT NULL,
    reason      TEXT NULL,
    PRIMARY KEY (leave_id),
    INDEX fk_employee_id_idx (employee_id ASC) VISIBLE,
    CONSTRAINT fk_leave_employee_id
        FOREIGN KEY (employee_id)
            REFERENCES employees (employee_id)
            ON DELETE CASCADE
            ON UPDATE RESTRICT
);