    INSERT INTO [TABLEOWNER].[s_territory_lroc_traders_north]
      ( hk_h_territory
      , territorydescription
      , dss_change_hash
      , dss_record_source
      , dss_load_date
      , dss_start_date
      , dss_version
      , dss_create_time)
    SELECT DISTINCT stage_territory_traders_north.hk_h_territory AS hk_h_territory 
           , stage_territory_traders_north.territorydescription AS territorydescription 
           , stage_territory_traders_north.dss_change_hash_territory_lroc_traders_north AS dss_change_hash 
           , stage_territory_traders_north.dss_record_source AS dss_record_source 
           , stage_territory_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_start_date 
           , ISNULL(current_rows.dss_version,0) + 1 AS dss_version 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_territory_traders_north] stage_territory_traders_north
    LEFT OUTER JOIN (
            SELECT s_territory_lroc_traders_north.hk_h_territory
                 , MAX(s_territory_lroc_traders_north.dss_start_date) AS dss_start_date
                 , MAX(s_territory_lroc_traders_north.dss_version) AS dss_version
            FROM   [TABLEOWNER].[s_territory_lroc_traders_north] s_territory_lroc_traders_north
            GROUP BY s_territory_lroc_traders_north.hk_h_territory
            ) AS current_rows
      ON  stage_territory_traders_north.hk_h_territory = current_rows.hk_h_territory
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[s_territory_lroc_traders_north] s_territory_lroc_traders_north
        WHERE  stage_territory_traders_north.hk_h_territory = s_territory_lroc_traders_north.hk_h_territory
        AND    stage_territory_traders_north.dss_change_hash_territory_lroc_traders_north = s_territory_lroc_traders_north.dss_change_hash
        AND    current_rows.dss_start_date = s_territory_lroc_traders_north.dss_start_date
        )
    ;