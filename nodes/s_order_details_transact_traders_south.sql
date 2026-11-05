    INSERT INTO [TABLEOWNER].[s_order_details_transact_traders_south]
      ( hk_l_order_details
      , orderdate
      , unitprice
      , quantity
      , discount
      , dss_change_hash
      , dss_record_source
      , dss_load_date
      , dss_start_date
      , dss_version
      , dss_create_time)
    SELECT DISTINCT stage_order_details_traders_south.hk_l_order_details AS hk_l_order_details 
           , stage_order_details_traders_south.orderdate AS orderdate 
           , stage_order_details_traders_south.unitprice AS unitprice 
           , stage_order_details_traders_south.quantity AS quantity 
           , stage_order_details_traders_south.discount AS discount 
           , stage_order_details_traders_south.dss_change_hash_order_details_transact_traders_south AS dss_change_hash 
           , stage_order_details_traders_south.dss_record_source AS dss_record_source 
           , stage_order_details_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_start_date 
           , ISNULL(current_rows.dss_version,0) + 1 AS dss_version 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_order_details_traders_south] stage_order_details_traders_south
    LEFT OUTER JOIN (
            SELECT s_order_details_transact_traders_south.hk_l_order_details
                 , MAX(s_order_details_transact_traders_south.dss_start_date) AS dss_start_date
                 , MAX(s_order_details_transact_traders_south.dss_version) AS dss_version
            FROM   [TABLEOWNER].[s_order_details_transact_traders_south] s_order_details_transact_traders_south
            GROUP BY s_order_details_transact_traders_south.hk_l_order_details
            ) AS current_rows
      ON  stage_order_details_traders_south.hk_l_order_details = current_rows.hk_l_order_details
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[s_order_details_transact_traders_south] s_order_details_transact_traders_south
        WHERE  stage_order_details_traders_south.hk_l_order_details = s_order_details_transact_traders_south.hk_l_order_details
        AND    stage_order_details_traders_south.dss_change_hash_order_details_transact_traders_south = s_order_details_transact_traders_south.dss_change_hash
        AND    current_rows.dss_start_date = s_order_details_transact_traders_south.dss_start_date
        )
    ;