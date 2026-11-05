   INSERT INTO [TABLEOWNER].[stage_customer_ssis] WITH ( TABLOCK )
   (
     customer_code,
     customer_name,
     customer_category_code,
     customer_group_code,
     customer_subgroup_code,
     sales_source,
     dss_update_time
   )
   SELECT
     ds_customer_ssis.customer_code,
     ds_customer_ssis.customer_name,
     ds_customer_ssis.customer_category_code,
     ds_customer_ssis.customer_group_code,
     ds_customer_ssis.customer_subgroup_code,
     ds_customer_ssis.sales_source,
     @v_dss_update_time
   FROM [TABLEOWNER].[ds_customer_ssis]
   WHERE @v_ds_customer_process_date BETWEEN dss_start_date AND dss_end_date 