    INSERT INTO [TABLEOWNER].[l_territory_regions]
      ( hk_l_territory_regions
      , hk_h_region
      , hk_h_territory
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_territory_regions_traders_south.hk_l_territory_regions AS hk_l_territory_regions 
           , stage_territory_regions_traders_south.hk_h_region AS hk_h_region 
           , stage_territory_regions_traders_south.hk_h_territory AS hk_h_territory 
           , stage_territory_regions_traders_south.dss_record_source AS dss_record_source 
           , stage_territory_regions_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_territory_regions_traders_south] stage_territory_regions_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[l_territory_regions] l_territory_regions
        WHERE  stage_territory_regions_traders_south.hk_h_region = l_territory_regions.hk_h_region
        AND    stage_territory_regions_traders_south.hk_h_territory = l_territory_regions.hk_h_territory
        )
    ;
	
    INSERT INTO [TABLEOWNER].[l_territory_regions]
      ( hk_l_territory_regions
      , hk_h_region
      , hk_h_territory
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_territory_regions_traders_north.hk_l_territory_regions AS hk_l_territory_regions 
           , stage_territory_regions_traders_north.hk_h_region AS hk_h_region 
           , stage_territory_regions_traders_north.hk_h_territory AS hk_h_territory 
           , stage_territory_regions_traders_north.dss_record_source AS dss_record_source 
           , stage_territory_regions_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_territory_regions_traders_north] stage_territory_regions_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[l_territory_regions] l_territory_regions
        WHERE  stage_territory_regions_traders_north.hk_h_region = l_territory_regions.hk_h_region
        AND    stage_territory_regions_traders_north.hk_h_territory = l_territory_regions.hk_h_territory
        )
    ;	