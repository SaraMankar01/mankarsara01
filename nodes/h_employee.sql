    INSERT INTO [TABLEOWNER].[h_employee]
      ( hk_h_employee
      , employee_id
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_employee_traders_south.hk_h_employee AS hk_h_employee 
           , stage_employee_traders_south.employee_id AS employee_id 
           , stage_employee_traders_south.dss_record_source AS dss_record_source 
           , stage_employee_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_employee_traders_south] stage_employee_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_employee] h_employee
        WHERE  stage_employee_traders_south.employee_id = h_employee.employee_id
        )
    ;
	
    INSERT INTO [TABLEOWNER].[h_employee]
      ( hk_h_employee
      , employee_id
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_employee_traders_north.hk_h_employee AS hk_h_employee 
           , stage_employee_traders_north.employee_id AS employee_id 
           , stage_employee_traders_north.dss_record_source AS dss_record_source 
           , stage_employee_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_employee_traders_north] stage_employee_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[h_employee] h_employee
        WHERE  stage_employee_traders_north.employee_id = h_employee.employee_id
        )
    ;
	