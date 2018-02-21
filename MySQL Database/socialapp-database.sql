﻿--
-- Script was generated by Devart dbForge Studio for MySQL, Version 7.2.58.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 6/19/2017 1:32:34 AM
-- Server version: 5.1.73
-- Client version: 4.1
--


-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

-- 
-- Set default database
--
USE socialapp;

--
-- Definition for table blocked
--
DROP TABLE IF EXISTS blocked;
CREATE TABLE blocked (
  id INT(11) NOT NULL AUTO_INCREMENT,
  blocked_user INT(11) NOT NULL,
  blocked_by INT(11) NOT NULL,
  creation DATETIME NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 16384
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table comment_replies
--
DROP TABLE IF EXISTS comment_replies;
CREATE TABLE comment_replies (
  id INT(11) NOT NULL AUTO_INCREMENT,
  comment_id INT(11) DEFAULT NULL,
  user_id INT(11) DEFAULT NULL,
  content TEXT DEFAULT NULL,
  creation DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 167
AVG_ROW_LENGTH = 93
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table comments
--
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id INT(11) NOT NULL AUTO_INCREMENT,
  post_id INT(11) NOT NULL,
  user_id INT(11) NOT NULL,
  content TEXT NOT NULL,
  creation DATETIME NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 395
AVG_ROW_LENGTH = 214
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table follow_post
--
DROP TABLE IF EXISTS follow_post;
CREATE TABLE follow_post (
  postId INT(11) NOT NULL,
  userId INT(11) NOT NULL
)
ENGINE = MYISAM
AVG_ROW_LENGTH = 9
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table followers
--
DROP TABLE IF EXISTS followers;
CREATE TABLE followers (
  id INT(11) NOT NULL AUTO_INCREMENT,
  follower INT(11) NOT NULL,
  following INT(11) NOT NULL,
  creation DATETIME NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 325
AVG_ROW_LENGTH = 60
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table friends
--
DROP TABLE IF EXISTS friends;
CREATE TABLE friends (
  id INT(11) NOT NULL AUTO_INCREMENT,
  user_id INT(11) DEFAULT NULL,
  user_with INT(11) DEFAULT NULL,
  status INT(11) DEFAULT NULL,
  creation DATETIME DEFAULT NULL,
  action_user_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 220
AVG_ROW_LENGTH = 99
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table likes
--
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT(11) NOT NULL AUTO_INCREMENT,
  post_id INT(11) NOT NULL,
  user_id INT(11) NOT NULL,
  isLiked INT(11) NOT NULL,
  creation DATETIME NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 516
AVG_ROW_LENGTH = 136
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table messages
--
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
  id INT(11) NOT NULL AUTO_INCREMENT,
  sender INT(11) DEFAULT NULL,
  receiver INT(11) DEFAULT NULL,
  type INT(11) DEFAULT NULL,
  message VARCHAR(255) DEFAULT NULL,
  creation DATETIME DEFAULT NULL,
  isSent INT(11) DEFAULT 0,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 2318
AVG_ROW_LENGTH = 146
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table notifications
--
DROP TABLE IF EXISTS notifications;
CREATE TABLE notifications (
  id INT(11) DEFAULT NULL,
  user INT(11) NOT NULL,
  commentId INT(11) DEFAULT 0,
  postId INT(11) DEFAULT 0,
  userId INT(11) NOT NULL,
  username VARCHAR(255) DEFAULT NULL,
  action INT(11) DEFAULT NULL,
  messageData VARCHAR(255) DEFAULT NULL,
  creation DATETIME NOT NULL,
  isRead INT(11) DEFAULT 0
)
ENGINE = INNODB
AVG_ROW_LENGTH = 142
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table posts
--
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT(11) NOT NULL AUTO_INCREMENT,
  user_id INT(11) NOT NULL,
  type INT(11) NOT NULL,
  audience INT(11) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  content TEXT DEFAULT NULL,
  isShared INT(11) DEFAULT 0,
  shared_id INT(11) DEFAULT 0,
  shared_post_id INT(11) DEFAULT 0,
  creation DATETIME NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 420
AVG_ROW_LENGTH = 273
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table reports
--
DROP TABLE IF EXISTS reports;
CREATE TABLE reports (
  id INT(11) NOT NULL AUTO_INCREMENT,
  postId INT(11) DEFAULT NULL,
  report_by INT(11) DEFAULT NULL,
  action INT(11) DEFAULT NULL,
  reason TEXT DEFAULT NULL,
  creation DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 19
AVG_ROW_LENGTH = 42
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table users
--
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password TEXT NOT NULL,
  registration_id TEXT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  api TEXT NOT NULL,
  relationship INT(11) DEFAULT 0,
  gender INT(11) DEFAULT 0,
  isVerified INT(11) DEFAULT 0,
  location VARCHAR(255) DEFAULT NULL,
  profilePhoto TEXT DEFAULT NULL,
  profileLink TEXT DEFAULT NULL,
  created_At DATETIME NOT NULL,
  longitude DOUBLE DEFAULT NULL,
  latitude DOUBLE DEFAULT NULL,
  isDisabled INT(11) DEFAULT 0,
  disableReason VARCHAR(255) NOT NULL,
  appVersion VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = MYISAM
AUTO_INCREMENT = 228
AVG_ROW_LENGTH = 514
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

DELIMITER $$

--
-- Definition for function addComment
--
DROP FUNCTION IF EXISTS addComment$$
CREATE DEFINER = 'root'@'%'
FUNCTION addComment(postId INT, userId INT, comment TEXT, creation DATETIME)
  RETURNS int(11)
BEGIN
  DECLARE has_error INT;
  DECLARE postHolder INT;
  DECLARE lastId INT;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET has_error = 1;
  SET has_error = 0;
  SELECT user_id INTO postHolder FROM posts WHERE id = postId;
  IF (postHolder != 0) THEN
  INSERT INTO comments (post_id, user_id, content, creation) VALUES (postId, userId, comment, creation);
  IF (has_error = 0 && LAST_INSERT_ID() != 0) THEN
    SET lastId = LAST_INSERT_ID();
    RETURN lastId;
  ELSE
    RETURN 0;
  END IF;
  ELSE
    RETURN 0;
  END IF;
END
$$

--
-- Definition for function addCommentReply
--
DROP FUNCTION IF EXISTS addCommentReply$$
CREATE DEFINER = 'root'@'%'
FUNCTION addCommentReply(commentId INT, userId INT, comment TEXT, creation DATETIME)
  RETURNS int(11)
BEGIN
  DECLARE has_error INT;
  DECLARE lastId INT;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET has_error = 1;
  SET has_error = 0;
  INSERT INTO comment_replies (comment_id, user_id, content, creation) VALUES (commentId, userId, comment, creation);
  IF (has_error = 0 && LAST_INSERT_ID() != 0) THEN
    SET lastId = LAST_INSERT_ID();
    RETURN lastId;
  ELSE
    RETURN 0;
  END IF;
END
$$

--
-- Definition for function addMessage
--
DROP FUNCTION IF EXISTS addMessage$$
CREATE DEFINER = 'root'@'%'
FUNCTION addMessage(r VARCHAR(255), s INT, t INT, m VARCHAR(255), creation DATETIME)
  RETURNS int(11)
  DETERMINISTIC
BEGIN
   DECLARE lastID INT;
   INSERT INTO messages (receiver, sender, type, message, creation) values(r, s, t, m, creation);
   SET lastID = LAST_INSERT_ID();
   RETURN lastID;
END
$$

--
-- Definition for function addPost
--
DROP FUNCTION IF EXISTS addPost$$
CREATE DEFINER = 'root'@'%'
FUNCTION addPost(pUserId INT, pAudience INT, pType INT, pContent TEXT, pDescription TEXT, pCreation DATETIME)
  RETURNS int(11)
BEGIN
  DECLARE has_error INT;
  DECLARE lastId INT;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET has_error = 1;
  SET has_error = 0;
  INSERT INTO posts (user_id, audience, type, description, content, creation) VALUES (pUserId, pAudience, pType, pDescription, pContent, pCreation);
  IF (has_error = 0 && LAST_INSERT_ID() != 0) THEN
    SET lastId = LAST_INSERT_ID();
    RETURN lastId;
  ELSE
    RETURN 0;
  END IF;
END
$$

--
-- Definition for function deleteAccount
--
DROP FUNCTION IF EXISTS deleteAccount$$
CREATE DEFINER = 'root'@'%'
FUNCTION deleteAccount(p_user_id INT)
  RETURNS int(11)
BEGIN
  DECLARE has_error INT;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET has_error = 1;
  SET has_error = 0;
  DELETE FROM blocked WHERE blocked_user = p_user_id OR blocked_by = p_user_id;
  DELETE FROM comments WHERE user_id = p_user_id;
  DELETE FROM followers WHERE follower = p_user_id OR following = p_user_id;
  DELETE FROM likes WHERE user_id = p_user_id;
  DELETE FROM notifications WHERE user = p_user_id;
  DELETE FROM posts WHERE user_id = p_user_id;
  DELETE FROM follow_post WHERE userId = p_user_id;
  DELETE FROM friends WHERE user_id = p_user_id OR user_with = p_user_id;
  DELETE FROM users WHERE id = p_user_id;
  RETURN has_error;
END
$$

--
-- Definition for function deleteComment
--
DROP FUNCTION IF EXISTS deleteComment$$
CREATE DEFINER = 'root'@'%'
FUNCTION deleteComment(postId INT, userId INT, comment_id_ INT)
  RETURNS int(11)
BEGIN
  DECLARE has_error INT;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET has_error = 1;
  SET has_error = 0;
  DELETE FROM comments WHERE post_id = post_id AND id = comment_id_;
  DELETE FROM comment_replies WHERE comment_id = comment_id_;
  DELETE FROM notifications WHERE commentId = comment_id_ AND action = 1;
  RETURN has_error;
END
$$

--
-- Definition for function deletePost
--
DROP FUNCTION IF EXISTS deletePost$$
CREATE DEFINER = 'root'@'%'
FUNCTION deletePost(p_userId INT, p_postId INT)
  RETURNS int(11)
BEGIN
  DECLARE has_error INT;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET has_error = 1;
  SET has_error = 0;
  DELETE FROM posts WHERE id = p_postId AND user_id = p_userId;
  DELETE FROM likes WHERE post_id = p_postId;
  DELETE FROM comments WHERE post_id = p_postId;
  DELETE FROM follow_post WHERE postId = p_postId;
  DELETE FROM notifications WHERE postId = p_postId;
  RETURN has_error;
RETURN 1;
END
$$

--
-- Definition for function deleteReply
--
DROP FUNCTION IF EXISTS deleteReply$$
CREATE DEFINER = 'root'@'%'
FUNCTION deleteReply(commentId_ INT, userId INT, replyId INT)
  RETURNS int(11)
BEGIN
  DECLARE has_error INT;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET has_error = 1;
  SET has_error = 0;
  DELETE FROM comment_replies WHERE comment_id = commentId_ AND id = replyId;
  DELETE FROM notifications WHERE commentId = commentId_ AND action = 4;
  RETURN has_error;
END
$$

--
-- Definition for function sharePost
--
DROP FUNCTION IF EXISTS sharePost$$
CREATE DEFINER = 'root'@'%'
FUNCTION sharePost(userId INT, type_param_ INT, audience_ INT, description_ TEXT, content_ TEXT, share_post_id_ INT, shared_id_ INT, creation_ DATETIME)
  RETURNS int(11)
BEGIN
  DECLARE has_error INT;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET has_error = 1;
  SET has_error = 0;
  INSERT INTO posts (user_id, type, audience, description, content, isShared, shared_id, shared_post_id, creation) VALUES (userId, type_param_, audience_, description_, content_, 1, shared_id_, share_post_id_, creation_);
  IF (has_error = 0 && LAST_INSERT_ID() != 0) THEN
    RETURN 0;
  END IF;
 RETURN 1;
END
$$

--
-- Definition for function updateLike
--
DROP FUNCTION IF EXISTS updateLike$$
CREATE DEFINER = 'root'@'%'
FUNCTION updateLike(postId_ INT, userId_ INT, creation_ DATETIME, action_ INT)
  RETURNS int(11)
BEGIN
  DECLARE has_error INT;
  DECLARE postHolder INT;
  DECLARE isLikedId INT;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET has_error = 1;
  SET has_error = 0;
  SET isLikedId = 0;
  SELECT user_id INTO postHolder FROM posts WHERE id = postId_;
  SELECT id INTO isLikedId FROM likes WHERE post_id = postId_ AND user_id = userId_;
   IF (isLikedId != 0) THEN
     UPDATE likes SET isLiked = action_ WHERE id = isLikedId AND user_id = userId_;
   ELSE
     INSERT INTO likes (post_id, user_id, creation, isLiked) VALUES (postId_, userId_, creation_, action_);
   END IF;
 RETURN has_error;
END
$$

DELIMITER ;

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;