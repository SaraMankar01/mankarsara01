      INSERT INTO [TABLEOWNER].[stage_customer_traders_south]
      ( hk_h_customer
      , customer_name
      , customerid
      , country
      , contactname
      , contacttitle
      , address
      , city
      , region
      , postalcode
      , phone
      , fax
      , dss_change_hash_customer_lroc_traders_south
      , dss_change_hash_customer_mroc_traders_south
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_customers_traders_south.companyname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_customer 
           , load_customers_traders_south.companyname AS customer_name 
           , load_customers_traders_south.customerid AS customerid 
           , load_customers_traders_south.country AS country 
           , load_customers_traders_south.contactname AS contactname 
           , load_customers_traders_south.contacttitle AS contacttitle 
           , load_customers_traders_south.address AS address 
           , load_customers_traders_south.city AS city 
           , load_customers_traders_south.region AS region 
           , load_customers_traders_south.postalcode AS postalcode 
           , load_customers_traders_south.phone AS phone 
           , load_customers_traders_south.fax AS fax 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_customers_traders_south.customerid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_customer_lroc_traders_south 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_customers_traders_south.country AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_south.contactname AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_south.contacttitle AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_south.address AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_south.city AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_south.region AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_south.postalcode AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_south.phone AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_south.fax AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_customer_mroc_traders_south 
           , load_customers_traders_south.dss_record_source AS dss_record_source 
           , load_customers_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_customers_traders_south] load_customers_traders_south
      ;
