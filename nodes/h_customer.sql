    INSERT INTO [TABLEOWNER].[h_customer]
      ( hk_h_customer
      , customer_name
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_customer_traders_south.hk_h_customer AS hk_h_customer 
           , stage_customer_traders_south.customer_name AS customer_name 
           , stage_customer_traders_south.dss_record_source AS dss_record_source 
           , stage_customer_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_customer_traders_south] stage_customer_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_customer] h_customer
        WHERE  stage_customer_traders_south.customer_name = h_customer.customer_name
        )
    ;
	
    INSERT INTO [TABLEOWNER].[h_customer]
      ( hk_h_customer
      , customer_name
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_customer_traders_north.hk_h_customer AS hk_h_customer 
           , stage_customer_traders_north.customer_name AS customer_name 
           , stage_customer_traders_north.dss_record_source AS dss_record_source 
           , stage_customer_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_customer_traders_north] stage_customer_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_customer] h_customer
        WHERE  stage_customer_traders_north.customer_name = h_customer.customer_name
        )
    ;	