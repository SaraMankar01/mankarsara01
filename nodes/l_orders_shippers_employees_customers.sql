    INSERT INTO [TABLEOWNER].[l_orders_shippers_employees_customers]
      ( hk_l_orders_shippers_employees_customers
      , hk_h_customer
      , hk_h_employee
      , hk_h_order
      , hk_h_shipper
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_orders_shippers_employees_customers_traders_south.hk_l_orders_shippers_employees_customers AS hk_l_orders_shippers_employees_customers 
           , stage_orders_shippers_employees_customers_traders_south.hk_h_customer AS hk_h_customer 
           , stage_orders_shippers_employees_customers_traders_south.hk_h_employee AS hk_h_employee 
           , stage_orders_shippers_employees_customers_traders_south.hk_h_order AS hk_h_order 
           , stage_orders_shippers_employees_customers_traders_south.hk_h_shipper AS hk_h_shipper 
           , stage_orders_shippers_employees_customers_traders_south.dss_record_source AS dss_record_source 
           , stage_orders_shippers_employees_customers_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_orders_shippers_employees_customers_traders_south] stage_orders_shippers_employees_customers_traders_south
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[l_orders_shippers_employees_customers] l_orders_shippers_employees_customers
        WHERE  stage_orders_shippers_employees_customers_traders_south.hk_h_customer = l_orders_shippers_employees_customers.hk_h_customer
        AND    stage_orders_shippers_employees_customers_traders_south.hk_h_employee = l_orders_shippers_employees_customers.hk_h_employee
        AND    stage_orders_shippers_employees_customers_traders_south.hk_h_order = l_orders_shippers_employees_customers.hk_h_order
        AND    stage_orders_shippers_employees_customers_traders_south.hk_h_shipper = l_orders_shippers_employees_customers.hk_h_shipper
        )
    ;
	
    INSERT INTO [TABLEOWNER].[l_orders_shippers_employees_customers]
      ( hk_l_orders_shippers_employees_customers
      , hk_h_customer
      , hk_h_employee
      , hk_h_order
      , hk_h_shipper
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT DISTINCT stage_orders_shippers_employees_customers_traders_north.hk_l_orders_shippers_employees_customers AS hk_l_orders_shippers_employees_customers 
           , stage_orders_shippers_employees_customers_traders_north.hk_h_customer AS hk_h_customer 
           , stage_orders_shippers_employees_customers_traders_north.hk_h_employee AS hk_h_employee 
           , stage_orders_shippers_employees_customers_traders_north.hk_h_order AS hk_h_order 
           , stage_orders_shippers_employees_customers_traders_north.hk_h_shipper AS hk_h_shipper 
           , stage_orders_shippers_employees_customers_traders_north.dss_record_source AS dss_record_source 
           , stage_orders_shippers_employees_customers_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[stage_orders_shippers_employees_customers_traders_north] stage_orders_shippers_employees_customers_traders_north
    WHERE NOT EXISTS (
        SELECT 1
        FROM   [TABLEOWNER].[l_orders_shippers_employees_customers] l_orders_shippers_employees_customers
        WHERE  stage_orders_shippers_employees_customers_traders_north.hk_h_customer = l_orders_shippers_employees_customers.hk_h_customer
        AND    stage_orders_shippers_employees_customers_traders_north.hk_h_employee = l_orders_shippers_employees_customers.hk_h_employee
        AND    stage_orders_shippers_employees_customers_traders_north.hk_h_order = l_orders_shippers_employees_customers.hk_h_order
        AND    stage_orders_shippers_employees_customers_traders_north.hk_h_shipper = l_orders_shippers_employees_customers.hk_h_shipper
        )
    ;	