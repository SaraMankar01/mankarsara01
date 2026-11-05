      INSERT INTO [TABLEOWNER].[stage_order_traders_south]
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
      , dss_change_hash_order_hroc_traders_south
      , dss_change_hash_order_lroc_traders_south
      , dss_change_hash_order_mroc_traders_south
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_south.orderid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_order 
           , load_orders_traders_south.orderid AS order_number 
           , load_orders_traders_south.freight AS freight 
           , load_orders_traders_south.customerid AS customerid 
           , load_orders_traders_south.employeeid AS employeeid 
           , load_orders_traders_south.shipvia AS shipvia 
           , load_orders_traders_south.requireddate AS requireddate 
           , load_orders_traders_south.shippeddate AS shippeddate 
           , load_orders_traders_south.shipname AS shipname 
           , load_orders_traders_south.shipaddress AS shipaddress 
           , load_orders_traders_south.shipcity AS shipcity 
           , load_orders_traders_south.shipregion AS shipregion 
           , load_orders_traders_south.shippostalcode AS shippostalcode 
           , load_orders_traders_south.shipcountry AS shipcountry 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_south.freight AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_order_hroc_traders_south 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_south.customerid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_south.employeeid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_south.shipvia AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_order_lroc_traders_south 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_south.requireddate AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_south.shippeddate AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_south.shipname AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_south.shipaddress AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_south.shipcity AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_south.shipregion AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_south.shippostalcode AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_south.shipcountry AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_order_mroc_traders_south 
           , load_orders_traders_south.dss_record_source AS dss_record_source 
           , load_orders_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_orders_traders_south] load_orders_traders_south
      ;