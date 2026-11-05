    INSERT INTO [TABLEOWNER].[h_supplier]
      ( hk_h_supplier
      , supplier_name
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_supplier_traders_south.hk_h_supplier AS hk_h_supplier 
           , stage_supplier_traders_south.supplier_name AS supplier_name 
           , stage_supplier_traders_south.dss_record_source AS dss_record_source 
           , stage_supplier_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_supplier_traders_south] stage_supplier_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_supplier] h_supplier
        WHERE  stage_supplier_traders_south.supplier_name = h_supplier.supplier_name
        )
    ;
	
    INSERT INTO [TABLEOWNER].[h_supplier]
      ( hk_h_supplier
      , supplier_name
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_supplier_traders_north.hk_h_supplier AS hk_h_supplier 
           , stage_supplier_traders_north.supplier_name AS supplier_name 
           , stage_supplier_traders_north.dss_record_source AS dss_record_source 
           , stage_supplier_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_supplier_traders_north] stage_supplier_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_supplier] h_supplier
        WHERE  stage_supplier_traders_north.supplier_name = h_supplier.supplier_name
        )
    ;	