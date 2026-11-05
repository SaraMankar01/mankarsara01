MERGE INTO [TABLEOWNER].[ds_customer_ssis]
  USING (
    SELECT 
           load_customer_ssis.customer_code AS customer_code
         , load_customer_ssis.customer_name AS customer_name
         , load_customer_ssis.customer_legal_name AS customer_legal_name
         , load_customer_ssis.territory_id AS territory_id
         , load_customer_ssis.ship_to_address_id AS ship_to_address_id
         , load_customer_ssis.bill_to_address_id AS bill_to_address_id
         , load_customer_ssis.sales_source AS sales_source
         , load_customer_ssis.sold_to_address_id AS sold_to_address_id
         , load_customer_ssis.primary_address_type AS primary_address_type
         , load_customer_ssis.primary_contact_person AS primary_contact_person
         , load_customer_ssis.active_flag AS active_flag
         , load_customer_ssis.customer_category_code AS customer_category_code
         , load_customer_ssis.customer_category_description AS customer_category_description
         , load_customer_ssis.customer_group_code AS customer_group_code
         , load_customer_ssis.customer_group_description AS customer_group_description
         , load_customer_ssis.customer_subgroup_code AS customer_subgroup_code
         , load_customer_ssis.customer_subgroup_description AS customer_subgroup_description
         , load_customer_ssis.creating_employee_id AS creating_employee_id
         , load_customer_ssis.created_datetime AS created_datetime
         , load_customer_ssis.last_change_employee_id AS last_change_employee_id
         , load_customer_ssis.last_change_datetime AS last_change_datetime
         , vers.dss_version
    FROM [TABLEOWNER].[load_customer_ssis] load_customer_ssis
    LEFT OUTER JOIN (
      SELECT customer_code
           , MAX(dss_version) dss_version
      FROM [TABLEOWNER].[ds_customer_ssis] ds_customer_ssis
      GROUP BY customer_code
    ) AS vers
    ON    load_customer_ssis.customer_code = vers.customer_code
    EXCEPT
    SELECT ds_customer_ssis.customer_code  customer_code
         , ds_customer_ssis.customer_name  customer_name
         , ds_customer_ssis.customer_legal_name  customer_legal_name
         , ds_customer_ssis.territory_id  territory_id
         , ds_customer_ssis.ship_to_address_id  ship_to_address_id
         , ds_customer_ssis.bill_to_address_id  bill_to_address_id
         , ds_customer_ssis.sales_source  sales_source
         , ds_customer_ssis.sold_to_address_id  sold_to_address_id
         , ds_customer_ssis.primary_address_type  primary_address_type
         , ds_customer_ssis.primary_contact_person  primary_contact_person
         , ds_customer_ssis.active_flag  active_flag
         , ds_customer_ssis.customer_category_code  customer_category_code
         , ds_customer_ssis.customer_category_description  customer_category_description
         , ds_customer_ssis.customer_group_code  customer_group_code
         , ds_customer_ssis.customer_group_description  customer_group_description
         , ds_customer_ssis.customer_subgroup_code  customer_subgroup_code
         , ds_customer_ssis.customer_subgroup_description  customer_subgroup_description
         , ds_customer_ssis.creating_employee_id  creating_employee_id
         , ds_customer_ssis.created_datetime  created_datetime
         , ds_customer_ssis.last_change_employee_id  last_change_employee_id
         , ds_customer_ssis.last_change_datetime  last_change_datetime
         , dss_version
        FROM [TABLEOWNER].[ds_customer_ssis]
        WHERE ds_customer_ssis.dss_current_flag = 'Y'
  ) AS changes 
  ON (
          ds_customer_ssis.customer_code = changes.customer_code
      AND ds_customer_ssis.dss_current_flag = 'Y'
  )
  WHEN MATCHED THEN 
  UPDATE 
  SET        dss_update_time = @v_current_datetime
  WHEN NOT MATCHED THEN 
  INSERT 
  (       customer_code
        , customer_name
        , customer_legal_name
        , territory_id
        , ship_to_address_id
        , bill_to_address_id
        , sales_source
        , sold_to_address_id
        , primary_address_type
        , primary_contact_person
        , active_flag
        , customer_category_code
        , customer_category_description
        , customer_group_code
        , customer_group_description
        , customer_subgroup_code
        , customer_subgroup_description
        , creating_employee_id
        , created_datetime
        , last_change_employee_id
        , last_change_datetime
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
        , customer_legal_name
        , territory_id
        , ship_to_address_id
        , bill_to_address_id
        , sales_source
        , sold_to_address_id
        , primary_address_type
        , primary_contact_person
        , active_flag
        , customer_category_code
        , customer_category_description
        , customer_group_code
        , customer_group_description
        , customer_subgroup_code
        , customer_subgroup_description
        , creating_employee_id
        , created_datetime
        , last_change_employee_id
        , last_change_datetime
        , CASE WHEN changes.dss_version IS NULL
               THEN CAST('01-JAN-1900' AS datetime)
               ELSE CAST(ISNULL(NULLIF(@v_DS_Customer_Process_Date,''),CONVERT(VARCHAR,GETDATE(),112)) AS DATETIME)
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