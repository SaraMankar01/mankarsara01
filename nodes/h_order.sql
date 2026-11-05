    INSERT INTO [TABLEOWNER].[h_order]
      ( hk_h_order
      , order_number
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_order_traders_south.hk_h_order AS hk_h_order 
           , stage_order_traders_south.order_number AS order_number 
           , stage_order_traders_south.dss_record_source AS dss_record_source 
           , stage_order_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_order_traders_south] stage_order_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_order] h_order
        WHERE  stage_order_traders_south.order_number = h_order.order_number
        )
    ;
	
    INSERT INTO [TABLEOWNER].[h_order]
      ( hk_h_order
      , order_number
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_order_traders_north.hk_h_order AS hk_h_order 
           , stage_order_traders_north.order_number AS order_number 
           , stage_order_traders_north.dss_record_source AS dss_record_source 
           , stage_order_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_order_traders_north] stage_order_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_order] h_order
        WHERE  stage_order_traders_north.order_number = h_order.order_number
        )
    ;	