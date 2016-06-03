/*
	Create:	2016/5/12
	Author:	Rafy Zhao
	For:	IP guide request tool 
*/

-- IP Guide
CREATE TABLE stp_online.dbo.IPGuide
(
    id int identity(1,1) primary key,
    IPType varchar(20) ,
    IPName varchar(50) not NULL,
    IPCategory nchar(10) NULL,
);

-- Client information
CREATE TABLE stp_online.dbo.IPGuideRequestClient
(
    id int identity(1,1) primary key,
    ClientName varchar(50) null,
    contact_firstname varchar(50) null,
    contact_lastname varchar(50) NULL,
	contact_number nchar(18) null,
	rep nchar(10) null,
	client_type char(1) not null --1: industry specific; 2: IP's; 3: Mining; 4: ISO; 5: Convergence
);

-- client ip request
CREATE TABLE stp_online.dbo.IPGuideRequestRecord
(
	id int identity(1,1) primary key,
	IP_id int foreign key references stp_online.dbo.IPGuide(id),
	client_id int foreign key references stp_online.dbo.IPGuideRequestClient(id),
	IPType varchar(20),
	create_time timestamp	
);

-- map user_id of USERS to rep
CREATE TABLE stp_online.dbo.IPGuideRep
(
	UserID int primary key foreign key references stp_online.dbo.users(userid),
	rep nchar(5) not null		
);
