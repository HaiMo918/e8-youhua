CREATE TABLE [dbo].[msg_errorinfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[msg_id] [int] NULL,
	[msg_info] [varchar](100) NULL,
	[requestid] [int] NULL,
	[senddatetime] [varchar](20) NULL
)
GO