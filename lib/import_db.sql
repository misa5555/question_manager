CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255)  NOT NULL
);

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255)  NOT NULL,
  user_id  INTEGER
);

CREATE TABLE question_followers(
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER
);

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  parent_reply_id INTEGER,
  user_id INTEGER,
  body VARCHAR(255)  NOT NULL
);

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER
);

INSERT INTO 
  users ("fname", "lname") 
VALUES 
  ("Michael", "Jackson"), ("Bill", "Clinton"), ("Bill", "Nye");
  
INSERT INTO
  questions ("title", "body", "user_id")
VALUES
  ("Wealth", "How can I get rich?", 3), ("AppAcademy", "How do I finish all the work in time?", 2);

INSERT INTO
  question_followers ("user_id", "question_id")
VALUES
  (1, 1), (2, 1), (3, 2);

INSERT INTO
  replies ("question_id", "parent_reply_id", "user_id", "body")
VALUES
  (1, NULL, 2, "Inheritance."), (1, 1, 1, "I had to work hard for it."),
  (2, NULL, 3, "Stay focused.");

INSERT INTO
  question_likes ("user_id", "question_id")
VALUES
  (2, 1), (1, 1), (3, 1), (3, 2);