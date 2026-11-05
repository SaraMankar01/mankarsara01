    INSERT INTO [TABLEOWNER].[s_category_lroc_traders_north]
      ( hk_h_category
      , categoryid
      , description
      , dss_change_hash
      , dss_record_source
      , dss_load_date
      , dss_start_date
      , dss_version
      , dss_create_time)
    SELECT DISTINCT stage_category_traders_north.hk_h_category AS hk_h_category 
           , stage_category_traders_north.categoryid AS categoryid 
           , stage_category_traders_north.description AS description 
           , stage_category_traders_north.dss_change_hash_category_lroc_traders_north AS dss_change_hash 
           , stage_category_traders_north.dss_record_source AS dss_record_source 
           , stage_category_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_start_date 
           , ISNULL(current_rows.dss_version,0) + 1 AS dss_version 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_category_traders_north] stage_category_traders_north
    LEFT OUTER JOIN (
            SELECT s_category_lroc_traders_north.hk_h_category
                 , MAX(s_category_lroc_traders_north.dss_start_date) AS dss_start_date
                 , MAX(s_category_lroc_traders_north.dss_version) AS dss_version
            FROM   [TABLEOWNER].[s_category_lroc_traders_north] s_category_lroc_traders_north
            GROUP BY s_category_lroc_traders_north.hk_h_category
            ) AS current_rows
      ON  stage_category_traders_north.hk_h_category = current_rows.hk_h_category
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[s_category_lroc_traders_north] s_category_lroc_traders_north
        WHERE  stage_category_traders_north.hk_h_category = s_category_lroc_traders_north.hk_h_category
        AND    stage_category_traders_north.dss_change_hash_category_lroc_traders_north = s_category_lroc_traders_north.dss_change_hash
        AND    current_rows.dss_start_date = s_category_lroc_traders_north.dss_start_date
        )
    ;