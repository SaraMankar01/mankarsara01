  MERGE INTO [TABLEOWNER].[dim_customer]
  USING (
    SELECT 
           stage_customer_mrg.customer_code AS customer_code
         , stage_customer_mrg.customer_name AS customer_name
         , stage_customer_mrg.customer_category_code AS customer_category_code
         , stage_customer_mrg.customer_group_code AS customer_group_code
         , stage_customer_mrg.customer_subgroup_code AS customer_subgroup_code
         , stage_customer_mrg.sales_source AS sales_source
         , vers.dss_version
    FROM [TABLEOWNER].[stage_customer_mrg] stage_customer_mrg
    LEFT OUTER JOIN (
      SELECT customer_code
           , sales_source
           , MAX(dss_version) dss_version
      FROM [TABLEOWNER].[dim_customer] dim_customer
      GROUP BY customer_code
             , sales_source
    ) AS vers
    ON    stage_customer_mrg.customer_code = vers.customer_code
    AND   stage_customer_mrg.sales_source = vers.sales_source
    EXCEPT
    SELECT dim_customer.customer_code  customer_code
         , dim_customer.customer_name  customer_name
         , dim_customer.customer_category_code  customer_category_code
         , dim_customer.customer_group_code  customer_group_code
         , dim_customer.customer_subgroup_code  customer_subgroup_code
         , dim_customer.sales_source  sales_source
         , dss_version
        FROM [TABLEOWNER].[dim_customer]
        WHERE dim_customer.dss_current_flag = 'Y'
  ) AS changes 
  ON (
          dim_customer.customer_code = changes.customer_code
      AND dim_customer.sales_source = changes.sales_source
      AND dim_customer.dss_current_flag = 'Y'
  )
  WHEN MATCHED THEN 
  UPDATE 
  SET        dss_update_time = @v_current_datetime
  WHEN NOT MATCHED THEN 
  INSERT 
  (       customer_code
        , customer_name
        , customer_category_code
        , customer_group_code
        , customer_subgroup_code
        , sales_source
        , dss_start_date
        , dss_end_date
        , dss_current_flag
        , dss_version
        , dss_create_time
        , dss_update_time
  )
  VALUES 
  (       customer_code
        , customer_name
        , customer_category_code
        , customer_group_code
        , customer_subgroup_code
        , sales_source
        , CASE WHEN changes.dss_version IS NULL
               THEN CAST('01-JAN-1900' AS datetime)
               ELSE @v_current_date
          END
        , CAST('31-DEC-2999' AS datetime)
        , 'Y'
        , CASE WHEN changes.dss_version IS NULL
               THEN 1
               ELSE changes.dss_version +1
          END
        , @v_current_datetime
        , @v_current_datetime
  );