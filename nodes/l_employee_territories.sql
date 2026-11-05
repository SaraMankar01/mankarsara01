    INSERT INTO [TABLEOWNER].[l_employee_territories]
      ( hk_l_employee_territories
      , hk_h_employee
      , hk_h_territory
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_employee_territories_traders_south.hk_l_employee_territories AS hk_l_employee_territories 
           , stage_employee_territories_traders_south.hk_h_employee AS hk_h_employee 
           , stage_employee_territories_traders_south.hk_h_territory AS hk_h_territory 
           , stage_employee_territories_traders_south.dss_record_source AS dss_record_source 
           , stage_employee_territories_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_employee_territories_traders_south] stage_employee_territories_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[l_employee_territories] l_employee_territories
        WHERE  stage_employee_territories_traders_south.hk_h_employee = l_employee_territories.hk_h_employee
        AND    stage_employee_territories_traders_south.hk_h_territory = l_employee_territories.hk_h_territory
        )
    ;


    INSERT INTO [TABLEOWNER].[l_employee_territories]
      ( hk_l_employee_territories
      , hk_h_employee
      , hk_h_territory
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_employee_territories_traders_north.hk_l_employee_territories AS hk_l_employee_territories 
           , stage_employee_territories_traders_north.hk_h_employee AS hk_h_employee 
           , stage_employee_territories_traders_north.hk_h_territory AS hk_h_territory 
           , stage_employee_territories_traders_north.dss_record_source AS dss_record_source 
           , stage_employee_territories_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_employee_territories_traders_north] stage_employee_territories_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[l_employee_territories] l_employee_territories
        WHERE  stage_employee_territories_traders_north.hk_h_employee = l_employee_territories.hk_h_employee
        AND    stage_employee_territories_traders_north.hk_h_territory = l_employee_territories.hk_h_territory
        )
    ;