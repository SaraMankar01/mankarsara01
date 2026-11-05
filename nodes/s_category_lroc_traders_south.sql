    INSERT INTO [TABLEOWNER].[s_category_lroc_traders_south]
      ( hk_h_category
      , categoryid
      , description
      , dss_change_hash
      , dss_record_source
      , dss_load_date
      , dss_start_date
      , dss_version
      , dss_create_time)
    SELECT DISTINCT stage_category_traders_south.hk_h_category AS hk_h_category 
           , stage_category_traders_south.categoryid AS categoryid 
           , stage_category_traders_south.description AS description 
           , stage_category_traders_south.dss_change_hash_category_lroc_traders_south AS dss_change_hash 
           , stage_category_traders_south.dss_record_source AS dss_record_source 
           , stage_category_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_start_date 
           , ISNULL(current_rows.dss_version,0) + 1 AS dss_version 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_category_traders_south] stage_category_traders_south
    LEFT OUTER JOIN (
            SELECT s_category_lroc_traders_south.hk_h_category
                 , MAX(s_category_lroc_traders_south.dss_start_date) AS dss_start_date
                 , MAX(s_category_lroc_traders_south.dss_version) AS dss_version
            FROM   [TABLEOWNER].[s_category_lroc_traders_south] s_category_lroc_traders_south
            GROUP BY s_category_lroc_traders_south.hk_h_category
            ) AS current_rows
      ON  stage_category_traders_south.hk_h_category = current_rows.hk_h_category
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[s_category_lroc_traders_south] s_category_lroc_traders_south
        WHERE  stage_category_traders_south.hk_h_category = s_category_lroc_traders_south.hk_h_category
        AND    stage_category_traders_south.dss_change_hash_category_lroc_traders_south = s_category_lroc_traders_south.dss_change_hash
        AND    current_rows.dss_start_date = s_category_lroc_traders_south.dss_start_date
        )
    ;