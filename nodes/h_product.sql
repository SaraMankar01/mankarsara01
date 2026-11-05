    INSERT INTO [TABLEOWNER].[h_product]
      ( hk_h_product
      , product_name
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_product_traders_south.hk_h_product AS hk_h_product 
           , stage_product_traders_south.product_name AS product_name 
           , stage_product_traders_south.dss_record_source AS dss_record_source 
           , stage_product_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_product_traders_south] stage_product_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_product] h_product
        WHERE  stage_product_traders_south.product_name = h_product.product_name
        )
    ;
	
    INSERT INTO [TABLEOWNER].[h_product]
      ( hk_h_product
      , product_name
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_product_traders_north.hk_h_product AS hk_h_product 
           , stage_product_traders_north.product_name AS product_name 
           , stage_product_traders_north.dss_record_source AS dss_record_source 
           , stage_product_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_product_traders_north] stage_product_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_product] h_product
        WHERE  stage_product_traders_north.product_name = h_product.product_name
        )
    ;	