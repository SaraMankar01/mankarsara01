      INSERT INTO [TABLEOWNER].[stage_customer_traders_north]
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
      , dss_change_hash_customer_lroc_traders_north
      , dss_change_hash_customer_mroc_traders_north
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_customers_traders_north.companyname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_customer 
           , load_customers_traders_north.companyname AS customer_name 
           , load_customers_traders_north.customerid AS customerid 
           , load_customers_traders_north.country AS country 
           , load_customers_traders_north.contactname AS contactname 
           , load_customers_traders_north.contacttitle AS contacttitle 
           , load_customers_traders_north.address AS address 
           , load_customers_traders_north.city AS city 
           , load_customers_traders_north.region AS region 
           , load_customers_traders_north.postalcode AS postalcode 
           , load_customers_traders_north.phone AS phone 
           , load_customers_traders_north.fax AS fax 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_customers_traders_north.customerid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_customer_lroc_traders_north 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_customers_traders_north.country AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_north.contactname AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_north.contacttitle AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_north.address AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_north.city AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_north.region AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_north.postalcode AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_north.phone AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_customers_traders_north.fax AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_customer_mroc_traders_north 
           , load_customers_traders_north.dss_record_source AS dss_record_source 
           , load_customers_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_customers_traders_north] load_customers_traders_north
      ;