   INSERT INTO [TABLEOWNER].[stage_customer_sales2] WITH ( TABLOCK )
   (
     customer_code,
     customer_name,
     customer_category_code,
     customer_group_code,
     customer_subgroup_code,
     sales_source,
     dss_create_time,
     dss_update_time
   )
   SELECT
     ds_customer_sales2.customer_code,
     ds_customer_sales2.customer_name,
     ds_customer_sales2.customer_category_code,
     ds_customer_sales2.customer_group_code,
     ds_customer_sales2.customer_subgroup_code,
     3 sales_source,
     @v_dss_create_time,
     @v_dss_update_time
   FROM [TABLEOWNER].[ds_customer_sales2]
   WHERE @v_ds_customer_process_date BETWEEN dss_start_date AND dss_end_date