      INSERT INTO [TABLEOWNER].[stage_employee_traders_south]
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
      , dss_change_hash_employee_gdpr_traders_south
      , dss_change_hash_employee_hroc_traders_south
      , dss_change_hash_employee_lroc_traders_south
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_employees_traders_south.employeeid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_employee 
           , load_employees_traders_south.employeeid AS employee_id 
           , load_employees_traders_south.country AS country 
           , load_employees_traders_south.lastname AS lastname 
           , load_employees_traders_south.firstname AS firstname 
           , load_employees_traders_south.title AS title 
           , load_employees_traders_south.titleofcourtesy AS titleofcourtesy 
           , load_employees_traders_south.birthdate AS birthdate 
           , load_employees_traders_south.address AS address 
           , load_employees_traders_south.city AS city 
           , load_employees_traders_south.region AS region 
           , load_employees_traders_south.postalcode AS postalcode 
           , load_employees_traders_south.homephone AS homephone 
           , load_employees_traders_south.reportsto AS reportsto 
           , load_employees_traders_south.extension AS extension 
           , load_employees_traders_south.hiredate AS hiredate 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_employees_traders_south.country AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_south.lastname AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_south.firstname AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_south.title AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_south.titleofcourtesy AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_south.birthdate AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_south.address AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_south.city AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_south.region AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_south.postalcode AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_south.homephone AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_employees_traders_south.reportsto AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_employee_gdpr_traders_south 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_employees_traders_south.extension AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_employee_hroc_traders_south 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_employees_traders_south.hiredate AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_employee_lroc_traders_south 
           , load_employees_traders_south.dss_record_source AS dss_record_source 
           , load_employees_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_employees_traders_south] load_employees_traders_south
      ;