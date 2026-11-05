    INSERT INTO [TABLEOWNER].[s_region_lroc_traders_south]
      ( hk_h_region
      , regiondescription
      , dss_change_hash
      , dss_record_source
      , dss_load_date
      , dss_start_date
      , dss_version
      , dss_create_time)
    SELECT DISTINCT stage_region_traders_south.hk_h_region AS hk_h_region 
           , stage_region_traders_south.regiondescription AS regiondescription 
           , stage_region_traders_south.dss_change_hash_region_lroc_traders_south AS dss_change_hash 
           , stage_region_traders_south.dss_record_source AS dss_record_source 
           , stage_region_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_start_date 
           , ISNULL(current_rows.dss_version,0) + 1 AS dss_version 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_region_traders_south] stage_region_traders_south
    LEFT OUTER JOIN (
            SELECT s_region_lroc_traders_south.hk_h_region
                 , MAX(s_region_lroc_traders_south.dss_start_date) AS dss_start_date
                 , MAX(s_region_lroc_traders_south.dss_version) AS dss_version
            FROM   [TABLEOWNER].[s_region_lroc_traders_south] s_region_lroc_traders_south
            GROUP BY s_region_lroc_traders_south.hk_h_region
            ) AS current_rows
      ON  stage_region_traders_south.hk_h_region = current_rows.hk_h_region
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[s_region_lroc_traders_south] s_region_lroc_traders_south
        WHERE  stage_region_traders_south.hk_h_region = s_region_lroc_traders_south.hk_h_region
        AND    stage_region_traders_south.dss_change_hash_region_lroc_traders_south = s_region_lroc_traders_south.dss_change_hash
        AND    current_rows.dss_start_date = s_region_lroc_traders_south.dss_start_date
        )
    ;