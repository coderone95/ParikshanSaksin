CREATE TABLE `tbl_users` (
  `user_id` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT '',
  `email_id` varchar(40) NOT NULL DEFAULT '',
  `password` varchar(50) DEFAULT '',
  `user_type` varchar(45) DEFAULT '',
  `phone_number` varchar(20) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `is_disabled` tinyint(1) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `unique_key` (`user_id`),
  UNIQUE KEY `UNIQUE_KEY_11` (`email_id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=latin1;


CREATE TABLE `tbl_mst_user_type` (
  `user_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type` varchar(40) NOT NULL,
  `isManagment_User` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;


CREATE TABLE `tbl_request_log` (
  `request_id` int(10) NOT NULL AUTO_INCREMENT,
  `request_name` varchar(40) NOT NULL,
  `created_by` varchar(40) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  PRIMARY KEY (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `tbl_mst_user_type` (`user_type`, `isManagment_User`)
VALUES
  ('ADMIN', 1),
  ('CANDIDATE', 0),
  ('SUPERADMIN', 1),
  ('EXAMINER', 1),
  ('REVIEWER', 1);



---- Date : 26-9-2019 -------
CREATE TABLE `tbl_mst_user_type` (
	`user_type_id` INT NOT NULL AUTO_INCREMENT,
	`user_type` VARCHAR(40) NOT NULL,
	PRIMARY KEY (`user_type_id`)
);


CREATE TABLE `tbl_users` (
	`user_id` INT(12) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL,
	`login_id` VARCHAR(45) NOT NULL,
	`password` VARCHAR(50) NOT NULL,
	`user_type` VARCHAR(45) NOT NULL,
	`is_deleted` TINYINT(1),
	`is_disabled` TINYINT(1),
	`created_on` DATE,
	`updated_on` DATE,
	PRIMARY KEY (`user_id`)
);

	
	ALTER TABLE tbl_users
	ADD CONSTRAINT unique_key UNIQUE (user_id, login_id);


ALTER TABLE tbl_users
ADD user_type_id varchar(45);

alter table tbl_users add email_id varchar(40) after name

alter table tbl_users add phone_number varchar(20) after user_type_id




CREATE TABLE `tbl_request_log` (
	`request_id` INT(10) NOT NULL AUTO_INCREMENT,
	`request_name` VARCHAR(40) NOT NULL,
	`created_by` VARCHAR(40),
	`created_on` DATETIME,
	PRIMARY KEY (`request_id`)
);






------ SQL -------- 5 Dec 2019------

CREATE TABLE `tbl_functionalities` (
  `functionality_id` int(11) NOT NULL AUTO_INCREMENT,
  `functionality_name` varchar(256) DEFAULT NULL,
  `functionality_code` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`functionality_id`),
  UNIQUE KEY `functionality_code` (`functionality_code`)
);

CREATE TABLE `tbl_groups` (
  `group_id` int(12) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(50) NOT NULL DEFAULT '',
  `created_on` datetime(3) DEFAULT NULL,
  `updated_on` datetime(3) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`group_id`)
);

CREATE TABLE `tbl_groups_test` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `org_id` int(12) DEFAULT NULL,
  `test_id` int(12) DEFAULT NULL,
  `group_id` int(12) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `tbl_mst_user_type` (
  `user_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type` varchar(40) NOT NULL,
  `isManagment_User` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_type_id`)
) ;

CREATE TABLE `tbl_que_options` (
  `option_id` int(12) NOT NULL AUTO_INCREMENT,
  `question_id` int(12) DEFAULT NULL,
  `option_value` longtext,
  `isCorrect` tinyint(1) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`option_id`),
  KEY `fk_question_foreign_key` (`question_id`),
  CONSTRAINT `fk_question_foreign_key` FOREIGN KEY (`question_id`) REFERENCES `tbl_questions` (`question_id`)
) ;

CREATE TABLE `tbl_questions` (
  `question_id` int(12) NOT NULL AUTO_INCREMENT,
  `question` longtext NOT NULL,
  `group_id` int(12) DEFAULT NULL,
  `created_on` datetime(3) DEFAULT NULL,
  `updated_on` datetime(3) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`question_id`)
) ;

CREATE TABLE `tbl_questions_group` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `group_id` int(12) DEFAULT NULL,
  `question_id` int(12) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `tbl_request_log` (
  `request_id` int(10) NOT NULL AUTO_INCREMENT,
  `request_name` varchar(40) NOT NULL,
  `created_by` varchar(40) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  PRIMARY KEY (`request_id`)
) ;

CREATE TABLE `tbl_tests` (
  `test_id` int(12) NOT NULL AUTO_INCREMENT,
  `test_name` varchar(50) NOT NULL DEFAULT '',
  `org_id` int(12) DEFAULT NULL,
  `test_time` int(20) DEFAULT '0',
  `access_key` varchar(50) DEFAULT NULL,
  `test_key` varchar(50) DEFAULT NULL,
  `test_instructions` longblob,
  `is_live` tinyint(1) DEFAULT '1',
  `expires_on` datetime DEFAULT NULL,
  `is_disabled` tinyint(1) DEFAULT '0',
  `created_on` datetime(3) DEFAULT NULL,
  `updated_on` datetime(3) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `updated_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`test_id`)
) ;

CREATE TABLE `tbl_user_answered` (
  `user_answered_id` int(12) NOT NULL AUTO_INCREMENT,
  `user_id` int(12) DEFAULT NULL,
  `question_id` int(12) DEFAULT NULL,
  `option_id` int(12) DEFAULT NULL,
  PRIMARY KEY (`user_answered_id`),
  UNIQUE KEY `unique_key_user_ans` (`user_id`,`option_id`)
) ;

CREATE TABLE `tbl_users` (
  `user_id` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT '',
  `email_id` varchar(40) NOT NULL DEFAULT '',
  `password` varchar(50) DEFAULT '',
  `user_type` varchar(45) DEFAULT '',
  `phone_number` varchar(20) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `is_disabled` tinyint(1) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `unique_key` (`user_id`),
  UNIQUE KEY `UNIQUE_KEY_11` (`email_id`)
) ;

CREATE TABLE `tbl_users_privileges` (
  `functionality_id` int(11) NOT NULL,
  `user_type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `privileges` varchar(6) NOT NULL DEFAULT 'NNNNNN',
  PRIMARY KEY (`functionality_id`,`user_type_id`,`user_id`),
  KEY `fk_company_privileges_functionality_id` (`functionality_id`),
  KEY `fk_company_privileges_user_type_id` (`user_type_id`),
  KEY `fk_company_privileges_user_id` (`user_id`),
  CONSTRAINT `fk_users_privileges_functionality_id` FOREIGN KEY (`functionality_id`) REFERENCES `tbl_functionalities` (`functionality_id`),
  CONSTRAINT `fk_users_privileges_user_id` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`user_id`),
  CONSTRAINT `fk_users_privileges_user_type_id` FOREIGN KEY (`user_type_id`) REFERENCES `tbl_mst_user_type` (`user_type_id`)
);


--- Procedures----

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkTestExpire`()
BEGIN
    DECLARE finished INTEGER DEFAULT 0;
    Declare V_id INT ;
    Declare V_d DATETIME;
    Declare V_live TINYINT;
    Declare V_diff INT;
  
    DEClARE curExpireCheck 
        CURSOR FOR 
            SELECT test_id,expires_on,is_live from tbl_tests;
 
    -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
 
    OPEN curExpireCheck;
 
    getExpireDiff: LOOP
        FETCH curExpireCheck INTO V_id,V_d,V_live;
        IF finished = 1 THEN 
            LEAVE getExpireDiff;
        END IF;
        
              SELECT TIMESTAMPDIFF(MINUTE, now(),V_d)  into V_diff ;
              -- select V_diff;
              IF V_diff <= 0  THEN
              	-- Update library set is_live = 0 where library.id = V_id;
                Update tbl_tests set is_live = 0 where tbl_tests.test_id = V_id;
              END IF; 
              
              IF V_d IS NULL THEN
                Update tbl_tests set is_live = 1 where tbl_tests.test_id = V_id;
              END IF;
    	
    END LOOP getExpireDiff;
    CLOSE curExpireCheck;
 
END;;
DELIMITER ;


-- Delete Questions with Ooptions --

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteQuestionWithOptions`(
IN queId int)
BEGIN 
delete from tbl_que_options where question_id = queId;
delete from tbl_questions where question_id = queId;
END;;
DELIMITER ;


-- deleteSelectedGorupWithQuestions- 

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSelectedGorupWithQuestions`(
IN groupID int)
BEGIN 
delete from tbl_questions_group where group_id = groupID;
END;;
DELIMITER ;

--- deleteSelectedGroupFromSelectedTest ---

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSelectedGroupFromSelectedTest`(
IN groupID int,
IN testID int)
BEGIN 
delete from tbl_groups_test where group_id = groupID and test_id = testID;
END;;
DELIMITER ;


--- deleteSelectedQuestionFromGroup -- 

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSelectedQuestionFromGroup`(
IN groupID int,
IN questionID int)
BEGIN 
delete from tbl_questions_group where group_id = groupID and question_id = questionID;
END;;
DELIMITER ;

--- updateOptionsAgainstQuestion---

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateOptionsAgainstQuestion`(
IN optionId int,
IN optoinValue varchar(50),
IN correctOption int)
BEGIN 
Declare  isCorrectOption tinyint DEFAULT 0;
 if optionId = correctOption then 
 	set isCorrectOption = 1;
 end if;
update tbl_que_options set option_value = optoinValue, isCorrect = isCorrectOption where option_id = optionId;
END;;
DELIMITER ;


---- updateQuestion ---


DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateQuestion`(
IN questionID int,
IN questionValue varchar(50),
IN updatedBy varchar(40),
IN updatedOn DATETIME
)
BEGIN 
update tbl_questions set question = questionValue, updated_by = updatedBy, updated_on = updatedOn  where question_id = questionID;
END;;
DELIMITER ;

---- checkTestExpire Procedure and event ----


DELIMITER $$
DROP Procedure IF EXISTS checkTestExpire $$
DELIMITER $$
CREATE PROCEDURE checkTestExpire ()
BEGIN
    DECLARE finished INTEGER DEFAULT 0;
    Declare V_id INT ;
    Declare V_d DATETIME;
    Declare V_live TINYINT;
    Declare V_diff INT;
  
    DEClARE curExpireCheck 
        CURSOR FOR 
            SELECT test_id,expires_on,is_live from tbl_tests;
 
    -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
 
    OPEN curExpireCheck;
 
    getExpireDiff: LOOP
        FETCH curExpireCheck INTO V_id,V_d,V_live;
        IF finished = 1 THEN 
            LEAVE getExpireDiff;
        END IF;
        
              SELECT TIMESTAMPDIFF(MINUTE, now(),V_d)  into V_diff ;
              -- select V_diff;
              IF V_diff <= 0  THEN
                -- Update library set is_live = 0 where library.id = V_id;
                Update tbl_tests set is_live = 0 where tbl_tests.test_id = V_id;
              END IF; 
              
              IF V_d IS NULL THEN
                Update tbl_tests set is_live = 1 where tbl_tests.test_id = V_id;
              END IF;
      
    END LOOP getExpireDiff;
    CLOSE curExpireCheck;
 
END$$
DELIMITER ;



CREATE EVENT checkExpire
    ON SCHEDULE
      EVERY 5 SECOND
    DO
     CALL checkTestExpire();
      

SET GLOBAL event_scheduler = ON; 

SHOW PROCESSLIST;

DROP EVENT event_name;

 SELECT * FROM INFORMATION_SCHEMA.events;
 
 
 
 
 
 -- Date 18 Dec 2019
 
 
	
DELIMITER $$
DROP Procedure IF EXISTS checkTestExpire $$
DELIMITER $$
CREATE PROCEDURE checkTestExpire ()
BEGIN
    DECLARE finished INTEGER DEFAULT 0;
    Declare V_id INT ;
    Declare V_startOn DATETIME;
    Declare V_endOn DATETIME;
    Declare V_live TINYINT;
    Declare V_diff INT;
  
    DEClARE curExpireCheck 
        CURSOR FOR 
            SELECT test_id,startOn, endOn ,is_live from tbl_tests;
 
    -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
 
    OPEN curExpireCheck;
 
    getExpireDiff: LOOP
        FETCH curExpireCheck INTO V_id,V_startOn, V_endOn ,V_live;
        IF finished = 1 THEN 
            LEAVE getExpireDiff;
        END IF;
        
              SELECT TIMESTAMPDIFF(MINUTE, now(),V_endOn)  into V_diff ;
              -- select V_diff;
              IF V_endOn IS NOT NULL THEN
                IF V_diff <= 0  THEN
                	-- Update library set is_live = 0 where library.id = V_id;
                	Update tbl_tests set is_live = 0 where tbl_tests.test_id = V_id;
              	END IF; 
              	IF V_diff > 0  THEN
                	-- Update library set is_live = 0 where library.id = V_id;
                	Update tbl_tests set is_live = 1 where tbl_tests.test_id = V_id;
              	END IF;
              END IF;
              
              IF V_endOn IS NULL THEN
                Update tbl_tests set is_live = 1 where tbl_tests.test_id = V_id;
              END IF;
      
    END LOOP getExpireDiff;
    CLOSE curExpireCheck;
 
END$$
DELIMITER ;



CREATE EVENT checkExpire
    ON SCHEDULE
      EVERY 5 SECOND
    DO
     CALL checkTestExpire();

SET GLOBAL event_scheduler = ON;



-------- 
alter table tbl_functionalities add column user_id int(255) after `functionality_id`

alter table tbl_functionalities add column user_type varchar(255) after `user_id`



ALTER TABLE tbl_functionalities
DROP INDEX functionality_code;


---- 

CREATE TABLE `tbl_mst_functionalities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `functionality_code` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`)
)


------- -----------

insert into tbl_mst_functionalities(functionality_code)
values
	 ('M_DASHBOARD_PAGE'),
	 ('M_USERS_PAGE'),
	 ('M_SHOW_ADMIN_USERS'),
	 ('M_SHOW_EXAMINER_USERS '),
	 ('M_SHOW_REVIEWER_USERS'),
	 ('M_ADD_USER'),
	 ('M_DISABLE_USER'),
	 ('M_ENABLE_USER'),
	 ('M_EDIT_USER'),
	 ('M_DELETE_USER '),
	 ('M_GROUP_PAGE '),
	 ('M_SHOW_GROUPS'),
	 ('M_ADD_GROUP'),
	 ('M_EDIT_GROUP'),
	 ('M_DELETE_GROUP'),
	 ('M_TEST_PAGE'),
	 ('M_ADD_TEST '),
	 ('M_EDIT_TEST '),
	 ('M_DELETE_TEST'), 
	 ('M_QUESTIONS_PAGE'),
	 ('M_SHOW_QUESTIONS'),
	 ('M_ADD_QUESTION'),
	 ('M_EDIT_QUESTION'),
	 ('M_DELETE_QUESTION'),
	 ('M_ADD_QUESTIONS_TO_GROUP'),
	 ('M_SHOW_ADDED_QUESTIONS_TO_GROUP'),
	 ('M_DELETE_QUESTIONS_FROM_GROUP');

insert into tbl_mst_functionalities(functionality_code) values('ADD_ADMIN_USER'),('ADD_EXAMINER_USER'),('ADD_REVIEWER_USER'),('ADD_CANDIDATE_USER')


CREATE TABLE `tbl_otp` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `user_id` int(100) NOT NULL,
  `otp` varchar(100) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key_` (`id`),
  UNIQUE KEY `unique_user_id_key` (`user_id`)
);

alter table tbl_otp add column created_on datetime


--- OTP expire ----
	
DELIMITER $$
DROP Procedure IF EXISTS checkOTPExpire $$
DELIMITER $$
CREATE PROCEDURE checkOTPExpire ()
BEGIN
    DECLARE finished INTEGER DEFAULT 0;
    Declare V_id INT ;
    Declare V_createdOn DATETIME;
    Declare V_otp VARCHAR(255);
    Declare V_diff INT;
  
    DEClARE curOTPExpireCheck 
        CURSOR FOR 
            SELECT user_id, otp, created_on from tbl_otp;
 
    -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
 
    OPEN curOTPExpireCheck;
 
    getExpireDiff: LOOP
        FETCH curOTPExpireCheck INTO V_id, V_otp, V_createdOn;
        IF finished = 1 THEN 
            LEAVE getExpireDiff;
        END IF;
        
              SELECT TIMESTAMPDIFF(MINUTE, now(),V_createdOn)  into V_diff ;
              -- select V_diff;
              IF V_createdOn IS NOT NULL THEN
                IF V_diff <= 0  THEN
                	Update tbl_otp set otp = NULL where tbl_otp.user_id = V_id;
              	END IF; 
              END IF;
      
    END LOOP getExpireDiff;
    CLOSE curOTPExpireCheck;
 
END$$
DELIMITER ;


CREATE EVENT checkOTPExpire
    ON SCHEDULE
      EVERY 1 SECOND
    DO
     CALL checkOTPExpire();
     
     
SET GLOBAL event_scheduler = ON;



-- -------------------------
-- Date : 1st June 2020 Description: Add new column in tbl_user_answered
-- ----------------------

alter table tbl_user_answered add column test_id int(255) after `user_id`


drop table tbl_user_answered 

CREATE TABLE `tbl_user_answered` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `test_answered_context_id` int(255) DEFAULT NULL,
  `question_id` int(255) DEFAULT NULL,
  `answer_id` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  KEY `test_answered_context_id` (`test_answered_context_id`),
  CONSTRAINT `tbl_user_answered_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `tbl_questions` (`question_id`),
  CONSTRAINT `tbl_user_answered_ibfk_2` FOREIGN KEY (`test_answered_context_id`) REFERENCES `tbl_test_submission_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `tbl_test_submission_details` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) DEFAULT NULL,
  `test_id` int(255) DEFAULT NULL,
  `test_start_time` datetime DEFAULT NULL,
  `submitted_successfully` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `test_id` (`test_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tbl_test_submission_details_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `tbl_tests` (`test_id`),
  CONSTRAINT `tbl_test_submission_details_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE tbl_attended_test_details
DROP COLUMN test_started_time;


ALTER TABLE tbl_attended_test_details
DROP COLUMN test_ended_time;

alter table tbl_test_submission_details add column test_end_time datetime after `test_start_time`