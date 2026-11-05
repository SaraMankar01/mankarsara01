    INSERT INTO [TABLEOWNER].[s_product_mroc_traders_south]
      ( hk_h_product
      , supplierid
      , categoryid
      , quantityperunit
      , unitprice
      , dss_change_hash
      , dss_record_source
      , dss_load_date
      , dss_start_date
      , dss_version
      , dss_create_time)
    SELECT DISTINCT stage_product_traders_south.hk_h_product AS hk_h_product 
           , stage_product_traders_south.supplierid AS supplierid 
           , stage_product_traders_south.categoryid AS categoryid 
           , stage_product_traders_south.quantityperunit AS quantityperunit 
           , stage_product_traders_south.unitprice AS unitprice 
           , stage_product_traders_south.dss_change_hash_product_mroc_traders_south AS dss_change_hash 
           , stage_product_traders_south.dss_record_source AS dss_record_source 
           , stage_product_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_start_date 
           , ISNULL(current_rows.dss_version,0) + 1 AS dss_version 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_product_traders_south] stage_product_traders_south
    LEFT OUTER JOIN (
            SELECT s_product_mroc_traders_south.hk_h_product
                 , MAX(s_product_mroc_traders_south.dss_start_date) AS dss_start_date
                 , MAX(s_product_mroc_traders_south.dss_version) AS dss_version
            FROM   [TABLEOWNER].[s_product_mroc_traders_south] s_product_mroc_traders_south
            GROUP BY s_product_mroc_traders_south.hk_h_product
            ) AS current_rows
      ON  stage_product_traders_south.hk_h_product = current_rows.hk_h_product
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[s_product_mroc_traders_south] s_product_mroc_traders_south
        WHERE  stage_product_traders_south.hk_h_product = s_product_mroc_traders_south.hk_h_product
        AND    stage_product_traders_south.dss_change_hash_product_mroc_traders_south = s_product_mroc_traders_south.dss_change_hash
        AND    current_rows.dss_start_date = s_product_mroc_traders_south.dss_start_date
        )
    ;