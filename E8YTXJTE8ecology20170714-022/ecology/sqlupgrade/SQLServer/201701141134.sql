create table ZhiNiaoLog(
	id int identity primary key not null,
	Code char(2) null,
	Message varchar(100),
	timestamp char(20),
	type varchar(50)
)
GO