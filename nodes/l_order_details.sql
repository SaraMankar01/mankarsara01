    INSERT INTO [TABLEOWNER].[l_order_details]
      ( hk_l_order_details
      , hk_h_order
      , hk_h_product
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_order_details_traders_south.hk_l_order_details AS hk_l_order_details 
           , stage_order_details_traders_south.hk_h_order AS hk_h_order 
           , stage_order_details_traders_south.hk_h_product AS hk_h_product 
           , stage_order_details_traders_south.dss_record_source AS dss_record_source 
           , stage_order_details_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_order_details_traders_south] stage_order_details_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[l_order_details] l_order_details
        WHERE  stage_order_details_traders_south.hk_h_order = l_order_details.hk_h_order
        AND    stage_order_details_traders_south.hk_h_product = l_order_details.hk_h_product
        )
    ;
	
    INSERT INTO [TABLEOWNER].[l_order_details]
      ( hk_l_order_details
      , hk_h_order
      , hk_h_product
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_order_details_traders_north.hk_l_order_details AS hk_l_order_details 
           , stage_order_details_traders_north.hk_h_order AS hk_h_order 
           , stage_order_details_traders_north.hk_h_product AS hk_h_product 
           , stage_order_details_traders_north.dss_record_source AS dss_record_source 
           , stage_order_details_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_order_details_traders_north] stage_order_details_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[l_order_details] l_order_details
        WHERE  stage_order_details_traders_north.hk_h_order = l_order_details.hk_h_order
        AND    stage_order_details_traders_north.hk_h_product = l_order_details.hk_h_product
        )
    ;	