    INSERT INTO [TABLEOWNER].[s_employee_gdpr_traders_north]
      ( hk_h_employee
      , country
      , lastname
      , firstname
      , title
      , titleofcourtesy
      , birthdate
      , address
      , city
      , region
      , postalcode
      , homephone
      , reportsto
      , dss_change_hash
      , dss_record_source
      , dss_load_date
      , dss_start_date
      , dss_version
      , dss_create_time)
    SELECT DISTINCT stage_employee_traders_north.hk_h_employee AS hk_h_employee 
           , stage_employee_traders_north.country AS country 
           , stage_employee_traders_north.lastname AS lastname 
           , stage_employee_traders_north.firstname AS firstname 
           , stage_employee_traders_north.title AS title 
           , stage_employee_traders_north.titleofcourtesy AS titleofcourtesy 
           , stage_employee_traders_north.birthdate AS birthdate 
           , stage_employee_traders_north.address AS address 
           , stage_employee_traders_north.city AS city 
           , stage_employee_traders_north.region AS region 
           , stage_employee_traders_north.postalcode AS postalcode 
           , stage_employee_traders_north.homephone AS homephone 
           , stage_employee_traders_north.reportsto AS reportsto 
           , stage_employee_traders_north.dss_change_hash_employee_gdpr_traders_north AS dss_change_hash 
           , stage_employee_traders_north.dss_record_source AS dss_record_source 
           , stage_employee_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_start_date 
           , ISNULL(current_rows.dss_version,0) + 1 AS dss_version 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_employee_traders_north] stage_employee_traders_north
    LEFT OUTER JOIN (
            SELECT s_employee_gdpr_traders_north.hk_h_employee
                 , MAX(s_employee_gdpr_traders_north.dss_start_date) AS dss_start_date
                 , MAX(s_employee_gdpr_traders_north.dss_version) AS dss_version
            FROM   [TABLEOWNER].[s_employee_gdpr_traders_north] s_employee_gdpr_traders_north
            GROUP BY s_employee_gdpr_traders_north.hk_h_employee
            ) AS current_rows
      ON  stage_employee_traders_north.hk_h_employee = current_rows.hk_h_employee
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[s_employee_gdpr_traders_north] s_employee_gdpr_traders_north
        WHERE  stage_employee_traders_north.hk_h_employee = s_employee_gdpr_traders_north.hk_h_employee
        AND    stage_employee_traders_north.dss_change_hash_employee_gdpr_traders_north = s_employee_gdpr_traders_north.dss_change_hash
        AND    current_rows.dss_start_date = s_employee_gdpr_traders_north.dss_start_date
        )
    ;