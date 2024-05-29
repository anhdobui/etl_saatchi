USE [dwh_htttql]
GO

/****** Object:  Table [dbo].[dim_customer]    Script Date: 5/29/2024 11:29:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dim_customer](
	[customer_scd_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[fullname] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[phone] [nvarchar](50) NULL,
	[username] [nvarchar](50) NULL,
	[point_address] [nvarchar](255) NULL,
	[ward] [nvarchar](255) NULL,
	[district] [nvarchar](255) NULL,
	[city] [nvarchar](255) NULL,
	[grade] [nvarchar](50) NULL,
	[status_flag] [int] NULL,
	[starting_date] [datetime] NULL,
	[ending_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_scd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[dim_date](
	[date_id] [int] NOT NULL,
	[date] [date] NULL,
	[day] [int] NULL,
	[week] [int] NULL,
	[month] [int] NULL,
	[quarter] [int] NULL,
	[year] [int] NULL
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[dim_orders](
	[orders_scd_id] [int] IDENTITY(1,1) NOT NULL,
	[orders_id] [int] NULL,
	[code] [nvarchar](50) NULL,
	[status] [nvarchar](20) NULL,
	[delivery_address] [nvarchar](255) NULL,
	[payment_status] [nvarchar](20) NULL,
	[shipping_cost] [decimal](18, 2) NULL,
	[status_flag] [int] NULL,
	[starting_date] [datetime] NULL,
	[ending_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[orders_scd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[dim_painting](
	[painting_scd_id] [int] IDENTITY(1,1) NOT NULL,
	[painting_id] [int] NULL,
	[code] [nvarchar](50) NULL,
	[length] [decimal](18, 2) NULL,
	[thickness] [decimal](18, 2) NULL,
	[width] [decimal](18, 2) NULL,
	[name] [nvarchar](255) NULL,
	[artist] [nvarchar](255) NULL,
	[price] [decimal](18, 2) NULL,
	[thumbnail_url] [nvarchar](255) NULL,
	[status_flag] [int] NULL,
	[starting_date] [datetime] NULL,
	[end_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[painting_scd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[fact_sales](
	[fact_sales_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[painting_id] [int] NULL,
	[date_id] [int] NULL,
	[orders_id] [int] NULL,
	[total_price] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[fact_sales_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[etl_log](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[process_name] [nvarchar](100) NULL,
	[start_time] [datetime] NULL,
	[end_time] [datetime] NULL,
	[status] [nvarchar](50) NULL,
	[error_message] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO