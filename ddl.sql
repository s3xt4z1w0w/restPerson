-- SmartBank_Test.dbo.MobilePhone definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.MobilePhone;

CREATE TABLE SmartBank_Test.dbo.MobilePhone (
	MobilePhone_ID int IDENTITY(1000000,1) NOT NULL,
	MobilePhone varchar(50) COLLATE Cyrillic_General_CI_AS NOT NULL,
	MobilePhoneStatus_IDREF char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	CONSTRAINT PK_MobilePhone PRIMARY KEY (MobilePhone_ID),
	CONSTRAINT UK_MobilePhone_MobilePhone UNIQUE (MobilePhone)
);


-- SmartBank_Test.dbo.MobilePhone foreign keys

ALTER TABLE SmartBank_Test.dbo.MobilePhone ADD CONSTRAINT FK_MobilePhone_MobilePhoneStatus FOREIGN KEY (MobilePhoneStatus_IDREF) REFERENCES SmartBank_Test.dbo.MobilePhoneStatus(MobilePhoneStatus_ID);


-- SmartBank_Test.dbo.MobilePhoneStatus definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.MobilePhoneStatus;

CREATE TABLE SmartBank_Test.dbo.MobilePhoneStatus (
	MobilePhoneStatus_ID char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	MobilePhoneStatus_Title nvarchar(50) COLLATE Cyrillic_General_CI_AS NOT NULL,
	Term_OUTREF int NULL,
	IsValid bit NOT NULL,
	CONSTRAINT PK_MobilePhoneStatus PRIMARY KEY (MobilePhoneStatus_ID)
);


-- SmartBank_Test.dbo.map_Person_MobilePhone definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.map_Person_MobilePhone;

CREATE TABLE SmartBank_Test.dbo.map_Person_MobilePhone (
	MobilePhone_IDREF int NOT NULL,
	Person_IDREF int NOT NULL,
	CONSTRAINT PK_map_Person_MobilePhone PRIMARY KEY (MobilePhone_IDREF,Person_IDREF)
);


-- SmartBank_Test.dbo.map_Person_MobilePhone foreign keys

ALTER TABLE SmartBank_Test.dbo.map_Person_MobilePhone ADD CONSTRAINT FK_map_Person_MobilePhone_MobilePhone FOREIGN KEY (MobilePhone_IDREF) REFERENCES SmartBank_Test.dbo.MobilePhone(MobilePhone_ID);
ALTER TABLE SmartBank_Test.dbo.map_Person_MobilePhone ADD CONSTRAINT FK_map_Person_MobilePhone_Person FOREIGN KEY (Person_IDREF) REFERENCES SmartBank_Test.dbo.Person(Person_ID);


-- SmartBank_Test.dbo.Person definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.Person;

CREATE TABLE SmartBank_Test.dbo.Person (
	Person_ID int IDENTITY(1000000,1) NOT NULL,
	FirstName nvarchar(25) COLLATE Cyrillic_General_CI_AS NOT NULL,
	LastName nvarchar(25) COLLATE Cyrillic_General_CI_AS NOT NULL,
	FathersName nvarchar(25) COLLATE Cyrillic_General_CI_AS NULL,
	Gender_IDREF char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	BirthDate datetime NOT NULL,
	IsResident bit NOT NULL,
	IsAffiliated bit NOT NULL,
	IsEmployee bit NOT NULL,
	HasSalaryAccount bit NOT NULL,
	ClientRank_IDREF char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	IIN char(12) COLLATE Cyrillic_General_CI_AS NOT NULL,
	RNN char(12) COLLATE Cyrillic_General_CI_AS NULL,
	SIK char(16) COLLATE Cyrillic_General_CI_AS NULL,
	PersonStatus_IDREF char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	BirthPlace nvarchar(50) COLLATE Cyrillic_General_CI_AS NULL,
	Person_OUTREF int NULL,
	IsSSGPO bit DEFAULT 0 NOT NULL,
	IsCitizenship bit NULL,
	CONSTRAINT PK_Person PRIMARY KEY (Person_ID),
	CONSTRAINT UK_Person_LastName_FirstName_FathersName_BirthDate UNIQUE (LastName,FirstName,FathersName,BirthDate)
);
 CREATE  UNIQUE NONCLUSTERED INDEX IX_Person_IIN ON dbo.Person (  IIN ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE  UNIQUE NONCLUSTERED INDEX IX_Person_IIN_Birthdate ON dbo.Person (  IIN ASC  , BirthDate ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_Person_OUTREF ON dbo.Person (  Person_OUTREF ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- SmartBank_Test.dbo.Person foreign keys

ALTER TABLE SmartBank_Test.dbo.Person ADD CONSTRAINT FK_Person_ClientRank FOREIGN KEY (ClientRank_IDREF) REFERENCES SmartBank_Test.dbo.ClientRank(ClientRank_ID);
ALTER TABLE SmartBank_Test.dbo.Person ADD CONSTRAINT FK_Person_Gender FOREIGN KEY (Gender_IDREF) REFERENCES SmartBank_Test.dbo.Gender(Gender_ID);
ALTER TABLE SmartBank_Test.dbo.Person ADD CONSTRAINT FK_Person_PersonStatus FOREIGN KEY (PersonStatus_IDREF) REFERENCES SmartBank_Test.dbo.PersonStatus(PersonStatus_ID);

-- SmartBank_Test.dbo.PersonStatus definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.PersonStatus;

CREATE TABLE SmartBank_Test.dbo.PersonStatus (
	PersonStatus_ID char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	PersonStatus_Title nvarchar(50) COLLATE Cyrillic_General_CI_AS NOT NULL,
	Term_OUTREF int NULL,
	IsValid bit NOT NULL,
	CONSTRAINT PK_PersonStatus PRIMARY KEY (PersonStatus_ID)
);


-- SmartBank_Test.dbo.PersonStatus foreign keys

ALTER TABLE SmartBank_Test.dbo.PersonStatus ADD CONSTRAINT FKr4mkhuniyq7in6wxyna7q080x FOREIGN KEY (Term_OUTREF) REFERENCES SmartBank_Test.dbo.Term(Term_ID);

-- SmartBank_Test.dbo.Gender definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.Gender;

CREATE TABLE SmartBank_Test.dbo.Gender (
	Gender_ID char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	Gender_Title nvarchar(25) COLLATE Cyrillic_General_CI_AS NOT NULL,
	Term_OUTREF int NULL,
	CONSTRAINT PK_Gender PRIMARY KEY (Gender_ID)
);


-- SmartBank_Test.dbo.Gender foreign keys

ALTER TABLE SmartBank_Test.dbo.Gender ADD CONSTRAINT FKt8kh0dgblbtwvlbijuph4spel FOREIGN KEY (Term_OUTREF) REFERENCES SmartBank_Test.dbo.Term(Term_ID);

-- SmartBank_Test.dbo.Term definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.Term;

CREATE TABLE SmartBank_Test.dbo.Term (
	Term_ID int IDENTITY(1000000,1) NOT NULL,
	Term_RU nvarchar(MAX) COLLATE Cyrillic_General_CI_AS NULL,
	Desc_RU nvarchar(500) COLLATE Cyrillic_General_CI_AS NULL,
	Term_KZ nvarchar(MAX) COLLATE Cyrillic_General_CI_AS NULL,
	Desc_KZ nvarchar(500) COLLATE Cyrillic_General_CI_AS NULL,
	Term_EN nvarchar(MAX) COLLATE Cyrillic_General_CI_AS NULL,
	Desc_EN nvarchar(500) COLLATE Cyrillic_General_CI_AS NULL,
	Term_DE nvarchar(MAX) COLLATE Cyrillic_General_CI_AS NULL,
	Desc_DE nvarchar(500) COLLATE Cyrillic_General_CI_AS NULL,
	Term_FR nvarchar(MAX) COLLATE Cyrillic_General_CI_AS NULL,
	Desc_FR nvarchar(500) COLLATE Cyrillic_General_CI_AS NULL,
	Term_TR nvarchar(MAX) COLLATE Cyrillic_General_CI_AS NULL,
	Desc_TR nvarchar(500) COLLATE Cyrillic_General_CI_AS NULL,
	Code varchar(50) COLLATE Cyrillic_General_CI_AS NULL,
	CONSTRAINT PK_Term_old PRIMARY KEY (Term_ID)
);

-- SmartBank_Test.dbo.ClientRank definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.ClientRank;

CREATE TABLE SmartBank_Test.dbo.ClientRank (
	ClientRank_ID char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	ClientRank_Title nvarchar(25) COLLATE Cyrillic_General_CI_AS NOT NULL,
	Term_OUTREF int NULL,
	[Rank] int NOT NULL,
	CONSTRAINT PK_ClientRank PRIMARY KEY (ClientRank_ID)
);


-- SmartBank_Test.dbo.ClientRank foreign keys

ALTER TABLE SmartBank_Test.dbo.ClientRank ADD CONSTRAINT FKklbol3dh3la2mdk281y0mcc19 FOREIGN KEY (Term_OUTREF) REFERENCES SmartBank_Test.dbo.Term(Term_ID);