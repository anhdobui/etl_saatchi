USE [dwh_htttql]
GO
/****** Object:  Trigger [dbo].[trgAfterInsert_fact_sales]    Script Date: 5/29/2024 11:32:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create TRIGGER [dbo].[trgAfterInsert_fact_sales] 
ON [dwh_htttql].[dbo].[fact_sales]
AFTER INSERT
AS
BEGIN
    
    EXEC ProcessNewValuesFact_sales;
END;