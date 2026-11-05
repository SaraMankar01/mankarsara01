      INSERT INTO [TABLEOWNER].[stage_order_details_traders_south]
      ( hk_l_order_details
      , hk_h_order
      , hk_h_product
      , order_number
      , product_name
      , orderdate
      , unitprice
      , quantity
      , discount
      , dss_change_hash_order_details_transact_traders_south
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_south.orderid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_south.productname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_l_order_details 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_south.orderid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_order 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_products_traders_south.productname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_product 
           , load_orders_traders_south.orderid AS order_number 
           , load_products_traders_south.productname AS product_name 
           , load_orders_traders_south.orderdate AS orderdate 
           , load_order_details_traders_south.unitprice AS unitprice 
           , load_order_details_traders_south.quantity AS quantity 
           , load_order_details_traders_south.discount AS discount 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_south.orderdate AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_order_details_traders_south.unitprice AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_order_details_traders_south.quantity AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_order_details_traders_south.discount AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_order_details_transact_traders_south 
           , load_products_traders_south.dss_record_source AS dss_record_source 
           , load_products_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_order_details_traders_south] load_order_details_traders_south
INNER JOIN [TABLEOWNER].[load_products_traders_south] load_products_traders_south
ON load_order_details_traders_south.productid = load_products_traders_south.productid
INNER JOIN [TABLEOWNER].[load_orders_traders_south] load_orders_traders_south
ON load_order_details_traders_south.orderid = load_orders_traders_south.orderid
      ;