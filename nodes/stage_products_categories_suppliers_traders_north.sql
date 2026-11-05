      INSERT INTO [TABLEOWNER].[stage_products_categories_suppliers_traders_north]
      ( hk_l_products_categories_suppliers
      , hk_h_category
      , hk_h_product
      , hk_h_supplier
      , category_name
      , product_name
      , supplier_name
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_categories_traders_north.categoryname AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_north.productname AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_suppliers_traders_north.companyname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_l_products_categories_suppliers 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_categories_traders_north.categoryname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_category 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_products_traders_north.productname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_product 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_suppliers_traders_north.companyname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_supplier 
           , load_categories_traders_north.categoryname AS category_name 
           , load_products_traders_north.productname AS product_name 
           , load_suppliers_traders_north.companyname AS supplier_name 
           , load_suppliers_traders_north.dss_record_source AS dss_record_source 
           , load_suppliers_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_products_traders_north] load_products_traders_north
INNER JOIN [TABLEOWNER].[load_suppliers_traders_north] load_suppliers_traders_north
ON load_products_traders_north.supplierid = load_suppliers_traders_north.supplierid
INNER JOIN [TABLEOWNER].[load_categories_traders_north] load_categories_traders_north
ON load_products_traders_north.categoryid = load_categories_traders_north.categoryid
      ;