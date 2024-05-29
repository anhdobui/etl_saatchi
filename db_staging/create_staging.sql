USE [staging]
GO

/****** Object:  Table [dbo].[account]    Script Date: 5/29/2024 10:50:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[account](
	[id] [bigint] NOT NULL,
	[createdby] [nvarchar](255) NULL,
	[createddate] [datetime2](6) NULL,
	[modifiedby] [nvarchar](255) NULL,
	[modifieddate] [datetime2](6) NULL,
	[city] [nvarchar](255) NULL,
	[district] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[fullname] [nvarchar](255) NULL,
	[grade] [float] NULL,
	[password] [nvarchar](255) NULL,
	[phone] [nvarchar](255) NULL,
	[point_address] [nvarchar](255) NULL,
	[username] [nvarchar](255) NULL,
	[ward] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[cart](
	[id] [bigint] NOT NULL,
	[createdby] [nvarchar](255) NULL,
	[createddate] [datetime2](6) NULL,
	[modifiedby] [nvarchar](255) NULL,
	[modifieddate] [datetime2](6) NULL,
	[status] [int] NULL,
	[acc_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[cart_detail](
	[id] [bigint] NOT NULL,
	[createdby] [nvarchar](255) NULL,
	[createddate] [datetime2](6) NULL,
	[modifiedby] [nvarchar](255) NULL,
	[modifieddate] [datetime2](6) NULL,
	[qty] [int] NULL,
	[cart_id] [bigint] NULL,
	[painting_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[orders](
	[id] [bigint] NOT NULL,
	[createdby] [nvarchar](255) NULL,
	[createddate] [datetime2](6) NULL,
	[modifiedby] [nvarchar](255) NULL,
	[modifieddate] [datetime2](6) NULL,
	[cancellation_date] [datetime2](6) NULL,
	[code] [nvarchar](255) NULL,
	[delivery_date] [datetime2](6) NULL,
	[finished_date] [datetime2](6) NULL,
	[order_date] [datetime2](6) NULL,
	[status] [int] NULL,
	[cart_id] [bigint] NULL,
	[delivery_address] [nvarchar](255) NULL,
	[payment_status] [int] NULL,
	[shipping_cost] [float] NULL,
 CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[painting](
	[id] [bigint] NOT NULL,
	[createdby] [nvarchar](255) NULL,
	[createddate] [datetime2](6) NULL,
	[modifiedby] [nvarchar](255) NULL,
	[modifieddate] [datetime2](6) NULL,
	[code] [nvarchar](255) NULL,
	[inventory] [int] NULL,
	[length] [float] NULL,
	[name] [nvarchar](255) NULL,
	[price] [float] NULL,
	[thickness] [float] NULL,
	[thumbnail_url] [nvarchar](255) NULL,
	[width] [float] NULL,
	[artist] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

