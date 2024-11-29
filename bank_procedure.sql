-- DROP TABLE IF EXISTS

DROP TABLE IF EXISTS statement_detail;
DROP TABLE IF EXISTS credit_card_payment_detail;
DROP TABLE IF EXISTS credit_card;
DROP TABLE IF EXISTS debit_card_payment_detail;
DROP TABLE IF EXISTS debit_card;
DROP TABLE IF EXISTS account_book;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS branch;

-- CREATE TABLE

CREATE TABLE `branch` (
  `branch_number` varchar(50) NOT NULL,
  `branch_name` varchar(50) DEFAULT NULL,
  `branch_address` varchar(100) DEFAULT NULL,
  `branch_city` varchar(50) DEFAULT NULL,
  `branch_post_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`branch_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_first_name` varchar(50) DEFAULT NULL,
  `employee_last_name` varchar(50) DEFAULT NULL,
  `employee_title` varchar(50) DEFAULT NULL,
  `employee_start_date` date DEFAULT NULL,
  `employee_branch_number` varchar(50) DEFAULT NULL,
  `employee_salary` int(11) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `employee_branch_number` (`employee_branch_number`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`employee_branch_number`) REFERENCES `branch` (`branch_number`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name_title` varchar(50) DEFAULT NULL,
  `customer_first_name` varchar(50) DEFAULT NULL,
  `customer_last_name` varchar(50) DEFAULT NULL,
  `customer_gender` varchar(50) DEFAULT NULL,
  `customer_job` varchar(50) DEFAULT NULL,
  `customer_address` varchar(100) DEFAULT NULL,
  `customer_country` varchar(50) DEFAULT NULL,
  `customer_post_code` varchar(50) DEFAULT NULL,
  `customer_email` varchar(50) DEFAULT NULL,
  `customer_telephone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

CREATE TABLE `account_book` (
  `account_number` varchar(50) NOT NULL,
  `account_customer` int(11) DEFAULT NULL,
  `branch_open_account` varchar(50) DEFAULT NULL,
  `customer_name` varchar(150) DEFAULT NULL,
  `balance` float DEFAULT NULL,
  PRIMARY KEY (`account_number`),
  KEY `account_customer` (`account_customer`),
  KEY `branch_open_account` (`branch_open_account`),
  CONSTRAINT `account_book_ibfk_1` FOREIGN KEY (`account_customer`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `account_book_ibfk_2` FOREIGN KEY (`branch_open_account`) REFERENCES `branch` (`branch_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `debit_card` (
  `debit_card_id` varchar(50) NOT NULL,
  `account_number` varchar(50) DEFAULT NULL,
  `holder_name` varchar(150) DEFAULT NULL,
  `cvv` int(11) DEFAULT NULL,
  `expire_month` tinyint(4) DEFAULT NULL,
  `expire_year` int(11) DEFAULT NULL,
  PRIMARY KEY (`debit_card_id`),
  KEY `account_number` (`account_number`),
  CONSTRAINT `debit_card_ibfk_1` FOREIGN KEY (`account_number`) REFERENCES `account_book` (`account_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `debit_card_payment_detail` (
  `debit_payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `debit_card_id` varchar(50) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_description` varchar(200) DEFAULT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`debit_payment_id`),
  KEY `debit_card_id` (`debit_card_id`),
  CONSTRAINT `debit_card_payment_detail_ibfk_1` FOREIGN KEY (`debit_card_id`) REFERENCES `debit_card` (`debit_card_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

CREATE TABLE `credit_card` (
  `credit_card_id` varchar(50) NOT NULL,
  `account_number` varchar(50) DEFAULT NULL,
  `holder_name` varchar(150) DEFAULT NULL,
  `cvv` int(11) DEFAULT NULL,
  `expire_month` tinyint(4) DEFAULT NULL,
  `expire_year` int(11) DEFAULT NULL,
  `total_payment` float DEFAULT NULL,
  `max_of_payment` float DEFAULT NULL,
  PRIMARY KEY (`credit_card_id`),
  KEY `account_number` (`account_number`),
  CONSTRAINT `credit_card_ibfk_1` FOREIGN KEY (`account_number`) REFERENCES `account_book` (`account_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `credit_card_payment_detail` (
  `credit_payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `credit_card_id` varchar(50) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_description` varchar(200) DEFAULT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`credit_payment_id`),
  KEY `credit_card_id` (`credit_card_id`),
  CONSTRAINT `credit_card_payment_detail_ibfk_1` FOREIGN KEY (`credit_card_id`) REFERENCES `credit_card` (`credit_card_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

CREATE TABLE `statement_detail` (
  `statement_number` int(11) NOT NULL AUTO_INCREMENT,
  `account_number` varchar(50) DEFAULT NULL,
  `statement_date` date DEFAULT NULL,
  `deposite` float DEFAULT NULL,
  `withdrawal` float DEFAULT NULL,
  `verification_employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`statement_number`),
  KEY `account_number` (`account_number`),
  KEY `verification_employee_id` (`verification_employee_id`),
  CONSTRAINT `statement_detail_ibfk_1` FOREIGN KEY (`account_number`) REFERENCES `account_book` (`account_number`),
  CONSTRAINT `statement_detail_ibfk_2` FOREIGN KEY (`verification_employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- CREATE PROCEDURE

DROP PROCEDURE IF EXISTS insert_detail;
DELIMITER //
CREATE PROCEDURE insert_detail()
BEGIN
	INSERT INTO `branch` (`branch_number`,`branch_name`,`branch_address`,`branch_city`,`branch_post_code`) VALUES
		('B01','phrommarat road branch','304 310 phrommarat Rd, Nai Mueang, Mueang Ubon Ratchathani District','Ubon Ratchathani','34000'),
		('B02','suriyard road branch','251 18 suriyard Nai Mueang, Mueang Ubon Ratchathani District','Ubon Ratchathani','34000'),
		('B03','ubparat road branch','177, Ubparat, Road, Nai Muang, Mueng Ubon Ratchathani District','Ubon Ratchathani','34000'),
		('B04','chayangkun road branch','420 Chayangkun Rd, Nai Mueang, Mueang Ubon Ratchathani District','Ubon Ratchathani','34000'),
		('B05','chayangkun road branch','130 Chayangkun Rd, Nai Mueang, Mueang Ubon Ratchathani District','Ubon Ratchathani','34000'),
		('B06','chaeramae road branch','31 7 Chaeramae, Amphoe Mueang Ubon Ratchathani','Ubon Ratchathani','34000'),
		('B07','chaeramae road branch','Chaeramae, Mueang Ubon Ratchathani District','Ubon Ratchathani','34000'),
		('B08','chayankun road branch','512/8 Chayangkun Rd, Nai Mueang, Mueang Ubon Ratchathani District','Ubon Ratchathani','34000'),
		('B09','chayankun road branch','325 31 Chayangkun Rd, Nai Mueang, Mueang Ubon Ratchathani District','Ubon Ratchathani','34000'),
		('B10','suriyard road branch','251 18 Nai Mueang, Mueang Ubon Ratchathani District','Ubon Ratchathani','34000'),
		('B11','dok khamtai road branch','65 moo 4 sub-district.dok khamtai district.dok khamtai','Phayao','56120'),
		('B12','pong road branch','285/6 moo 1 soy 2 sub-district.pong district.pong','Phayao','56140'),
		('B13','pong road branch','40/4 moo 4 sub-district.na prang district.pong','Phayao','56140'),
		('B14','mae chai road branch','69 moo 6 soy 9 sub-district.mae suk district.mae chai','Phayao','56130'),
		('B15','mae chai road branch','123/4 moo 1 sub-district.ban lao district.mae chai','Phayao','56130'),
		('B16','phu kamyao road branch','42 moo 9 sub-district.huai kaeo district.phu kamyao','Phayao','56000'),
		('B17','phu kamyao road branch','32/6 moo 5 soy 5 sub-district.dong chen district.phu kamyao','Phayao','56000'),
		('B18','chun road branch','99/9 moo 9 soy 9 sub-district.huai khao Kam district.chun','Phayao','56150'),
		('B19','phu sang road branch','70/7 moo 1 sub-district.thung kluai district.phu sang','Phayao','56110'),
		('B20','chiang muan road branch','54 moo 4 sub-district.chiang muan district.chiang muan','Phayao','56160'),
		('B21','Maesai road branch ','301/12 moo 13 ','Chaingrai','57130'),
		('B22','Robvein road branch ','195 moo 4','Chiangrai','57000'),
		('B23','Rim kok road branch','400/12','Chiangrai','57000'),
		('B24','Mae korn road branch','1211 ','Chiangrai','57000'),
		('B25','Tha sut road branch ','427/2 ','Chiangrai','57100'),
		('B26','Mae jun road branch ','112/5','Chiangrai','57110'),
		('B27','Mae jun road branch','250 moo 5','Chiangrai','57110'),
		('B28','Pa sang road branch ','327/5 moo 7','Chiangrai','57110'),
		('B29','Mae rai road branch ','271/10 moo 2','Chiangrai','57240'),
		('B30','Pong pha road brach ','563 moo 4 ','Chiangrai','57130'),
		('B31','Udon Damri road branch','113 moo 7  sub-district.NAKHON THAI','Phitsanulok','65120'),
		('B32','Highway 1295 road branch','615 moo 4  sub-district.NOEN MAPRANG','Phitsanulok','65190'),
		('B33','Santi Bantheing-Bang Krathum road branch','8/8 moo 8  sub-district.Phai Lom','Phitsanulok','65110'),
		('B34','Highway 1293 road branch','14 moo 5  sub-district.Khu Muang','Phitsanulok','65240'),
		('B35','Highway 1220 road branch','56/6 moo 9  sub-district.Ban Yang ','Phitsanulok','65120'),
		('B36','Highway 1086 road branch','13 moo 2  sub-district.Pak Thok','Phitsanulok','65000'),
		('B37','South Bypass road branch','222 moo 6  sub-district.Wang Phikun','Phitsanulok','65130'),
		('B38','Huay Kaew road branch','29 moo 4  sub-district.Bang Krathum','Phitsanulok','65110'),
		('B39','Singhawat road branch','9/99 moo 5 sub-district.Phlai Chumphon','Phitsanulok','65000'),
		('B40','Highway 1143 road branch','79 moo 2  sub-district.Pa Daeng','Phitsanulok','65170');
        
	INSERT INTO `employee` (`employee_id`,`employee_first_name`,`employee_last_name`,`employee_title`,`employee_start_date`,`employee_branch_number`,`employee_salary`) VALUES 
		(1,'Wutthichai','Saehua','Manager','2020-04-01','B01',30000),
		(2,'Thitinun','Saehua','Officer','2020-04-01','B01',15000),
		(3,'Siriapha','Saehua','Officer','2020-04-01','B01',15000),
		(4,'Thanthiwa','Ponjakfa','Officer','2020-04-01','B01',15000),
		(5,'John','Cameron','Officer','2020-04-01','B01',15000),
		(6,'Edogawa','Conan','Manager','2020-04-02','B12',30000),
		(7,'Kudo','Shinichi','Officer','2020-04-02','B12',15000),
		(8,'Kurosagi','Ichigo','Officer','2020-04-02','B12',15000),
		(9,'Hondo','Esuke','Officer','2020-04-02','B12',15000),
		(10,'Mori','Kogoro','Officer','2020-04-02','B12',15000),
		(11,'Tony','Stark','Manager','2020-04-03','B23',30000),
		(12,'Stephen','Strange','Officer','2020-04-03','B23',15000),
		(13,'Wanda','Maximoff','Officer','2020-04-03','B23',15000),
		(14,'James','Rhodes','Officer','2020-04-03','B23',15000),
		(15,'Peter','Quill','Officer','2020-04-03','B23',15000),
		(16,'Steve','Rogers','Manager','2020-04-04','B34',30000),
		(17,'Bucky','Barnes','Officer','2020-04-04','B34',15000),
		(18,'Clint','Barton','Officer','2020-04-04','B34',15000),
		(19,'Natasha','Romanoff','Officer','2020-04-04','B35',15000),
		(20,'Sam','Wilson','Officer','2020-04-04','B34',15000),
		(21,'God','Thor','Manager','2020-04-05','B05',30000),
		(22,'Bruce','Banner','Officer','2020-04-05','B05',15000),
		(23,'Nick','Fury','Officer','2020-04-05','B05',15000),
		(24,'T','Challa','Officer','2020-04-05','B05',15000),
		(25,'Scott','Lang','Officer','2020-04-05','B05',15000),
		(26,'Peter','Parker','Manager','2020-04-06','B15',30000),
		(27,'Ryan','Reynolds','Officer','2020-04-06','B15',15000),
		(28,'Mister','Fantastic','Officer','2020-04-06','B15',15000),
		(29,'Captain','Marvel','Officer','2020-04-06','B15',15000),
		(30,'Titan','Thanos','Officer','2020-04-06','B15',15000);

	INSERT INTO `customer` (`customer_id`,`customer_name_title`,`customer_first_name`,`customer_last_name`,`customer_gender`,`customer_job`,`customer_address`,`customer_country`,`customer_post_code`,`customer_email`,`customer_telephone`) VALUES 
		(1,'Mr','john','wick','female','actor','65 moo 4 sub-district.dok khamtai district.dok khamtai','phayao','56120','ka_booooom@gmail.com','0871945284'),
		(2,'Miss','jill','supervalentine','male','actor','285/6 moo 1 soy 2 sub-district.pong district.pong','phayao','56140','super_valentine@gmail.com','0861947563'),
		(3,'Mr','phatut','otee','male','soldier','40/4 moo 4 sub-district.na prang district.pong','phayao','56140','phatut_otee@hotmail.com','0632854915'),
		(4,'Mrs','big','pom','female','teacher','69 moo 6 soy 9 sub-district.mae suk district.mae chai','phayao','56130','pompom_sleep@hotmail.com','0900999545'),
		(5,'Mr','yamamoto','teiki','male','engineering','123/4 moo 1 sub-district.ban lao district.mae chai','phayao','56130','godza_55@hotmail.com','0846299985'),
		(6,'Mr','bugs','bunny','male','chef','42 moo 9 sub-district.huai kaeo district.phu kamyao','phayao','56000','bugs_bunny@gmail.com','0632145695'),
		(7,'Mr','samsung','note','male','engineering','32/6 moo 5 soy 5 sub-district.dong chen district.phu kamyao','phayao','56000','note_9@hotmail.com','0806029423'),
		(8,'Miss','suzuki','koharu','female','chef','99/9 moo 9 soy 9 sub-district.huai khao Kam district.chun','phayao','56150','word_microsoft@hotmail.com','0895959451'),
		(9,'Mr','arthur','gssspotted','male','teacher','70/7 moo 1 sub-district.thung kluai district.phu sang','phayao','56110','gg_wp@hotmail.com','0994566590'),
		(10,'Dr','kamekame','haaa','male','doctor','54 moo 4 sub-district.chiang muan district.chiang muan','phayao','56160','goku_saiya@gamil.com','0945941139'),
		(11,'Mr','Luffy','D.Monkey','male','Butcher','113 moo 7  sub-district.NAKHON THAI','Phitsanulok','65120','PortgasD.Ace@gmail.com','0536749823'),
		(12,'Mr','zoro','Roronoa ','male','Guide','615 moo 4  sub-district.NOEN MAPRANG','Phitsanulok','65190','Roronoa.zoro@gmail.com','0844827894'),
		(13,'Mr','Chopper','Tony Tony','male','Doctor','8/8 moo 8  sub-district.Phai Lom','Phitsanulok','65110','Chopper.jun@hotmail.com','0945679290'),
		(14,'Miss','Robin','Nico','female','Archeologist','14 moo 5  sub-district.Khu Muang','Phitsanulok','65240','Robin.kun@gmail.com','0826727310'),
		(15,'Mr','Rayleigh','Silvers','male','Teacher','56/6 moo 9  sub-district.Ban Yang','Phitsanulok','65120','Gold_Roger@gmail.com','0530841910'),
		(16,'Mr','Newgate','Edward','male','Treasure hunter','13 moo 2  sub-district.Pak Thok','Phitsanulok','65000','Maruko_Phoenix@gmail.com','0844825607'),
		(17,'Mrs','Rinrin','Sharotto','female','actor','222 moo 6  sub-district.Wang Phikun','Phitsanulok','65130','Big_mom@gmail.com','0644821774'),
		(18,'Miss','Hancock','Boa','female','model','29 moo 4  sub-district.Bang Krathum','Phitsanulok','65110','D_Luffy@gmail.com','0899521923'),
		(19,'Mr','Doflamingo','Donquixote','male','Weaver','9/99 moo 5 sub-district.Phlai Chumphon','Phitsanulok','65000','joker.family@gmail.com','0537219872'),
		(20,'Mr','Law','Trafalgar','male','surgeon','79 moo 2  sub-district.Pa Daeng','Phitsanulok','65170','Papo_heart@gmail.com','0827219872'),
		(21,'Miss','ruby','theo','female','barber','75/9 moo 2 sub-district.dok khamtai district.dok khamtai','phayao','56120','gooogle@gmail.com','0888461475'),
		(22,'Miss','nitro','five','female','nurse','85/4 moo 1 sub-district.pong district.pong','phayao','56140','html_php@gmail.com','0995415846'),
		(23,'Mr','kamen','rider','male','policeman','55 moo 1 sub-district.na prang district.pong','phayao','56140','hen_shin@hotmail.com','066524789'),
		(24,'Mr','mouse','macnus','male','teacher','96/2 moo 4 soy 1 sub-district.mae suk district.mae chai','phayao','56130','power_point@hotmail.com','0913549528'),
		(25,'Miss','minami','neko','female','nurse','55 moo 2 sub-district.ban lao district.mae chai','phayao','56130','god_dog@hotmail.com','0638912254'),
		(26,'Mr','tom','jerry','male','chef','77 moo 1 sub-district.huai kaeo district.phu kamyao','phayao','56000','the_one@gmail.com','099741558'),
		(27,'Mr','acer','pro','male','engineering','26/9 moo 2 soy 4 sub-district.dong chen district.phu kamyao','phayao','56000','error_404@hotmail.com','0809095461'),
		(28,'Miss','yua','mikami','female','sport man','586/8 moo 1 soy 1 sub-district.huai khao Kam district.chun','phayao','56150','excel_microsoft@hotmail.com','0874652135'),
		(29,'Dr','heart','rocker','male','sport man','7/7 moo 5 sub-district.thung kluai district.phu sang','phayao','56110','game_filling@hotmail.com','0946525528'),
		(30,'Dr','christian','shop','male','doctor','64/8 moo 8 sub-district.chiang muan district.chiang muan','phayao','56160','playing_game@gamil.com','0803160520');
        
	INSERT INTO `account_book` (`account_number`,`account_customer`,`branch_open_account`,`customer_name`,`balance`) VALUES 
		('11A0001',1,'B11','Mr. John Wick',5000),
		('11A0002',27,'B11','Mr acer pro',5000),
		('12A0001',2,'B12','Miss Jill supervalentine',5000),
		('12A0002',29,'B12','Dr heart  rocker',5000),
		('13A0001',3,'B13','Mr. Phatut Otee',5000),
		('13A0002',28,'B13','Miss yua mikami',5000),
		('14A0001',4,'B14','Mrs. Big Pom',5000),
		('14A0002',21,'B14','Miss ruby theo',5000),
		('14A0003',22,'B14','Miss nitro five',5000),
		('14A0004',30,'B14','Dr christian shop',5000),
		('15A0001',5,'B15','Mr. Yamamoto Teiki',5000),
		('16A0001',6,'B16','Mr. Bugs Bunny',5000),
		('16A0002',23,'B16','Mr kamen rider',5000),
		('17A0001',7,'B17','Mr. Samsung Note',5000),
		('17A0002',24,'B17','Mr mouse macnus',5000),
		('18A0001',8,'B18','Miss Suzuki Koharu',5000),
		('19A0001',9,'B19','Mr. Aruthur Gssspotted',5000),
		('19A0002',25,'B19','Miss minami neko',5000),
		('20A0001',10,'B20','Dr. Kamekame Haaa',5000),
		('20A0002',26,'B20','Mr tom jerry',5000),
		('31A0001',11,'B31','Mr Luffy D.Monkey',5000),
		('32A0001',12,'B32','Mr zoro Roronoa',5000),
		('33A0001',13,'B33','Mr Chopper Tony Tony',5000),
		('34A0001',14,'B34','Miss Robin Nico',5000),
		('35A0001',15,'B35','Mr Rayleigh  Silvers',5000),
		('36A0001',16,'B36','Mr Newgate Edward',5000),
		('37A0001',17,'B37','Mr Rinrin Sharotto',5000),
		('38A0001',18,'B38','Miss Hancock Boa',5000),
		('39A0001',19,'B39','Mr Doflamingo Donquixote',5000),
		('40A0001',20,'B40','Mr Law Trafalgar',5000);

	INSERT INTO `debit_card` (`debit_card_id`,`account_number`,`holder_name`,`cvv`,`expire_month`,`expire_year`) VALUES 
		('D0001','11A0001','John Wick',411,4,2020),
		('D0002','12A0001','Jill supervalentine',511,4,2020),
		('D0003','13A0001','Phatut Otee',601,4,2020),
		('D0004','14A0001','Big Pom',416,4,2020),
		('D0005','15A0001','Yamamoto Teiki',451,4,2020),
		('D0006','16A0001','Bugs Bunny',411,4,2020),
		('D0007','17A0001','Samsung Note',401,4,2020),
		('D0008','18A0001','Suzuki Koharu',400,4,2020),
		('D0009','19A0001','Aruthur Gssspotted',412,4,2020),
		('D0010','20A0001','Kamekame Haaa',411,4,2020),
		('D0011','14A0002','Ruby Theo',534,4,2020),
		('D0012','14A0003','Nitro Five',335,4,2020),
		('D0013','16A0002','Kamen Rider',664,4,2020),
		('D0014','17A0002','Mouse Macnus',111,4,2020),
		('D0015','19A0002','Minami Neko',955,4,2020),
		('D0016','20A0002','Tom Jerry',504,4,2020),
		('D0017','11A0002','Acer Pro',777,4,2020),
		('D0018','13A0002','Yua Mikami',656,4,2020),
		('D0019','12A0002','Heart Rocker',555,4,2020),
		('D0020','14A0004','Christian Shop',333,4,2020);

	INSERT INTO `debit_card_payment_detail` (`debit_payment_id`,`debit_card_id`,`payment_date`,`payment_description`,`price`) VALUES 
		(1,'D0001','2020-04-14','Direct Payment Debit',500),
		(2,'D0002','2020-04-14','Ticket Movie',200),
		(3,'D0003','2020-04-14','Top-up',100),
		(4,'D0004','2020-04-14','Grab Pay',1000),
		(5,'D0006','2020-04-16','Direct-Pay-Online-Market',1500),
		(6,'D0001','2020-04-16','Direct Payment Debit',500),
		(7,'D0002','2020-04-17','Ticket Movie',200),
		(8,'D0003','2020-04-17','Top-up',100),
		(9,'D0004','2020-04-20','Grab Pay',1000),
		(10,'D0006','2020-04-20','Direct-Pay-Online-Market',1500);
    
	INSERT INTO `credit_card` (`credit_card_id`,`account_number`,`holder_name`,`cvv`,`expire_month`,`expire_year`,`total_payment`,`max_of_payment`) VALUES 
		('C0001','11A0001','John Wick',411,4,2024,0,100000),
		('C0002','12A0001','Jill supervalentine',511,4,2024,0,100000),
		('C0003','13A0001','Phatut Otee',601,4,2024,0,100000),
		('C0004','14A0001','Big Pom',416,4,2024,0,100000),
		('C0005','15A0001','Yamamoto Teiki',451,4,2024,0,100000),
		('C0006','16A0001','Bugs Bunny',411,4,2024,0,100000),
		('C0007','17A0001','Samsung Note',401,4,2024,0,100000),
		('C0008','18A0001','Suzuki Koharu',400,4,2024,0,100000),
		('C0009','19A0001','Aruthur Gssspotted',412,4,2024,0,100000),
		('C0010','20A0001','Kamekame Haaa',411,4,2024,0,100000),
		('C0011','31A0001','Luffy D.Monkey',411,4,2024,0,10000),
		('C0012','32A0001','zoro Roronoa ',416,4,2024,0,10000),
		('C0013','33A0001','Chopper Tony Tony',416,4,2024,0,10000),
		('C0014','34A0001','Robin Nico',416,4,2024,0,10000),
		('C0015','35A0001','Rayleigh  Silvers',401,4,2024,0,10000),
		('C0016','36A0001','Newgate Edward',406,4,2024,0,10000),
		('C0017','37A0001','Rinrin Sharotto',407,4,2024,0,10000),
		('C0018','38A0001','Hancock Boa',406,4,2024,0,10000),
		('C0019','39A0001','Doflamingo Donquixote',410,4,2024,0,10000),
		('C0020','40A0001','Law Trafalgar',415,4,2024,0,10000);

	INSERT INTO `credit_card_payment_detail` (`credit_payment_id`,`credit_card_id`,`payment_date`,`payment_description`,`price`) VALUES 
		(1,'C0002','2020-04-15','Direct payment debit',500),
		(2,'C0012','2020-04-15','Ticket movie',200),
		(3,'C0013','2020-04-15','Top-up',100),
		(4,'C0004','2020-04-15','Grab pay',1000),
		(5,'C0016','2020-04-15','Direct-pay-oline-market',1500),
		(6,'C0010','2020-04-15','Food Panda pay',200),
		(7,'C0011','2020-04-15','Line man pay',200),
		(8,'C0014','2020-04-15','Amazon payment',1000),
		(9,'C0013','2020-04-15','Lazada payment',500),
		(10,'C0012','2020-04-15','Shopee payment',500),
		(11,'C0012','2020-04-16','Ais bill pay',350),
		(12,'C0012','2020-04-16','Ticket movie',250),
		(13,'C0013','2020-04-16','Top-up',100),
		(14,'C0014','2020-04-16','True Move H bill pay',1000),
		(15,'C0016','2020-04-16','Netflix subcription',420),
		(16,'C0012','2020-04-16','Top-up',500),
		(17,'C0012','2020-04-16','Ticket movie',250),
		(18,'C0013','2020-04-16','Grab pay',100),
		(19,'C0014','2020-04-16','Grab pay',1000),
		(20,'C0016','2020-04-16','Mk payment',1195),
		(21,'C0015','2020-04-17','YouTube subcription',99),
		(22,'C0017','2020-04-17','Joox subcription',69),
		(23,'C0017','2020-04-17','Apple music subcription',69),
		(24,'C0016','2020-04-17','Spotify subscription',99),
		(25,'C0014','2020-04-17','AppleTV subscription',199),
		(26,'C0018','2020-04-17','NBA membership subscription',2500),
		(27,'C0018','2020-04-17','Nintendo online subscription',299),
		(28,'C0017','2020-04-17','Just dance subscription',349),
		(29,'C0016','2020-04-17','Sayuri membership',8000),
		(30,'C0014','2020-04-17','Booking payment',2499),
		(31,'C0011','2020-04-18','Agoda',350),
		(32,'C0015','2020-04-18','Traveloga payment',250),
		(33,'C0011','2020-04-18','BananIT payment',5000),
		(34,'C0016','2020-04-18','SamsungTV subscription',1000),
		(35,'C0017','2020-04-18','Netflix subcription',420),
		(36,'C0018','2020-04-18','Top-up',500),
		(37,'C0019','2020-04-18','Ticket movie',250),
		(38,'C0020','2020-04-18','Facebook ads',100),
		(39,'C0013','2020-04-18','Grab pay',1000),
		(40,'C0014','2020-04-18','Mk payment',1195),
		(41,'C0005','2020-04-19','Thairath tv subcription',592),
		(42,'C0017','2020-04-19','Dtac bill pay',2000),
		(43,'C0004','2020-04-19','Thairath news subcription',450),
		(44,'C0013','2020-04-19','Shoppee payment',2550),
		(45,'C0013','2020-04-19','Work point tv Hd subcription',570),
		(46,'C0018','2020-04-19','Line man pay',700),
		(47,'C0012','2020-04-19','AIS bill pay',1340),
		(48,'C0018','2020-04-19','Lazada payment',1090),
		(49,'C0011','2020-04-19','Youtube subcription',160),
		(50,'C0016','2020-04-20','Apple TV subcription',440),
		(51,'C0004','2020-04-20','NBA membership subcription',830),
		(52,'C0011','2020-04-20','Yahoo ads',2450),
		(53,'C0019','2020-04-20','Amazon payment',660),
		(54,'C0009','2020-04-20','Spotify subcription',195),
		(55,'C0007','2020-04-20','Food panda pay',658),
		(56,'C0015','2020-04-20','Booking.com payment',1830),
		(57,'C0010','2020-04-20','Justdance subcription',890),
		(58,'C0013','2020-04-20','Vip card parking',150),
		(59,'C0011','2020-04-20','Traveloga payment',1800),
		(60,'C0011','2020-04-21','True move bill pay',2100),
		(61,'C0007','2020-04-21','Nintendo online subcription',1250),
		(62,'C0014','2020-04-21','Ais play subcription',655),
		(63,'C0014','2020-04-21','Pornhub premium membership subcription',990),
		(64,'C0010','2020-04-21','Samsung Smart tv support  subcription',1195),
		(65,'C0001','2020-04-21','I care  Apple .inc subcription',2110),
		(66,'C0014','2020-04-21','Zoom vip subcription',450),
		(67,'C0019','2020-04-21','Tweeter ads',3150),
		(68,'C0013','2020-04-21','Lg service care subcription',1000),
		(69,'C0003','2020-04-21','Hentai tv.com subcription',650),
		(70,'C0002','2020-04-21','Facebook ads',2300);

	INSERT INTO `statement_detail` (`statement_number`,`account_number`,`statement_date`,`deposite`,`withdrawal`,`verification_employee_id`) VALUES 
		(1,'11A0001','2020-04-15',0,5000,2),
		(2,'12A0001','2020-04-15',1000,0,3),
		(3,'13A0001','2020-04-15',0,1000,3),
		(4,'14A0001','2020-04-15',0,2000,2),
		(5,'15A0001','2020-04-15',1000,0,5),
		(6,'16A0001','2020-04-15',0,1500,4),
		(7,'17A0001','2020-04-15',0,500,4),
		(8,'18A0001','2020-04-15',0,5000,3),
		(9,'19A0001','2020-04-15',0,1000,2),
		(10,'20A0001','2020-04-15',0,1000,4),
		(11,'14A0004','2020-04-15',1000,0,2),
		(12,'14A0003','2020-04-15',500,0,3),
		(13,'14A0002','2020-04-15',0,1000,3),
		(14,'35A0001','2020-04-15',0,200,8),
		(15,'36A0001','2020-04-15',1000,0,9),
		(16,'37A0001','2020-04-15',0,150,7),
		(17,'38A0001','2020-04-15',0,500,10),
		(18,'39A0001','2020-04-15',0,5000,10),
		(19,'40A0001','2020-04-15',0,1000,7),
		(20,'31A0001','2020-04-15',0,100,8),
		(21,'33A0001','2020-04-16',10000,0,18),
		(22,'35A0001','2020-04-16',5000,0,17),
		(23,'32A0001','2020-04-16',0,100,16),
		(24,'36A0001','2020-04-16',0,200,18),
		(25,'40A0001','2020-04-16',10000,0,18),
		(26,'34A0001','2020-04-16',0,100,19),
		(27,'37A0001','2020-04-16',500,0,19),
		(28,'39A0001','2020-04-16',0,500,18),
		(29,'40A0001','2020-04-16',0,100,20),
		(30,'38A0001','2020-04-16',0,100,17);

END//
DELIMITER ;
CALL insert_detail();