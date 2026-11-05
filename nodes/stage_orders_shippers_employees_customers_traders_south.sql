      INSERT INTO [TABLEOWNER].[stage_orders_shippers_employees_customers_traders_south]
      ( hk_l_orders_shippers_employees_customers
      , hk_h_customer
      , hk_h_employee
      , hk_h_order
      , hk_h_shipper
      , customer_name
      , employee_id
      , order_number
      , shipper_name
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_customers_traders_south.companyname AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_south.employeeid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_orders_traders_south.orderid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_shippers_traders_south.companyname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_l_orders_shippers_employees_customers 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_customers_traders_south.companyname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_customer 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_south.employeeid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_employee 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_orders_traders_south.orderid AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_order 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_shippers_traders_south.companyname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_shipper 
           , load_customers_traders_south.companyname AS customer_name 
           , load_orders_traders_south.employeeid AS employee_id 
           , load_orders_traders_south.orderid AS order_number 
           , load_shippers_traders_south.companyname AS shipper_name 
           , load_shippers_traders_south.dss_record_source AS dss_record_source 
           , load_shippers_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_orders_traders_south] load_orders_traders_south
INNER JOIN [TABLEOWNER].[load_customers_traders_south] load_customers_traders_south
ON load_orders_traders_south.customerid = load_customers_traders_south.customerid
INNER JOIN [TABLEOWNER].[load_shippers_traders_south] load_shippers_traders_south
ON load_orders_traders_south.shipvia = load_shippers_traders_south.shipperid
      ;