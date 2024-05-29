USE [dwh_htttql]
GO
/****** Object:  StoredProcedure [dbo].[ProcessNewValuesFact_sales]    Script Date: 5/29/2024 11:32:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

     create PROCEDURE [dbo].[ProcessNewValuesFact_sales]
     AS
     BEGIN 
     
            TRUNCATE TABLE [cubes_htttql].[dbo].cube_;
            INSERT INTO [cubes_htttql].[dbo].cube_
            SELECT  sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            ;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_orders
            SELECT do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_status;
            INSERT INTO [cubes_htttql].[dbo].cube_status
            SELECT do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_painting
            SELECT dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_painting_orders
            SELECT dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_painting_status
            SELECT dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_customer
            SELECT dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_customer_orders
            SELECT dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_customer_status
            SELECT dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_customer_painting
            SELECT dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_customer_painting_orders
            SELECT dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_customer_painting_status
            SELECT dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_date;
            INSERT INTO [cubes_htttql].[dbo].cube_date
            SELECT dd.date_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.date_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_date_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_date_orders
            SELECT dd.date_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.date_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_date_status;
            INSERT INTO [cubes_htttql].[dbo].cube_date_status
            SELECT dd.date_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.date_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_date_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_date_painting
            SELECT dd.date_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.date_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_date_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_date_painting_orders
            SELECT dd.date_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.date_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_date_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_date_painting_status
            SELECT dd.date_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.date_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_date_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_date_customer
            SELECT dd.date_id,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.date_id,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_date_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_date_customer_orders
            SELECT dd.date_id,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.date_id,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_date_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_date_customer_status
            SELECT dd.date_id,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.date_id,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_date_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_date_customer_painting
            SELECT dd.date_id,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.date_id,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_date_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_date_customer_painting_orders
            SELECT dd.date_id,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.date_id,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_date_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_date_customer_painting_status
            SELECT dd.date_id,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.date_id,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year;
            INSERT INTO [cubes_htttql].[dbo].cube_year
            SELECT dd.year, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_orders
            SELECT dd.year,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_status
            SELECT dd.year,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_painting
            SELECT dd.year,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_painting_orders
            SELECT dd.year,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_painting_status
            SELECT dd.year,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_year_customer
            SELECT dd.year,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_customer_orders
            SELECT dd.year,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_customer_status
            SELECT dd.year,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_customer_painting
            SELECT dd.year,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_customer_painting_orders
            SELECT dd.year,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_customer_painting_status
            SELECT dd.year,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter
            SELECT dd.quarter, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_orders
            SELECT dd.quarter,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_status
            SELECT dd.quarter,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_painting
            SELECT dd.quarter,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_painting_orders
            SELECT dd.quarter,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_painting_status
            SELECT dd.quarter,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_customer
            SELECT dd.quarter,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_customer_orders
            SELECT dd.quarter,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_customer_status
            SELECT dd.quarter,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_customer_painting
            SELECT dd.quarter,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_customer_painting_orders
            SELECT dd.quarter,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_customer_painting_status
            SELECT dd.quarter,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month;
            INSERT INTO [cubes_htttql].[dbo].cube_month
            SELECT dd.month, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_month_orders
            SELECT dd.month,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_status;
            INSERT INTO [cubes_htttql].[dbo].cube_month_status
            SELECT dd.month,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_month_painting
            SELECT dd.month,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_month_painting_orders
            SELECT dd.month,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_month_painting_status
            SELECT dd.month,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_month_customer
            SELECT dd.month,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_month_customer_orders
            SELECT dd.month,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_month_customer_status
            SELECT dd.month,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_month_customer_painting
            SELECT dd.month,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_month_customer_painting_orders
            SELECT dd.month,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_month_customer_painting_status
            SELECT dd.month,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_day;
            INSERT INTO [cubes_htttql].[dbo].cube_day
            SELECT dd.day, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.day;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_day_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_day_orders
            SELECT dd.day,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.day,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_day_status;
            INSERT INTO [cubes_htttql].[dbo].cube_day_status
            SELECT dd.day,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.day,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_day_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_day_painting
            SELECT dd.day,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.day,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_day_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_day_painting_orders
            SELECT dd.day,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.day,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_day_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_day_painting_status
            SELECT dd.day,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.day,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_day_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_day_customer
            SELECT dd.day,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.day,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_day_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_day_customer_orders
            SELECT dd.day,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.day,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_day_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_day_customer_status
            SELECT dd.day,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.day,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_day_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_day_customer_painting
            SELECT dd.day,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.day,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_day_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_day_customer_painting_orders
            SELECT dd.day,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.day,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_day_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_day_customer_painting_status
            SELECT dd.day,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.day,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week;
            INSERT INTO [cubes_htttql].[dbo].cube_week
            SELECT dd.week, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_week_orders
            SELECT dd.week,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_status;
            INSERT INTO [cubes_htttql].[dbo].cube_week_status
            SELECT dd.week,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_week_painting
            SELECT dd.week,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_week_painting_orders
            SELECT dd.week,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_week_painting_status
            SELECT dd.week,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_week_customer
            SELECT dd.week,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_week_customer_orders
            SELECT dd.week,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_week_customer_status
            SELECT dd.week,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_week_customer_painting
            SELECT dd.week,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_week_customer_painting_orders
            SELECT dd.week,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_week_customer_painting_status
            SELECT dd.week,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_day;
            INSERT INTO [cubes_htttql].[dbo].cube_month_day
            SELECT dd.month,dd.day, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dd.day;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_day_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_month_day_orders
            SELECT dd.month,dd.day,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dd.day,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_day_status;
            INSERT INTO [cubes_htttql].[dbo].cube_month_day_status
            SELECT dd.month,dd.day,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dd.day,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_day_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_month_day_painting
            SELECT dd.month,dd.day,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dd.day,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_day_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_month_day_painting_orders
            SELECT dd.month,dd.day,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dd.day,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_day_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_month_day_painting_status
            SELECT dd.month,dd.day,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dd.day,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_day_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_month_day_customer
            SELECT dd.month,dd.day,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dd.day,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_day_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_month_day_customer_orders
            SELECT dd.month,dd.day,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dd.day,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_day_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_month_day_customer_status
            SELECT dd.month,dd.day,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dd.day,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_day_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_month_day_customer_painting
            SELECT dd.month,dd.day,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dd.day,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_day_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_month_day_customer_painting_orders
            SELECT dd.month,dd.day,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dd.day,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_month_day_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_month_day_customer_painting_status
            SELECT dd.month,dd.day,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.month,dd.day,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_day;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_day
            SELECT dd.quarter,dd.day, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.day;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_day_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_day_orders
            SELECT dd.quarter,dd.day,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.day,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_day_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_day_status
            SELECT dd.quarter,dd.day,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.day,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_day_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_day_painting
            SELECT dd.quarter,dd.day,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.day,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_day_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_day_painting_orders
            SELECT dd.quarter,dd.day,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.day,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_day_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_day_painting_status
            SELECT dd.quarter,dd.day,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.day,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_day_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_day_customer
            SELECT dd.quarter,dd.day,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.day,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_day_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_day_customer_orders
            SELECT dd.quarter,dd.day,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.day,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_day_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_day_customer_status
            SELECT dd.quarter,dd.day,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.day,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_day_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_day_customer_painting
            SELECT dd.quarter,dd.day,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.day,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_day_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_day_customer_painting_orders
            SELECT dd.quarter,dd.day,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.day,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_day_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_day_customer_painting_status
            SELECT dd.quarter,dd.day,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.day,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month
            SELECT dd.quarter,dd.month, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_orders
            SELECT dd.quarter,dd.month,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_status
            SELECT dd.quarter,dd.month,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_painting
            SELECT dd.quarter,dd.month,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_painting_orders
            SELECT dd.quarter,dd.month,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_painting_status
            SELECT dd.quarter,dd.month,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_customer
            SELECT dd.quarter,dd.month,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_customer_orders
            SELECT dd.quarter,dd.month,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_customer_status
            SELECT dd.quarter,dd.month,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_customer_painting
            SELECT dd.quarter,dd.month,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_customer_painting_orders
            SELECT dd.quarter,dd.month,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_customer_painting_status
            SELECT dd.quarter,dd.month,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_day;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_day
            SELECT dd.quarter,dd.month,dd.day, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dd.day;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_day_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_day_orders
            SELECT dd.quarter,dd.month,dd.day,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dd.day,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_day_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_day_status
            SELECT dd.quarter,dd.month,dd.day,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dd.day,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_day_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_day_painting
            SELECT dd.quarter,dd.month,dd.day,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dd.day,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_day_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_day_painting_orders
            SELECT dd.quarter,dd.month,dd.day,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dd.day,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_day_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_day_painting_status
            SELECT dd.quarter,dd.month,dd.day,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dd.day,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_day_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_day_customer
            SELECT dd.quarter,dd.month,dd.day,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dd.day,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_day_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_day_customer_orders
            SELECT dd.quarter,dd.month,dd.day,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dd.day,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_day_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_day_customer_status
            SELECT dd.quarter,dd.month,dd.day,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dd.day,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_day_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_day_customer_painting
            SELECT dd.quarter,dd.month,dd.day,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dd.day,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_day_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_day_customer_painting_orders
            SELECT dd.quarter,dd.month,dd.day,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dd.day,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_quarter_month_day_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_quarter_month_day_customer_painting_status
            SELECT dd.quarter,dd.month,dd.day,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.quarter,dd.month,dd.day,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_day;
            INSERT INTO [cubes_htttql].[dbo].cube_year_day
            SELECT dd.year,dd.day, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.day;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_day_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_day_orders
            SELECT dd.year,dd.day,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.day,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_day_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_day_status
            SELECT dd.year,dd.day,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.day,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_day_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_day_painting
            SELECT dd.year,dd.day,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.day,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_day_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_day_painting_orders
            SELECT dd.year,dd.day,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.day,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_day_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_day_painting_status
            SELECT dd.year,dd.day,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.day,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_day_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_year_day_customer
            SELECT dd.year,dd.day,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.day,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_day_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_day_customer_orders
            SELECT dd.year,dd.day,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.day,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_day_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_day_customer_status
            SELECT dd.year,dd.day,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.day,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_day_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_day_customer_painting
            SELECT dd.year,dd.day,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.day,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_day_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_day_customer_painting_orders
            SELECT dd.year,dd.day,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.day,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_day_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_day_customer_painting_status
            SELECT dd.year,dd.day,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.day,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month
            SELECT dd.year,dd.month, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_orders
            SELECT dd.year,dd.month,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_status
            SELECT dd.year,dd.month,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_painting
            SELECT dd.year,dd.month,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_painting_orders
            SELECT dd.year,dd.month,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_painting_status
            SELECT dd.year,dd.month,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_customer
            SELECT dd.year,dd.month,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_customer_orders
            SELECT dd.year,dd.month,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_customer_status
            SELECT dd.year,dd.month,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_customer_painting
            SELECT dd.year,dd.month,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_customer_painting_orders
            SELECT dd.year,dd.month,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_customer_painting_status
            SELECT dd.year,dd.month,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_day;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_day
            SELECT dd.year,dd.month,dd.day, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dd.day;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_day_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_day_orders
            SELECT dd.year,dd.month,dd.day,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dd.day,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_day_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_day_status
            SELECT dd.year,dd.month,dd.day,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dd.day,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_day_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_day_painting
            SELECT dd.year,dd.month,dd.day,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dd.day,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_day_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_day_painting_orders
            SELECT dd.year,dd.month,dd.day,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dd.day,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_day_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_day_painting_status
            SELECT dd.year,dd.month,dd.day,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dd.day,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_day_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_day_customer
            SELECT dd.year,dd.month,dd.day,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dd.day,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_day_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_day_customer_orders
            SELECT dd.year,dd.month,dd.day,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dd.day,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_day_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_day_customer_status
            SELECT dd.year,dd.month,dd.day,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dd.day,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_day_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_day_customer_painting
            SELECT dd.year,dd.month,dd.day,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dd.day,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_day_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_day_customer_painting_orders
            SELECT dd.year,dd.month,dd.day,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dd.day,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_month_day_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_month_day_customer_painting_status
            SELECT dd.year,dd.month,dd.day,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.month,dd.day,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter
            SELECT dd.year,dd.quarter, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_orders
            SELECT dd.year,dd.quarter,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_status
            SELECT dd.year,dd.quarter,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_painting
            SELECT dd.year,dd.quarter,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_painting_orders
            SELECT dd.year,dd.quarter,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_painting_status
            SELECT dd.year,dd.quarter,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_customer
            SELECT dd.year,dd.quarter,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_customer_orders
            SELECT dd.year,dd.quarter,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_customer_status
            SELECT dd.year,dd.quarter,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_customer_painting
            SELECT dd.year,dd.quarter,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_customer_painting_orders
            SELECT dd.year,dd.quarter,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_customer_painting_status
            SELECT dd.year,dd.quarter,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_day;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_day
            SELECT dd.year,dd.quarter,dd.day, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.day;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_day_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_day_orders
            SELECT dd.year,dd.quarter,dd.day,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.day,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_day_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_day_status
            SELECT dd.year,dd.quarter,dd.day,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.day,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_day_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_day_painting
            SELECT dd.year,dd.quarter,dd.day,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.day,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_day_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_day_painting_orders
            SELECT dd.year,dd.quarter,dd.day,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.day,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_day_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_day_painting_status
            SELECT dd.year,dd.quarter,dd.day,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.day,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_day_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_day_customer
            SELECT dd.year,dd.quarter,dd.day,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.day,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_day_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_day_customer_orders
            SELECT dd.year,dd.quarter,dd.day,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.day,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_day_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_day_customer_status
            SELECT dd.year,dd.quarter,dd.day,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.day,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_day_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_day_customer_painting
            SELECT dd.year,dd.quarter,dd.day,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.day,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_day_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_day_customer_painting_orders
            SELECT dd.year,dd.quarter,dd.day,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.day,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_day_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_day_customer_painting_status
            SELECT dd.year,dd.quarter,dd.day,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.day,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month
            SELECT dd.year,dd.quarter,dd.month, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_orders
            SELECT dd.year,dd.quarter,dd.month,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_status
            SELECT dd.year,dd.quarter,dd.month,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_painting
            SELECT dd.year,dd.quarter,dd.month,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_painting_orders
            SELECT dd.year,dd.quarter,dd.month,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_painting_status
            SELECT dd.year,dd.quarter,dd.month,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_customer
            SELECT dd.year,dd.quarter,dd.month,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_customer_orders
            SELECT dd.year,dd.quarter,dd.month,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_customer_status
            SELECT dd.year,dd.quarter,dd.month,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_customer_painting
            SELECT dd.year,dd.quarter,dd.month,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_customer_painting_orders
            SELECT dd.year,dd.quarter,dd.month,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_customer_painting_status
            SELECT dd.year,dd.quarter,dd.month,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_day;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_day
            SELECT dd.year,dd.quarter,dd.month,dd.day, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dd.day;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_day_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_day_orders
            SELECT dd.year,dd.quarter,dd.month,dd.day,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dd.day,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_day_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_day_status
            SELECT dd.year,dd.quarter,dd.month,dd.day,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dd.day,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_day_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_day_painting
            SELECT dd.year,dd.quarter,dd.month,dd.day,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dd.day,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_day_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_day_painting_orders
            SELECT dd.year,dd.quarter,dd.month,dd.day,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dd.day,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_day_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_day_painting_status
            SELECT dd.year,dd.quarter,dd.month,dd.day,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dd.day,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_day_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_day_customer
            SELECT dd.year,dd.quarter,dd.month,dd.day,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dd.day,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_day_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_day_customer_orders
            SELECT dd.year,dd.quarter,dd.month,dd.day,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dd.day,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_day_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_day_customer_status
            SELECT dd.year,dd.quarter,dd.month,dd.day,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dd.day,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_day_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_day_customer_painting
            SELECT dd.year,dd.quarter,dd.month,dd.day,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dd.day,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_day_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_day_customer_painting_orders
            SELECT dd.year,dd.quarter,dd.month,dd.day,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dd.day,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_quarter_month_day_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_quarter_month_day_customer_painting_status
            SELECT dd.year,dd.quarter,dd.month,dd.day,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.quarter,dd.month,dd.day,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_day;
            INSERT INTO [cubes_htttql].[dbo].cube_week_day
            SELECT dd.week,dd.day, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dd.day;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_day_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_week_day_orders
            SELECT dd.week,dd.day,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dd.day,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_day_status;
            INSERT INTO [cubes_htttql].[dbo].cube_week_day_status
            SELECT dd.week,dd.day,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dd.day,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_day_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_week_day_painting
            SELECT dd.week,dd.day,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dd.day,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_day_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_week_day_painting_orders
            SELECT dd.week,dd.day,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dd.day,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_day_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_week_day_painting_status
            SELECT dd.week,dd.day,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dd.day,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_day_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_week_day_customer
            SELECT dd.week,dd.day,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dd.day,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_day_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_week_day_customer_orders
            SELECT dd.week,dd.day,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dd.day,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_day_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_week_day_customer_status
            SELECT dd.week,dd.day,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dd.day,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_day_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_week_day_customer_painting
            SELECT dd.week,dd.day,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dd.day,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_day_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_week_day_customer_painting_orders
            SELECT dd.week,dd.day,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dd.day,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_week_day_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_week_day_customer_painting_status
            SELECT dd.week,dd.day,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.week,dd.day,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week
            SELECT dd.year,dd.week, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_orders
            SELECT dd.year,dd.week,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_status
            SELECT dd.year,dd.week,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_painting
            SELECT dd.year,dd.week,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_painting_orders
            SELECT dd.year,dd.week,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_painting_status
            SELECT dd.year,dd.week,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_customer
            SELECT dd.year,dd.week,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_customer_orders
            SELECT dd.year,dd.week,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_customer_status
            SELECT dd.year,dd.week,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_customer_painting
            SELECT dd.year,dd.week,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_customer_painting_orders
            SELECT dd.year,dd.week,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_customer_painting_status
            SELECT dd.year,dd.week,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dc.customer_id,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_day;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_day
            SELECT dd.year,dd.week,dd.day, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dd.day;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_day_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_day_orders
            SELECT dd.year,dd.week,dd.day,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dd.day,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_day_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_day_status
            SELECT dd.year,dd.week,dd.day,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dd.day,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_day_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_day_painting
            SELECT dd.year,dd.week,dd.day,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dd.day,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_day_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_day_painting_orders
            SELECT dd.year,dd.week,dd.day,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dd.day,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_day_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_day_painting_status
            SELECT dd.year,dd.week,dd.day,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dd.day,dp.painting_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_day_customer;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_day_customer
            SELECT dd.year,dd.week,dd.day,dc.customer_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dd.day,dc.customer_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_day_customer_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_day_customer_orders
            SELECT dd.year,dd.week,dd.day,dc.customer_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dd.day,dc.customer_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_day_customer_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_day_customer_status
            SELECT dd.year,dd.week,dd.day,dc.customer_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dd.day,dc.customer_id,do.status;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_day_customer_painting;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_day_customer_painting
            SELECT dd.year,dd.week,dd.day,dc.customer_id,dp.painting_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dd.day,dc.customer_id,dp.painting_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_day_customer_painting_orders;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_day_customer_painting_orders
            SELECT dd.year,dd.week,dd.day,dc.customer_id,dp.painting_id,do.orders_id, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dd.day,dc.customer_id,dp.painting_id,do.orders_id;
                 
            

            TRUNCATE TABLE [cubes_htttql].[dbo].cube_year_week_day_customer_painting_status;
            INSERT INTO [cubes_htttql].[dbo].cube_year_week_day_customer_painting_status
            SELECT dd.year,dd.week,dd.day,dc.customer_id,dp.painting_id,do.status, sum(fs.total_price) as total_price
            FROM [dwh_htttql].[dbo].[fact_sales] fs
            join dim_date dd on dd.date_id = fs.date_id
            join dim_customer dc on dc.customer_id = fs.customer_id
            join dim_painting dp on dp.painting_id = fs.painting_id
            join dim_orders do on do.orders_id = fs.orders_id
            where do.status_flag = 1 and dc.status_flag = 1 and dp.status_flag = 1
            group by dd.year,dd.week,dd.day,dc.customer_id,dp.painting_id,do.status;
                 
            
     END;


