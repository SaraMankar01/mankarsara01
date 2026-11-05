    INSERT INTO [TABLEOWNER].[s_order_mroc_traders_south]
      ( hk_h_order
      , requireddate
      , shippeddate
      , shipname
      , shipaddress
      , shipcity
      , shipregion
      , shippostalcode
      , shipcountry
      , dss_change_hash
      , dss_record_source
      , dss_load_date
      , dss_start_date
      , dss_version
      , dss_create_time)
    SELECT DISTINCT stage_order_traders_south.hk_h_order AS hk_h_order 
           , stage_order_traders_south.requireddate AS requireddate 
           , stage_order_traders_south.shippeddate AS shippeddate 
           , stage_order_traders_south.shipname AS shipname 
           , stage_order_traders_south.shipaddress AS shipaddress 
           , stage_order_traders_south.shipcity AS shipcity 
           , stage_order_traders_south.shipregion AS shipregion 
           , stage_order_traders_south.shippostalcode AS shippostalcode 
           , stage_order_traders_south.shipcountry AS shipcountry 
           , stage_order_traders_south.dss_change_hash_order_mroc_traders_south AS dss_change_hash 
           , stage_order_traders_south.dss_record_source AS dss_record_source 
           , stage_order_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_start_date 
           , ISNULL(current_rows.dss_version,0) + 1 AS dss_version 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_order_traders_south] stage_order_traders_south
    LEFT OUTER JOIN (
            SELECT s_order_mroc_traders_south.hk_h_order
                 , MAX(s_order_mroc_traders_south.dss_start_date) AS dss_start_date
                 , MAX(s_order_mroc_traders_south.dss_version) AS dss_version
            FROM   [TABLEOWNER].[s_order_mroc_traders_south] s_order_mroc_traders_south
            GROUP BY s_order_mroc_traders_south.hk_h_order
            ) AS current_rows
      ON  stage_order_traders_south.hk_h_order = current_rows.hk_h_order
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[s_order_mroc_traders_south] s_order_mroc_traders_south
        WHERE  stage_order_traders_south.hk_h_order = s_order_mroc_traders_south.hk_h_order
        AND    stage_order_traders_south.dss_change_hash_order_mroc_traders_south = s_order_mroc_traders_south.dss_change_hash
        AND    current_rows.dss_start_date = s_order_mroc_traders_south.dss_start_date
        )
    ;