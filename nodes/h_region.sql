    INSERT INTO [TABLEOWNER].[h_region]
      ( hk_h_region
      , region_id
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_region_traders_south.hk_h_region AS hk_h_region 
           , stage_region_traders_south.region_id AS region_id 
           , stage_region_traders_south.dss_record_source AS dss_record_source 
           , stage_region_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_region_traders_south] stage_region_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_region] h_region
        WHERE  stage_region_traders_south.region_id = h_region.region_id
        )
    ;
	
    INSERT INTO [TABLEOWNER].[h_region]
      ( hk_h_region
      , region_id
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_region_traders_north.hk_h_region AS hk_h_region 
           , stage_region_traders_north.region_id AS region_id 
           , stage_region_traders_north.dss_record_source AS dss_record_source 
           , stage_region_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_region_traders_north] stage_region_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_region] h_region
        WHERE  stage_region_traders_north.region_id = h_region.region_id
        )
    ;	