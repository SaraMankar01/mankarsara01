      INSERT INTO [TABLEOWNER].[stage_employee_traders_north]
      ( hk_h_employee
      , employee_id
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
      , extension
      , hiredate
      , dss_change_hash_employee_gdpr_traders_north
      , dss_change_hash_employee_hroc_traders_north
      , dss_change_hash_employee_lroc_traders_north
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_employees_traders_north.employeeid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_employee 
           , load_employees_traders_north.employeeid AS employee_id 
           , load_employees_traders_north.country AS country 
           , load_employees_traders_north.lastname AS lastname 
           , load_employees_traders_north.firstname AS firstname 
           , load_employees_traders_north.title AS title 
           , load_employees_traders_north.titleofcourtesy AS titleofcourtesy 
           , load_employees_traders_north.birthdate AS birthdate 
           , load_employees_traders_north.address AS address 
           , load_employees_traders_north.city AS city 
           , load_employees_traders_north.region AS region 
           , load_employees_traders_north.postalcode AS postalcode 
           , load_employees_traders_north.homephone AS homephone 
           , load_employees_traders_north.reportsto AS reportsto 
           , load_employees_traders_north.extension AS extension 
           , load_employees_traders_north.hiredate AS hiredate 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_employees_traders_north.country AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_north.lastname AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_north.firstname AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_north.title AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_north.titleofcourtesy AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_north.birthdate AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_north.address AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_north.city AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_north.region AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_north.postalcode AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_north.homephone AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_north.reportsto AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_employee_gdpr_traders_north 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_employees_traders_north.extension AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_employee_hroc_traders_north 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_employees_traders_north.hiredate AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_employee_lroc_traders_north 
           , load_employees_traders_north.dss_record_source AS dss_record_source 
           , load_employees_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_employees_traders_north] load_employees_traders_north
      ;