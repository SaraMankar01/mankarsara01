    INSERT INTO [TABLEOWNER].[s_supplier_lroc_traders_south]
      ( hk_h_supplier
      , country
      , supplierid
      , address
      , city
      , region
      , postalcode
      , dss_change_hash
      , dss_record_source
      , dss_load_date
      , dss_start_date
      , dss_version
      , dss_create_time)
    SELECT DISTINCT stage_supplier_traders_south.hk_h_supplier AS hk_h_supplier 
           , stage_supplier_traders_south.country AS country 
           , stage_supplier_traders_south.supplierid AS supplierid 
           , stage_supplier_traders_south.address AS address 
           , stage_supplier_traders_south.city AS city 
           , stage_supplier_traders_south.region AS region 
           , stage_supplier_traders_south.postalcode AS postalcode 
           , stage_supplier_traders_south.dss_change_hash_supplier_lroc_traders_south AS dss_change_hash 
           , stage_supplier_traders_south.dss_record_source AS dss_record_source 
           , stage_supplier_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_start_date 
           , ISNULL(current_rows.dss_version,0) + 1 AS dss_version 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_supplier_traders_south] stage_supplier_traders_south
    LEFT OUTER JOIN (
            SELECT s_supplier_lroc_traders_south.hk_h_supplier
                 , MAX(s_supplier_lroc_traders_south.dss_start_date) AS dss_start_date
                 , MAX(s_supplier_lroc_traders_south.dss_version) AS dss_version
            FROM   [TABLEOWNER].[s_supplier_lroc_traders_south] s_supplier_lroc_traders_south
            GROUP BY s_supplier_lroc_traders_south.hk_h_supplier
            ) AS current_rows
      ON  stage_supplier_traders_south.hk_h_supplier = current_rows.hk_h_supplier
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[s_supplier_lroc_traders_south] s_supplier_lroc_traders_south
        WHERE  stage_supplier_traders_south.hk_h_supplier = s_supplier_lroc_traders_south.hk_h_supplier
        AND    stage_supplier_traders_south.dss_change_hash_supplier_lroc_traders_south = s_supplier_lroc_traders_south.dss_change_hash
        AND    current_rows.dss_start_date = s_supplier_lroc_traders_south.dss_start_date
        )
    ;