      INSERT INTO [TABLEOWNER].[stage_employee_territories_traders_north]
      ( hk_l_employee_territories
      , hk_h_employee
      , hk_h_territory
      , employee_id
      , territory_id
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_employeeterritories_traders_north.employeeid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employeeterritories_traders_north.territoryid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_l_employee_territories 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_employeeterritories_traders_north.employeeid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_employee 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_employeeterritories_traders_north.territoryid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_territory 
           , load_employeeterritories_traders_north.employeeid AS employee_id 
           , load_employeeterritories_traders_north.territoryid AS territory_id 
           , load_employeeterritories_traders_north.dss_record_source AS dss_record_source 
           , load_employeeterritories_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_employeeterritories_traders_north] load_employeeterritories_traders_north
      ;