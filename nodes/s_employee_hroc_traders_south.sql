    INSERT INTO [TABLEOWNER].[s_employee_hroc_traders_south]
      ( hk_h_employee
      , extension
      , dss_change_hash
      , dss_record_source
      , dss_load_date
      , dss_start_date
      , dss_version
      , dss_create_time)
    SELECT DISTINCT stage_employee_traders_south.hk_h_employee AS hk_h_employee 
           , stage_employee_traders_south.extension AS extension 
           , stage_employee_traders_south.dss_change_hash_employee_hroc_traders_south AS dss_change_hash 
           , stage_employee_traders_south.dss_record_source AS dss_record_source 
           , stage_employee_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_start_date 
           , ISNULL(current_rows.dss_version,0) + 1 AS dss_version 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_employee_traders_south] stage_employee_traders_south
    LEFT OUTER JOIN (
            SELECT s_employee_hroc_traders_south.hk_h_employee
                 , MAX(s_employee_hroc_traders_south.dss_start_date) AS dss_start_date
                 , MAX(s_employee_hroc_traders_south.dss_version) AS dss_version
            FROM   [TABLEOWNER].[s_employee_hroc_traders_south] s_employee_hroc_traders_south
            GROUP BY s_employee_hroc_traders_south.hk_h_employee
            ) AS current_rows
      ON  stage_employee_traders_south.hk_h_employee = current_rows.hk_h_employee
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[s_employee_hroc_traders_south] s_employee_hroc_traders_south
        WHERE  stage_employee_traders_south.hk_h_employee = s_employee_hroc_traders_south.hk_h_employee
        AND    stage_employee_traders_south.dss_change_hash_employee_hroc_traders_south = s_employee_hroc_traders_south.dss_change_hash
        AND    current_rows.dss_start_date = s_employee_hroc_traders_south.dss_start_date
        )
    ;