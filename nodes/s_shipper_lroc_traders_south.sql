    INSERT INTO [TABLEOWNER].[s_shipper_lroc_traders_south]
      ( hk_h_shipper
      , shipperid
      , phone
      , dss_change_hash
      , dss_record_source
      , dss_load_date
      , dss_start_date
      , dss_version
      , dss_create_time)
    SELECT DISTINCT stage_shipper_traders_south.hk_h_shipper AS hk_h_shipper 
           , stage_shipper_traders_south.shipperid AS shipperid 
           , stage_shipper_traders_south.phone AS phone 
           , stage_shipper_traders_south.dss_change_hash_shipper_lroc_traders_south AS dss_change_hash 
           , stage_shipper_traders_south.dss_record_source AS dss_record_source 
           , stage_shipper_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_start_date 
           , ISNULL(current_rows.dss_version,0) + 1 AS dss_version 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_shipper_traders_south] stage_shipper_traders_south
    LEFT OUTER JOIN (
            SELECT s_shipper_lroc_traders_south.hk_h_shipper
                 , MAX(s_shipper_lroc_traders_south.dss_start_date) AS dss_start_date
                 , MAX(s_shipper_lroc_traders_south.dss_version) AS dss_version
            FROM   [TABLEOWNER].[s_shipper_lroc_traders_south] s_shipper_lroc_traders_south
            GROUP BY s_shipper_lroc_traders_south.hk_h_shipper
            ) AS current_rows
      ON  stage_shipper_traders_south.hk_h_shipper = current_rows.hk_h_shipper
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[s_shipper_lroc_traders_south] s_shipper_lroc_traders_south
        WHERE  stage_shipper_traders_south.hk_h_shipper = s_shipper_lroc_traders_south.hk_h_shipper
        AND    stage_shipper_traders_south.dss_change_hash_shipper_lroc_traders_south = s_shipper_lroc_traders_south.dss_change_hash
        AND    current_rows.dss_start_date = s_shipper_lroc_traders_south.dss_start_date
        )
    ;