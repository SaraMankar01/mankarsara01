 MERGE INTO [TABLEOWNER].[ds_customer_sales2]
  USING (
    SELECT 
           load_customer_sales2.customer_code AS customer_code
         , load_customer_sales2.customer_name AS customer_name
         , load_customer_sales2.customer_legal_name AS customer_legal_name
         , load_customer_sales2.territory_id AS territory_id
         , load_customer_sales2.ship_to_address_id AS ship_to_address_id
         , load_customer_sales2.bill_to_address_id AS bill_to_address_id
         , load_customer_sales2.sold_to_address_id AS sold_to_address_id
         , load_customer_sales2.primary_address_type AS primary_address_type
         , load_customer_sales2.primary_contact_person AS primary_contact_person
         , load_customer_sales2.active_flag AS active_flag
         , load_customer_sales2.customer_category_code AS customer_category_code
         , load_customer_sales2.customer_category_description AS customer_category_description
         , load_customer_sales2.customer_group_code AS customer_group_code
         , load_customer_sales2.customer_group_description AS customer_group_description
         , load_customer_sales2.customer_subgroup_code AS customer_subgroup_code
         , load_customer_sales2.customer_subgroup_description AS customer_subgroup_description
         , load_customer_sales2.creating_employee_id AS creating_employee_id
         , load_customer_sales2.created_datetime AS created_datetime
         , load_customer_sales2.last_change_employee_id AS last_change_employee_id
         , load_customer_sales2.last_change_datetime AS last_change_datetime
         , vers.dss_version
    FROM [TABLEOWNER].[load_customer_sales2] load_customer_sales2
  ) AS changes 
  ON (
          ds_customer_sales2.customer_code = changes.customer_code
      AND ds_customer_sales2.dss_current_flag = 'Y'
  )
  WHEN MATCHED THEN 
  UPDATE 
  SET     customer_name =  changes.customer_name
        , customer_legal_name =  changes.customer_legal_name
        , territory_id =  changes.territory_id
        , ship_to_address_id =  changes.ship_to_address_id
        , bill_to_address_id =  changes.bill_to_address_id
        , sold_to_address_id =  changes.sold_to_address_id
        , primary_address_type =  changes.primary_address_type
        , primary_contact_person =  changes.primary_contact_person
        , active_flag =  changes.active_flag
        , customer_category_code =  changes.customer_category_code
        , customer_category_description =  changes.customer_category_description
        , customer_group_code =  changes.customer_group_code
        , customer_group_description =  changes.customer_group_description
        , customer_subgroup_code =  changes.customer_subgroup_code
        , customer_subgroup_description =  changes.customer_subgroup_description
        , creating_employee_id =  changes.creating_employee_id
        , created_datetime =  changes.created_datetime
        , last_change_employee_id =  changes.last_change_employee_id
        , last_change_datetime =  changes.last_change_datetime
        , dss_update_time = @v_current_datetime
  WHEN NOT MATCHED THEN 
  INSERT 
  (       customer_code
        , customer_name
        , customer_legal_name
        , territory_id
        , ship_to_address_id
        , bill_to_address_id
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
        , CAST('31-DEC-2999' AS datetime)
        , 'Y'
        ,changes.dss_version
        , @v_current_datetime
        , @v_current_datetime
  );