    INSERT INTO [TABLEOWNER].[l_products_categories_suppliers]
      ( hk_l_products_categories_suppliers
      , hk_h_category
      , hk_h_product
      , hk_h_supplier
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_products_categories_suppliers_traders_south.hk_l_products_categories_suppliers AS hk_l_products_categories_suppliers 
           , stage_products_categories_suppliers_traders_south.hk_h_category AS hk_h_category 
           , stage_products_categories_suppliers_traders_south.hk_h_product AS hk_h_product 
           , stage_products_categories_suppliers_traders_south.hk_h_supplier AS hk_h_supplier 
           , stage_products_categories_suppliers_traders_south.dss_record_source AS dss_record_source 
           , stage_products_categories_suppliers_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_products_categories_suppliers_traders_south] stage_products_categories_suppliers_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[l_products_categories_suppliers] l_products_categories_suppliers
        WHERE  stage_products_categories_suppliers_traders_south.hk_h_category = l_products_categories_suppliers.hk_h_category
        AND    stage_products_categories_suppliers_traders_south.hk_h_product = l_products_categories_suppliers.hk_h_product
        AND    stage_products_categories_suppliers_traders_south.hk_h_supplier = l_products_categories_suppliers.hk_h_supplier
        )
    ;

    INSERT INTO [TABLEOWNER].[l_products_categories_suppliers]
      ( hk_l_products_categories_suppliers
      , hk_h_category
      , hk_h_product
      , hk_h_supplier
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_products_categories_suppliers_traders_north.hk_l_products_categories_suppliers AS hk_l_products_categories_suppliers 
           , stage_products_categories_suppliers_traders_north.hk_h_category AS hk_h_category 
           , stage_products_categories_suppliers_traders_north.hk_h_product AS hk_h_product 
           , stage_products_categories_suppliers_traders_north.hk_h_supplier AS hk_h_supplier 
           , stage_products_categories_suppliers_traders_north.dss_record_source AS dss_record_source 
           , stage_products_categories_suppliers_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_products_categories_suppliers_traders_north] stage_products_categories_suppliers_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[l_products_categories_suppliers] l_products_categories_suppliers
        WHERE  stage_products_categories_suppliers_traders_north.hk_h_category = l_products_categories_suppliers.hk_h_category
        AND    stage_products_categories_suppliers_traders_north.hk_h_product = l_products_categories_suppliers.hk_h_product
        AND    stage_products_categories_suppliers_traders_north.hk_h_supplier = l_products_categories_suppliers.hk_h_supplier
        )
    ;	