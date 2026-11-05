    INSERT INTO [TABLEOWNER].[s_order_lroc_traders_north]
      ( hk_h_order
      , customerid
      , employeeid
      , shipvia
      , dss_change_hash
      , dss_record_source
      , dss_load_date
      , dss_start_date
      , dss_version
      , dss_create_time)
    SELECT DISTINCT stage_order_traders_north.hk_h_order AS hk_h_order 
           , stage_order_traders_north.customerid AS customerid 
           , stage_order_traders_north.employeeid AS employeeid 
           , stage_order_traders_north.shipvia AS shipvia 
           , stage_order_traders_north.dss_change_hash_order_lroc_traders_north AS dss_change_hash 
           , stage_order_traders_north.dss_record_source AS dss_record_source 
           , stage_order_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_start_date 
           , ISNULL(current_rows.dss_version,0) + 1 AS dss_version 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_order_traders_north] stage_order_traders_north
    LEFT OUTER JOIN (
            SELECT s_order_lroc_traders_north.hk_h_order
                 , MAX(s_order_lroc_traders_north.dss_start_date) AS dss_start_date
                 , MAX(s_order_lroc_traders_north.dss_version) AS dss_version
            FROM   [TABLEOWNER].[s_order_lroc_traders_north] s_order_lroc_traders_north
            GROUP BY s_order_lroc_traders_north.hk_h_order
            ) AS current_rows
      ON  stage_order_traders_north.hk_h_order = current_rows.hk_h_order
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[s_order_lroc_traders_north] s_order_lroc_traders_north
        WHERE  stage_order_traders_north.hk_h_order = s_order_lroc_traders_north.hk_h_order
        AND    stage_order_traders_north.dss_change_hash_order_lroc_traders_north = s_order_lroc_traders_north.dss_change_hash
        AND    current_rows.dss_start_date = s_order_lroc_traders_north.dss_start_date
        )
    ;