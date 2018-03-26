create table msg_token(
	[id] int identity(1,1) primary key not null,
	[token] varchar(100) null,
	[tokentype_name] varchar(50) null,
	[tokentype] char(1) null,
	[createdate] smalldatetime null
)