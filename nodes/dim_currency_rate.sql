MERGE INTO [TABLEOWNER].[dim_currency_rate]
  USING (
    SELECT 
           stage_currency_rate.originating_currency_code AS originating_currency_code
         , stage_currency_rate.destination_currency_code AS destination_currency_code
         , stage_currency_rate.effective_from_date AS effective_from_date
         , stage_currency_rate.thru_date AS thru_date
         , stage_currency_rate.exchange_rate AS exchange_rate
         , stage_currency_rate.exchange_rate_multiplier AS exchange_rate_multiplier
         , stage_currency_rate.creating_employee_id AS creating_employee_id
         , stage_currency_rate.created_datetime AS created_datetime
         , stage_currency_rate.last_change_employee_id AS last_change_employee_id
         , stage_currency_rate.last_change_datetime AS last_change_datetime
    FROM [TABLEOWNER].[stage_currency_rate] stage_currency_rate
    EXCEPT
    SELECT dim_currency_rate.originating_currency_code  originating_currency_code
         , dim_currency_rate.destination_currency_code  destination_currency_code
         , dim_currency_rate.effective_from_date  effective_from_date
         , dim_currency_rate.thru_date  thru_date
         , dim_currency_rate.exchange_rate  exchange_rate
         , dim_currency_rate.exchange_rate_multiplier  exchange_rate_multiplier
         , dim_currency_rate.creating_employee_id  creating_employee_id
         , dim_currency_rate.created_datetime  created_datetime
         , dim_currency_rate.last_change_employee_id  last_change_employee_id
         , dim_currency_rate.last_change_datetime  last_change_datetime
        FROM [TABLEOWNER].[dim_currency_rate]
  ) AS changes 
  ON (
          dim_currency_rate.originating_currency_code = changes.originating_currency_code
      AND dim_currency_rate.destination_currency_code = changes.destination_currency_code
      AND dim_currency_rate.effective_from_date = changes.effective_from_date
  )
  WHEN MATCHED THEN 
  UPDATE 
  SET     thru_date =  changes.thru_date
        , exchange_rate =  changes.exchange_rate
        , exchange_rate_multiplier =  changes.exchange_rate_multiplier
        , creating_employee_id =  changes.creating_employee_id
        , created_datetime =  changes.created_datetime
        , last_change_employee_id =  changes.last_change_employee_id
        , last_change_datetime =  changes.last_change_datetime
        , dss_update_time = @v_current_datetime
  WHEN NOT MATCHED THEN 
  INSERT 
  (       originating_currency_code
        , destination_currency_code
        , effective_from_date
        , thru_date
        , exchange_rate
        , exchange_rate_multiplier
        , creating_employee_id
        , created_datetime
        , last_change_employee_id
        , last_change_datetime
        , dss_create_time
        , dss_update_time
  )
  VALUES 
  (       originating_currency_code
        , destination_currency_code
        , effective_from_date
        , thru_date
        , exchange_rate
        , exchange_rate_multiplier
        , creating_employee_id
        , created_datetime
        , last_change_employee_id
        , last_change_datetime
        , @v_current_datetime
        , @v_current_datetime
  );