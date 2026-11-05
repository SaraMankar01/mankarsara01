      INSERT INTO [TABLEOWNER].[stage_order_traders_north]
      ( hk_h_order
      , order_number
      , freight
      , customerid
      , employeeid
      , shipvia
      , requireddate
      , shippeddate
      , shipname
      , shipaddress
      , shipcity
      , shipregion
      , shippostalcode
      , shipcountry
      , dss_change_hash_order_hroc_traders_north
      , dss_change_hash_order_lroc_traders_north
      , dss_change_hash_order_mroc_traders_north
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_north.orderid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_order 
           , load_orders_traders_north.orderid AS order_number 
           , load_orders_traders_north.freight AS freight 
           , load_orders_traders_north.customerid AS customerid 
           , load_orders_traders_north.employeeid AS employeeid 
           , load_orders_traders_north.shipvia AS shipvia 
           , load_orders_traders_north.requireddate AS requireddate 
           , load_orders_traders_north.shippeddate AS shippeddate 
           , load_orders_traders_north.shipname AS shipname 
           , load_orders_traders_north.shipaddress AS shipaddress 
           , load_orders_traders_north.shipcity AS shipcity 
           , load_orders_traders_north.shipregion AS shipregion 
           , load_orders_traders_north.shippostalcode AS shippostalcode 
           , load_orders_traders_north.shipcountry AS shipcountry 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_north.freight AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_order_hroc_traders_north 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_north.customerid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_north.employeeid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_north.shipvia AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_order_lroc_traders_north 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_north.requireddate AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_north.shippeddate AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_north.shipname AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_north.shipaddress AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_north.shipcity AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_north.shipregion AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_north.shippostalcode AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_north.shipcountry AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_order_mroc_traders_north 
           , load_orders_traders_north.dss_record_source AS dss_record_source 
           , load_orders_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_orders_traders_north] load_orders_traders_north
      ;