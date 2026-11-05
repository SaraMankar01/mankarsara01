      INSERT INTO [TABLEOWNER].[stage_product_traders_south]
      ( hk_h_product
      , product_name
      , unitsinstock
      , unitsonorder
      , productid
      , reorderlevel
      , discontinued
      , supplierid
      , categoryid
      , quantityperunit
      , unitprice
      , dss_change_hash_product_hroc_traders_south
      , dss_change_hash_product_lroc_traders_south
      , dss_change_hash_product_mroc_traders_south
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_products_traders_south.productname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_product 
           , load_products_traders_south.productname AS product_name 
           , load_products_traders_south.unitsinstock AS unitsinstock 
           , load_products_traders_south.unitsonorder AS unitsonorder 
           , load_products_traders_south.productid AS productid 
           , load_products_traders_south.reorderlevel AS reorderlevel 
           , load_products_traders_south.discontinued AS discontinued 
           , load_products_traders_south.supplierid AS supplierid 
           , load_products_traders_south.categoryid AS categoryid 
           , load_products_traders_south.quantityperunit AS quantityperunit 
           , load_products_traders_south.unitprice AS unitprice 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_products_traders_south.unitsinstock AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_south.unitsonorder AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_product_hroc_traders_south 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_products_traders_south.productid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_south.reorderlevel AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_south.discontinued AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_product_lroc_traders_south 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_products_traders_south.supplierid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_south.categoryid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_south.quantityperunit AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_south.unitprice AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_product_mroc_traders_south 
           , load_products_traders_south.dss_record_source AS dss_record_source 
           , load_products_traders_south.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_products_traders_south] load_products_traders_south
      ;