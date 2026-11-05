    INSERT INTO [TABLEOWNER].[h_territory]
      ( hk_h_territory
      , territory_id
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_territory_traders_south.hk_h_territory AS hk_h_territory 
           , stage_territory_traders_south.territory_id AS territory_id 
           , stage_territory_traders_south.dss_record_source AS dss_record_source 
           , stage_territory_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_territory_traders_south] stage_territory_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_territory] h_territory
        WHERE  stage_territory_traders_south.territory_id = h_territory.territory_id
        )
    ;
	
    INSERT INTO [TABLEOWNER].[h_territory]
      ( hk_h_territory
      , territory_id
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_territory_traders_north.hk_h_territory AS hk_h_territory 
           , stage_territory_traders_north.territory_id AS territory_id 
           , stage_territory_traders_north.dss_record_source AS dss_record_source 
           , stage_territory_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_territory_traders_north] stage_territory_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_territory] h_territory
        WHERE  stage_territory_traders_north.territory_id = h_territory.territory_id
        )
    ;	