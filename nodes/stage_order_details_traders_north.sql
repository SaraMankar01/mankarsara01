      INSERT INTO [TABLEOWNER].[stage_order_details_traders_north]
      ( hk_l_order_details
      , hk_h_order
      , hk_h_product
      , order_number
      , product_name
      , orderdate
      , unitprice
      , quantity
      , discount
      , dss_change_hash_order_details_transact_traders_north
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_north.orderid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_north.productname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_l_order_details 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_north.orderid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_order 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_products_traders_north.productname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_product 
           , load_orders_traders_north.orderid AS order_number 
           , load_products_traders_north.productname AS product_name 
           , load_orders_traders_north.orderdate AS orderdate 
           , load_order_details_traders_north.unitprice AS unitprice 
           , load_order_details_traders_north.quantity AS quantity 
           , load_order_details_traders_north.discount AS discount 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_north.orderdate AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_order_details_traders_north.unitprice AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_order_details_traders_north.quantity AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_order_details_traders_north.discount AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_order_details_transact_traders_north 
           , load_order_details_traders_north.dss_record_source AS dss_record_source 
           , load_order_details_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_order_details_traders_north] load_order_details_traders_north
INNER JOIN [TABLEOWNER].[load_orders_traders_north] load_orders_traders_north
ON load_order_details_traders_north.orderid = load_orders_traders_north.orderid
INNER JOIN [TABLEOWNER].[load_products_traders_north] load_products_traders_north
ON load_order_details_traders_north.productid = load_products_traders_north.productid
      ;