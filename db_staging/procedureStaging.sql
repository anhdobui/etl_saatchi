USE [staging]
GO
/****** Object:  StoredProcedure [dbo].[ETL_Update_Dim_Orders]    Script Date: 5/29/2024 11:05:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[ETL_Update_Dim_Orders]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @currentDateTime DATETIME;
    SET @currentDateTime = GETDATE();

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Log the start of the procedure
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, status)
        VALUES ('ETL_Update_Dim_Orders', @currentDateTime, 'Started');

        -- Step 1: Update existing records that have changed
        UPDATE target
        SET ending_date = @currentDateTime
        FROM dwh_htttql.dbo.dim_orders AS target
        JOIN staging.dbo.orders AS source
        ON target.orders_id = source.id
        WHERE target.ending_date IS NULL
            AND (
                target.code <> source.code OR
                target.status <> dbo.fn_map_status(source.status) OR
                target.delivery_address <> source.delivery_address OR
                target.payment_status <> dbo.fn_map_payment_status(source.payment_status) OR
                target.shipping_cost <> source.shipping_cost
            );

        -- Log the update step completion
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status)
        VALUES ('ETL_Update_Dim_Orders', @currentDateTime, GETDATE(), 'Step 1: Updated existing records');

        -- Step 2: Insert new records
        INSERT INTO dwh_htttql.dbo.dim_orders (
            orders_id,
            code,
            status,
            delivery_address,
            payment_status,
            shipping_cost,
            status_flag,
            starting_date,
            ending_date
        )
        SELECT 
            source.id AS orders_id,
            source.code,
            dbo.fn_map_status(source.status),
            source.delivery_address,
            dbo.fn_map_payment_status(source.payment_status),
            source.shipping_cost,
            1, -- Assuming 1 as active status flag
            @currentDateTime AS starting_date,
            NULL AS ending_date
        FROM staging.dbo.orders AS source
        WHERE NOT EXISTS (
            SELECT 1
            FROM dwh_htttql.dbo.dim_orders AS target
            WHERE target.orders_id = source.id
              AND target.ending_date IS NULL
        );

        -- Log the insert step completion
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status)
        VALUES ('ETL_Update_Dim_Orders', @currentDateTime, GETDATE(), 'Step 2: Inserted new records');

        -- Step 3: Update obsolete records
        UPDATE dwh_htttql.dbo.dim_orders
        SET status_flag = 0
        WHERE ending_date IS NOT NULL
            AND status_flag = 1;

        -- Log the update obsolete records step completion
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status)
        VALUES ('ETL_Update_Dim_Orders', @currentDateTime, GETDATE(), 'Step 3: Updated obsolete records');

        -- Log the end of the procedure
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status)
        VALUES ('ETL_Update_Dim_Orders', @currentDateTime, GETDATE(), 'Ended');

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        -- Logging error
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status, error_message)
        VALUES ('ETL_Update_Dim_Orders', @currentDateTime, GETDATE(), 'Failed', ERROR_MESSAGE());
    END CATCH;
END;
go
create PROCEDURE [dbo].[ETL_Update_Dim_Orders]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @currentDateTime DATETIME;
    SET @currentDateTime = GETDATE();

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Log the start of the procedure
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, status)
        VALUES ('ETL_Update_Dim_Orders', @currentDateTime, 'Started');

        -- Step 1: Update existing records that have changed
        UPDATE target
        SET ending_date = @currentDateTime
        FROM dwh_htttql.dbo.dim_orders AS target
        JOIN staging.dbo.orders AS source
        ON target.orders_id = source.id
        WHERE target.ending_date IS NULL
            AND (
                target.code <> source.code OR
                target.status <> dbo.fn_map_status(source.status) OR
                target.delivery_address <> source.delivery_address OR
                target.payment_status <> dbo.fn_map_payment_status(source.payment_status) OR
                target.shipping_cost <> source.shipping_cost
            );

        -- Log the update step completion
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status)
        VALUES ('ETL_Update_Dim_Orders', @currentDateTime, GETDATE(), 'Step 1: Updated existing records');

        -- Step 2: Insert new records
        INSERT INTO dwh_htttql.dbo.dim_orders (
            orders_id,
            code,
            status,
            delivery_address,
            payment_status,
            shipping_cost,
            status_flag,
            starting_date,
            ending_date
        )
        SELECT 
            source.id AS orders_id,
            source.code,
            dbo.fn_map_status(source.status),
            source.delivery_address,
            dbo.fn_map_payment_status(source.payment_status),
            source.shipping_cost,
            1, -- Assuming 1 as active status flag
            @currentDateTime AS starting_date,
            NULL AS ending_date
        FROM staging.dbo.orders AS source
        WHERE NOT EXISTS (
            SELECT 1
            FROM dwh_htttql.dbo.dim_orders AS target
            WHERE target.orders_id = source.id
              AND target.ending_date IS NULL
        );

        -- Log the insert step completion
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status)
        VALUES ('ETL_Update_Dim_Orders', @currentDateTime, GETDATE(), 'Step 2: Inserted new records');

        -- Step 3: Update obsolete records
        UPDATE dwh_htttql.dbo.dim_orders
        SET status_flag = 0
        WHERE ending_date IS NOT NULL
            AND status_flag = 1;

        -- Log the update obsolete records step completion
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status)
        VALUES ('ETL_Update_Dim_Orders', @currentDateTime, GETDATE(), 'Step 3: Updated obsolete records');

        -- Log the end of the procedure
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status)
        VALUES ('ETL_Update_Dim_Orders', @currentDateTime, GETDATE(), 'Ended');

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        -- Logging error
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status, error_message)
        VALUES ('ETL_Update_Dim_Orders', @currentDateTime, GETDATE(), 'Failed', ERROR_MESSAGE());
    END CATCH;
END;
go
create PROCEDURE [dbo].[ETL_Update_Dim_Painting]
AS
BEGIN
    -- Log the start of the procedure
    DECLARE @StartTime DATETIME = GETDATE();
    INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, status)
    VALUES ('ETL_Update_Dim_Painting', @StartTime, 'Started');

    BEGIN TRY
        -- Step 1: Update existing records
        UPDATE target
        SET end_date = GETDATE()
        FROM dwh_htttql.dbo.dim_painting AS target
        JOIN staging.dbo.painting AS source
        ON target.painting_id = source.id
        WHERE target.end_date IS NULL
            AND (
                target.code <> source.code OR
                target.length <> source.length OR
                target.thickness <> source.thickness OR
                target.width <> source.width OR
                target.name <> source.name OR
                target.artist <> source.artist OR
                target.price <> source.price OR
                target.thumbnail_url <> source.thumbnail_url
            );

        -- Log the update existing records step completion
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status)
        VALUES ('ETL_Update_Dim_Painting', @StartTime, GETDATE(), 'Step 1: Updated existing records');

        -- Step 2: Insert new records
        INSERT INTO dwh_htttql.dbo.dim_painting (
            painting_id,
            code,
            length,
            thickness,
            width,
            name,
            artist,
            price,
            thumbnail_url,
            status_flag,
            starting_date,
            end_date
        )
        SELECT 
            source.id AS painting_id,
            source.code,
            source.length,
            source.thickness,
            source.width,
            source.name,
            source.artist,
            source.price,
            source.thumbnail_url,
            1, -- Assuming 1 as active status flag
            GETDATE() AS starting_date,
            NULL AS end_date
        FROM staging.dbo.painting AS source
        LEFT JOIN dwh_htttql.dbo.dim_painting AS target
        ON target.painting_id = source.id
        WHERE NOT EXISTS (
            SELECT 1
            FROM dwh_htttql.dbo.dim_painting AS target
            WHERE target.painting_id = source.id
              AND target.end_date IS NULL
        );

        -- Log the insert new records step completion
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status)
        VALUES ('ETL_Update_Dim_Painting', @StartTime, GETDATE(), 'Step 2: Inserted new records');

        -- Step 3: Update obsolete records
        UPDATE dwh_htttql.dbo.dim_painting
        SET status_flag = 0
        WHERE end_date IS NOT NULL
            AND status_flag = 1;

        -- Log the update obsolete records step completion
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status)
        VALUES ('ETL_Update_Dim_Painting', @StartTime, GETDATE(), 'Step 3: Updated obsolete records');

        -- Log the end of the procedure
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status)
        VALUES ('ETL_Update_Dim_Painting', @StartTime, GETDATE(), 'Completed');
    END TRY
    BEGIN CATCH
        -- Log the error if any
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status, error_message)
        VALUES ('ETL_Update_Dim_Painting', @StartTime, GETDATE(), 'Error', ERROR_MESSAGE());
    END CATCH;
END;
go
create PROCEDURE [dbo].[ETL_Update_Fact_Sales_RealTime]
    @DateToProcess DATE = NULL
AS
BEGIN
    -- Log the start of the procedure
    INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, status)
    VALUES ('ETL_Update_Fact_Sales_RealTime', GETDATE(), 'Started');

    BEGIN TRY
        -- Update existing records
        UPDATE fs
        SET fs.customer_id = source.customer_id,
            fs.painting_id = source.painting_id,
            fs.total_price = source.total_price
        FROM dwh_htttql.dbo.fact_sales fs
        INNER JOIN (
            SELECT 
                c.acc_id AS customer_id,
                cd.painting_id,
                CONVERT(INT, CONVERT(VARCHAR(8), o.order_date, 112)) AS date_id,
                o.id AS orders_id,
                cd.qty * p.price AS total_price
            FROM staging.dbo.cart_detail cd
            INNER JOIN staging.dbo.cart c ON cd.cart_id = c.id
            INNER JOIN staging.dbo.orders o ON c.id = o.cart_id
            INNER JOIN staging.dbo.painting p ON cd.painting_id = p.id
            INNER JOIN staging.dbo.account a ON c.acc_id = a.id  
            WHERE (@DateToProcess IS NULL OR o.order_date = @DateToProcess)
        ) AS source ON fs.date_id = source.date_id
            AND fs.orders_id = source.orders_id
            AND fs.customer_id = source.customer_id
            AND fs.painting_id = source.painting_id; 

        -- Insert new records
        INSERT INTO dwh_htttql.dbo.fact_sales (customer_id, painting_id, date_id, orders_id, total_price)
        SELECT source.customer_id, source.painting_id, source.date_id, source.orders_id, source.total_price
        FROM (
            SELECT 
                c.acc_id AS customer_id,
                cd.painting_id,
                CONVERT(INT, CONVERT(VARCHAR(8), o.order_date, 112)) AS date_id,
                o.id AS orders_id,
                cd.qty * p.price AS total_price
            FROM staging.dbo.cart_detail cd
            INNER JOIN staging.dbo.cart c ON cd.cart_id = c.id
            INNER JOIN staging.dbo.orders o ON c.id = o.cart_id
            INNER JOIN staging.dbo.painting p ON cd.painting_id = p.id
            INNER JOIN staging.dbo.account a ON c.acc_id = a.id  
            WHERE (@DateToProcess IS NULL OR o.order_date = @DateToProcess)
        ) AS source
        LEFT JOIN dwh_htttql.dbo.fact_sales fs ON fs.date_id = source.date_id
            AND fs.orders_id = source.orders_id
            AND fs.customer_id = source.customer_id
            AND fs.painting_id = source.painting_id  
        WHERE fs.date_id IS NULL;

        -- Log the completion of the process
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status)
        VALUES ('ETL_Update_Fact_Sales_RealTime', GETDATE(), GETDATE(), 'Completed');
    END TRY
    BEGIN CATCH
        -- Log the error if any
        INSERT INTO dwh_htttql.dbo.etl_log (process_name, start_time, end_time, status, error_message)
        VALUES ('ETL_Update_Fact_Sales_RealTime', GETDATE(), GETDATE(), 'Error', ERROR_MESSAGE());
    END CATCH;
END;
