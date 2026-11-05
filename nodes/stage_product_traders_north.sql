      INSERT INTO [TABLEOWNER].[stage_product_traders_north]
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
      , dss_change_hash_product_hroc_traders_north
      , dss_change_hash_product_lroc_traders_north
      , dss_change_hash_product_mroc_traders_north
      , dss_record_source
      , dss_load_date
      , dss_create_time)
      SELECT  CAST(HASHBYTES('md5',
               COALESCE(CAST(load_products_traders_north.productname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_product 
           , load_products_traders_north.productname AS product_name 
           , load_products_traders_north.unitsinstock AS unitsinstock 
           , load_products_traders_north.unitsonorder AS unitsonorder 
           , load_products_traders_north.productid AS productid 
           , load_products_traders_north.reorderlevel AS reorderlevel 
           , load_products_traders_north.discontinued AS discontinued 
           , load_products_traders_north.supplierid AS supplierid 
           , load_products_traders_north.categoryid AS categoryid 
           , load_products_traders_north.quantityperunit AS quantityperunit 
           , load_products_traders_north.unitprice AS unitprice 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_products_traders_north.unitsinstock AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_north.unitsonorder AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_product_hroc_traders_north 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_products_traders_north.productid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_north.reorderlevel AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_north.discontinued AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_product_lroc_traders_north 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_products_traders_north.supplierid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_north.categoryid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_north.quantityperunit AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_products_traders_north.unitprice AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_product_mroc_traders_north 
           , load_products_traders_north.dss_record_source AS dss_record_source 
           , load_products_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
      FROM [TABLEOWNER].[load_products_traders_north] load_products_traders_north
      ;
