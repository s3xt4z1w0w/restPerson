-- SmartBank_Test.dbo.map_User_AuthTool definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.map_User_AuthTool;

CREATE TABLE SmartBank_Test.dbo.map_User_AuthTool (
	User_IDREF int NOT NULL,
	AuthTool_IDREF int NOT NULL,
	DateAssigned datetime DEFAULT getdate() NOT NULL,
	InvalidUses int DEFAULT 0 NOT NULL,
	LastInvalidUse datetime NULL,
	CONSTRAINT PK_map_User_AuthTool PRIMARY KEY (User_IDREF,AuthTool_IDREF),
	CONSTRAINT UK_map_User_AuthTool_AuthTool_IDREF UNIQUE (AuthTool_IDREF)
);
ALTER TABLE SmartBank_Test.dbo.map_User_AuthTool WITH NOCHECK ADD CONSTRAINT CK_map_User_AuthTool_Redundancy CHECK ([dbo].[isAuthToolRedundant_Map]([User_IDREF],[AuthTool_IDREF])=(0));


-- SmartBank_Test.dbo.map_User_AuthTool foreign keys

ALTER TABLE SmartBank_Test.dbo.map_User_AuthTool ADD CONSTRAINT FK_map_User_AuthTool_AuthTool FOREIGN KEY (AuthTool_IDREF) REFERENCES SmartBank_Test.dbo.AuthTool(AuthTool_ID);
ALTER TABLE SmartBank_Test.dbo.map_User_AuthTool ADD CONSTRAINT FK_map_User_AuthTool_User FOREIGN KEY (User_IDREF) REFERENCES SmartBank_Test.dbo.[User](User_ID);

-- SmartBank_Test.dbo.AuthToolType definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.AuthToolType;

CREATE TABLE SmartBank_Test.dbo.AuthToolType (
	AuthToolType_ID char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	AuthToolType_Title nvarchar(50) COLLATE Cyrillic_General_CI_AS NOT NULL,
	Term_OUTREF int NULL,
	IsForWeb bit NOT NULL,
	IsForMobile bit NOT NULL,
	MaxInvalidUses int DEFAULT 3 NOT NULL,
	LockoutHours int DEFAULT 24 NOT NULL,
	CONSTRAINT PK_AuthToolType PRIMARY KEY (AuthToolType_ID)
);


-- SmartBank_Test.dbo.AuthTool definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.AuthTool;

CREATE TABLE SmartBank_Test.dbo.AuthTool (
	AuthTool_ID int IDENTITY(1000000,1) NOT NULL,
	AuthToolType_IDREF char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	DateCreated datetime NULL,
	DateValid datetime NOT NULL,
	AuthToolStatus_IDREF char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	AuthTool_OUTREF varchar(20) COLLATE Cyrillic_General_CI_AS NULL,
	RegChannel_IDREF char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	RegisteredBy nvarchar(256) COLLATE Cyrillic_General_CI_AS NULL,
	CONSTRAINT PK_AuthTool PRIMARY KEY (AuthTool_ID)
);
 CREATE NONCLUSTERED INDEX IX_AuthTool_AuthTool_OUTREF ON dbo.AuthTool (  AuthTool_ID ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_AuthTool_AuthTool_OUTREF_AuthToolType_IDREF ON dbo.AuthTool (  AuthTool_OUTREF ASC  , AuthToolType_IDREF ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
ALTER TABLE SmartBank_Test.dbo.AuthTool WITH NOCHECK ADD CONSTRAINT CK_AuthTool_Redundancy CHECK ([dbo].[isAuthToolRedundant_AuthTool]([AuthTool_ID],[AuthToolStatus_IDREF],[AuthToolType_IDREF])=(0));


-- SmartBank_Test.dbo.AuthToolStatus definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.AuthToolStatus;

CREATE TABLE SmartBank_Test.dbo.AuthToolStatus (
	AuthToolStatus_ID char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	AuthToolStatus_Title nvarchar(50) COLLATE Cyrillic_General_CI_AS NOT NULL,
	Term_OUTREF int NULL,
	IsValid bit NOT NULL,
	CONSTRAINT PK_AuthToolStatus PRIMARY KEY (AuthToolStatus_ID)
);


-- SmartBank_Test.dbo.AuthTool foreign keys

ALTER TABLE SmartBank_Test.dbo.AuthTool ADD CONSTRAINT FK_AuthTool_AuthToolStatus FOREIGN KEY (AuthToolStatus_IDREF) REFERENCES SmartBank_Test.dbo.AuthToolStatus(AuthToolStatus_ID);
ALTER TABLE SmartBank_Test.dbo.AuthTool ADD CONSTRAINT FK_AuthTool_AuthToolType FOREIGN KEY (AuthToolType_IDREF) REFERENCES SmartBank_Test.dbo.AuthToolType(AuthToolType_ID);
ALTER TABLE SmartBank_Test.dbo.AuthTool ADD CONSTRAINT FK_AuthTool_RegChannel FOREIGN KEY (RegChannel_IDREF) REFERENCES SmartBank_Test.dbo.RegChannel(RegChannel_ID);


-- SmartBank_Test.dbo.AuthToolStatus foreign keys

ALTER TABLE SmartBank_Test.dbo.AuthToolStatus ADD CONSTRAINT FK6j8ujdbpuro4tn06rduslv4bp FOREIGN KEY (Term_OUTREF) REFERENCES SmartBank_Test.dbo.Term(Term_ID);

-- SmartBank_Test.dbo.RegChannel definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.RegChannel;

CREATE TABLE SmartBank_Test.dbo.RegChannel (
	RegChannel_ID char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	RegChannel_Title nvarchar(50) COLLATE Cyrillic_General_CI_AS NOT NULL,
	CONSTRAINT PK_RegChannel PRIMARY KEY (RegChannel_ID)
);

-- SmartBank_Test.dbo.[User] definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.[User];

CREATE TABLE SmartBank_Test.dbo.[User] (
	User_ID int IDENTITY(1000000,1) NOT NULL,
	Username nvarchar(25) COLLATE Cyrillic_General_CS_AS NOT NULL,
	Person_IDREF int NOT NULL,
	UserStatus_IDREF char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	Locale_IDREF char(2) COLLATE Cyrillic_General_CI_AS NOT NULL,
	UILayout_IDREF int NOT NULL,
	UITheme_IDREF int NOT NULL,
	LoginHourStart tinyint NULL,
	LoginHourEnd tinyint NULL,
	FailedLogins int DEFAULT 0 NOT NULL,
	CodeWord nvarchar(25) COLLATE Cyrillic_General_CI_AS NULL,
	PasswordAge int NULL,
	SessionTimeout int NULL,
	TestLevel_IDREF int DEFAULT 0 NOT NULL,
	DateRegistered smalldatetime NULL,
	Branch_IDREF int NULL,
	RegisteredBy nvarchar(256) COLLATE Cyrillic_General_CI_AS NULL,
	User_OUTREF int NULL,
	RegChannel_IDREF char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	RegFinishDate datetime NULL,
	DateCreated datetime DEFAULT getdate() NULL,
	UIUseSmallCards bit DEFAULT 0 NOT NULL,
	RegisteredBy_Override nvarchar(256) COLLATE Cyrillic_General_CI_AS NULL,
	RegFinishDate_FPHM datetime NULL,
	UnlimitedPassword int DEFAULT 0 NOT NULL,
	IsForcedVerifyRequired bit DEFAULT 0 NULL,
	HideContact bit DEFAULT 0 NOT NULL,
	Region_IDREF int DEFAULT 1020 NULL,
	CONSTRAINT PK_User PRIMARY KEY (User_ID)
);
 CREATE NONCLUSTERED INDEX IX_User_OUTREF ON dbo.User (  User_OUTREF ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE  UNIQUE NONCLUSTERED INDEX IX_User_Person ON dbo.User (  Person_IDREF ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE  UNIQUE NONCLUSTERED INDEX IX_User_Username ON dbo.User (  Username ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
ALTER TABLE SmartBank_Test.dbo.[User] WITH NOCHECK ADD CONSTRAINT CK_User_Login_Hours CHECK ([LoginHourStart] IS NULL AND [LoginHourEnd] IS NULL OR [LoginHourStart] IS NOT NULL AND [LoginHourEnd] IS NOT NULL AND [LoginHourStart]>=(0) AND [LoginHourStart]<=(23) AND [LoginHourEnd]>=(1) AND [LoginHourEnd]<=(24) AND [LoginHourStart]<[LoginHourEnd]);


-- SmartBank_Test.dbo.[User] foreign keys

ALTER TABLE SmartBank_Test.dbo.[User] ADD CONSTRAINT FK1eb0apxcb30k2q91rbt528t62 FOREIGN KEY (Locale_IDREF) REFERENCES SmartBank_Test.dbo.Locale(Locale_ID);
ALTER TABLE SmartBank_Test.dbo.[User] ADD CONSTRAINT FK2yorpkcy293m5r0gmrey5ij48 FOREIGN KEY (Person_IDREF) REFERENCES SmartBank_Test.dbo.Person(Person_ID);
ALTER TABLE SmartBank_Test.dbo.[User] ADD CONSTRAINT FK_User_Locale FOREIGN KEY (Locale_IDREF) REFERENCES SmartBank_Test.dbo.Locale(Locale_ID);
ALTER TABLE SmartBank_Test.dbo.[User] ADD CONSTRAINT FK_User_Person FOREIGN KEY (Person_IDREF) REFERENCES SmartBank_Test.dbo.Person(Person_ID);
ALTER TABLE SmartBank_Test.dbo.[User] ADD CONSTRAINT FK_User_RegChannel FOREIGN KEY (RegChannel_IDREF) REFERENCES SmartBank_Test.dbo.RegChannel(RegChannel_ID);
ALTER TABLE SmartBank_Test.dbo.[User] ADD CONSTRAINT FK_User_TestLevel FOREIGN KEY (TestLevel_IDREF) REFERENCES SmartBank_Test.dbo.TestLevel(TestLevel_ID);
ALTER TABLE SmartBank_Test.dbo.[User] ADD CONSTRAINT FK_User_UILayout FOREIGN KEY (UILayout_IDREF) REFERENCES SmartBank_Test.dbo.UILayout(UILayout_ID);
ALTER TABLE SmartBank_Test.dbo.[User] ADD CONSTRAINT FK_User_UITheme FOREIGN KEY (UITheme_IDREF) REFERENCES SmartBank_Test.dbo.UITheme(UITheme_ID);
ALTER TABLE SmartBank_Test.dbo.[User] ADD CONSTRAINT FK_User_UserStatus FOREIGN KEY (UserStatus_IDREF) REFERENCES SmartBank_Test.dbo.UserStatus(UserStatus_ID);
ALTER TABLE SmartBank_Test.dbo.[User] ADD CONSTRAINT FKnm35ccx2ubkhc1lljcerpmqu6 FOREIGN KEY (UserStatus_IDREF) REFERENCES SmartBank_Test.dbo.UserStatus(UserStatus_ID);

-- SmartBank_Test.dbo.UserStatus definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.UserStatus;

CREATE TABLE SmartBank_Test.dbo.UserStatus (
	UserStatus_ID char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	UserStatus_Title nvarchar(50) COLLATE Cyrillic_General_CI_AS NOT NULL,
	Term_OUTREF int NULL,
	IsValid bit NOT NULL,
	CONSTRAINT PK_UserStatus PRIMARY KEY (UserStatus_ID)
);


-- SmartBank_Test.dbo.UserStatus foreign keys

ALTER TABLE SmartBank_Test.dbo.UserStatus ADD CONSTRAINT FKsaqiv6lcdn9x4t8w5r1otutcm FOREIGN KEY (Term_OUTREF) REFERENCES SmartBank_Test.dbo.Term(Term_ID);

-- SmartBank_Test.dbo.Locale definition

-- Drop table

-- SmartBank_Test.dbo.AuthSMS definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.AuthSMS;

CREATE TABLE SmartBank_Test.dbo.AuthSMS (
	AuthSMS_ID int IDENTITY(1000000,1) NOT NULL,
	AuthTool_IDREF int NOT NULL,
	MobilePhone_IDREF int NOT NULL,
	CONSTRAINT PK_AuthSMS PRIMARY KEY (AuthSMS_ID)
);
 CREATE  UNIQUE NONCLUSTERED INDEX IX_AuthSMS_AuthTool ON dbo.AuthSMS (  AuthTool_IDREF ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX IX_AuthSMS_MobilePhone ON dbo.AuthSMS (  MobilePhone_IDREF ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
ALTER TABLE SmartBank_Test.dbo.AuthSMS WITH NOCHECK ADD CONSTRAINT CK_AuthSMS_MobilePhoneID CHECK ([dbo].[isAuthSMSMobilePhoneUnique]([MobilePhone_IDREF])=(1));


-- SmartBank_Test.dbo.AuthSMS foreign keys

ALTER TABLE SmartBank_Test.dbo.AuthSMS ADD CONSTRAINT FK_AuthSMS_AuthTool FOREIGN KEY (AuthTool_IDREF) REFERENCES SmartBank_Test.dbo.AuthTool(AuthTool_ID);
ALTER TABLE SmartBank_Test.dbo.AuthSMS ADD CONSTRAINT FK_AuthSMS_MobilePhone FOREIGN KEY (MobilePhone_IDREF) REFERENCES SmartBank_Test.dbo.MobilePhone(MobilePhone_ID);

-- DROP TABLE SmartBank_Test.dbo.Locale;

CREATE TABLE SmartBank_Test.dbo.Locale (
	Locale_ID char(2) COLLATE Cyrillic_General_CI_AS NOT NULL,
	Locale_Title char(2) COLLATE Cyrillic_General_CI_AS NOT NULL,
	LCID int NOT NULL,
	CONSTRAINT PK_Locale PRIMARY KEY (Locale_ID)
);

-- SmartBank_Test.dbo.TestLevel definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.TestLevel;

CREATE TABLE SmartBank_Test.dbo.TestLevel (
	TestLevel_ID int NOT NULL,
	TestLevel_Title char(4) COLLATE Cyrillic_General_CI_AS NOT NULL,
	CONSTRAINT PK_TestLevel PRIMARY KEY (TestLevel_ID)
);

-- SmartBank_Test.dbo.UILayout definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.UILayout;

CREATE TABLE SmartBank_Test.dbo.UILayout (
	UILayout_ID int IDENTITY(100,1) NOT NULL,
	UILayout_Title nvarchar(50) COLLATE Cyrillic_General_CI_AS NOT NULL,
	Term_OUTREF int NULL,
	CssFile varchar(50) COLLATE Cyrillic_General_CI_AS NOT NULL,
	CONSTRAINT PK_UILayout PRIMARY KEY (UILayout_ID)
);

-- SmartBank_Test.dbo.UITheme definition

-- Drop table

-- DROP TABLE SmartBank_Test.dbo.UITheme;

CREATE TABLE SmartBank_Test.dbo.UITheme (
	UITheme_ID int IDENTITY(100,1) NOT NULL,
	UITheme_Title nvarchar(50) COLLATE Cyrillic_General_CI_AS NOT NULL,
	Term_OUTREF int NULL,
	CssFile varchar(50) COLLATE Cyrillic_General_CI_AS NOT NULL,
	CONSTRAINT PK_UITheme PRIMARY KEY (UITheme_ID)
);
