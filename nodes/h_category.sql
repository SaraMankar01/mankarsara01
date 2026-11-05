    INSERT INTO [TABLEOWNER].[h_category]
      ( hk_h_category
      , category_name
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_category_traders_south.hk_h_category AS hk_h_category 
           , stage_category_traders_south.category_name AS category_name 
           , stage_category_traders_south.dss_record_source AS dss_record_source 
           , stage_category_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_category_traders_south] stage_category_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_category] h_category
        WHERE  stage_category_traders_south.category_name = h_category.category_name
        )
    ;
	
    INSERT INTO [TABLEOWNER].[h_category]
      ( hk_h_category
      , category_name
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_category_traders_north.hk_h_category AS hk_h_category 
           , stage_category_traders_north.category_name AS category_name 
           , stage_category_traders_north.dss_record_source AS dss_record_source 
           , stage_category_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_category_traders_north] stage_category_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_category] h_category
        WHERE  stage_category_traders_north.category_name = h_category.category_name
        )
    ;