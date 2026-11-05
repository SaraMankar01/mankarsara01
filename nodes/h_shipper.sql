    INSERT INTO [TABLEOWNER].[h_shipper]
      ( hk_h_shipper
      , shipper_name
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_shipper_traders_south.hk_h_shipper AS hk_h_shipper 
           , stage_shipper_traders_south.shipper_name AS shipper_name 
           , stage_shipper_traders_south.dss_record_source AS dss_record_source 
           , stage_shipper_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_shipper_traders_south] stage_shipper_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_shipper] h_shipper
        WHERE  stage_shipper_traders_south.shipper_name = h_shipper.shipper_name
        )
    ;
	
    INSERT INTO [TABLEOWNER].[h_shipper]
      ( hk_h_shipper
      , shipper_name
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_shipper_traders_north.hk_h_shipper AS hk_h_shipper 
           , stage_shipper_traders_north.shipper_name AS shipper_name 
           , stage_shipper_traders_north.dss_record_source AS dss_record_source 
           , stage_shipper_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_shipper_traders_north] stage_shipper_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_shipper] h_shipper
        WHERE  stage_shipper_traders_north.shipper_name = h_shipper.shipper_name
        )
    ;	