USE [staging]
GO
/****** Object:  Trigger [dbo].[trg_Update_Dim_Customer]    Script Date: 5/29/2024 11:02:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create TRIGGER [dbo].[trg_Update_Dim_Customer]
ON [dbo].[account]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Gọi stored procedure ETL_Update_Dim_Customer
    EXEC dbo.ETL_Update_Dim_Customer;
END;
go
create TRIGGER [dbo].[trg_Update_Dim_Orders]
ON [dbo].[orders]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Gọi stored procedure ETL_Update_Dim_Orders
    EXEC dbo.ETL_Update_Dim_Orders;
	EXEC dbo.ETL_Update_Fact_Sales_RealTime;
END;
go
create TRIGGER [dbo].[trg_Update_Dim_Painting]
ON [dbo].[painting]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Gọi stored procedure ETL_Update_Dim_Painting
    EXEC dbo.ETL_Update_Dim_Painting;
END;
go
create TRIGGER [dbo].[trg_Update_Dim_Orders]
ON [dbo].[orders]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Gọi stored procedure ETL_Update_Dim_Orders
    EXEC dbo.ETL_Update_Dim_Orders;
	EXEC dbo.ETL_Update_Fact_Sales_RealTime;
END;