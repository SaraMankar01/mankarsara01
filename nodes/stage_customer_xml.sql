   INSERT INTO [TABLEOWNER].[stage_customer_xml] WITH ( TABLOCK )
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
     ds_customer_xml.code,
     ds_customer_xml.name,
     ds_customer_xml.cat_code,
     ds_customer_xml.grp_code,
     ds_customer_xml.subgrp,
     ds_customer_xml.source_sales,
     @v_dss_update_time
   FROM [TABLEOWNER].[ds_customer_xml]
   WHERE @v_ds_customer_process_date BETWEEN dss_start_date AND dss_end_date