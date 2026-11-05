    INSERT INTO [TABLEOWNER].[s_customer_lroc_traders_south]
      ( hk_h_customer
      , customerid
      , dss_change_hash
      , dss_record_source
      , dss_load_date
      , dss_start_date
      , dss_version
      , dss_create_time)
    SELECT DISTINCT stage_customer_traders_south.hk_h_customer AS hk_h_customer 
           , stage_customer_traders_south.customerid AS customerid 
           , stage_customer_traders_south.dss_change_hash_customer_lroc_traders_south AS dss_change_hash 
           , stage_customer_traders_south.dss_record_source AS dss_record_source 
           , stage_customer_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_start_date 
           , ISNULL(current_rows.dss_version,0) + 1 AS dss_version 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_customer_traders_south] stage_customer_traders_south
    LEFT OUTER JOIN (
            SELECT s_customer_lroc_traders_south.hk_h_customer
                 , MAX(s_customer_lroc_traders_south.dss_start_date) AS dss_start_date
                 , MAX(s_customer_lroc_traders_south.dss_version) AS dss_version
            FROM   [TABLEOWNER].[s_customer_lroc_traders_south] s_customer_lroc_traders_south
            GROUP BY s_customer_lroc_traders_south.hk_h_customer
            ) AS current_rows
      ON  stage_customer_traders_south.hk_h_customer = current_rows.hk_h_customer
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[s_customer_lroc_traders_south] s_customer_lroc_traders_south
        WHERE  stage_customer_traders_south.hk_h_customer = s_customer_lroc_traders_south.hk_h_customer
        AND    stage_customer_traders_south.dss_change_hash_customer_lroc_traders_south = s_customer_lroc_traders_south.dss_change_hash
        AND    current_rows.dss_start_date = s_customer_lroc_traders_south.dss_start_date
        )
    ;