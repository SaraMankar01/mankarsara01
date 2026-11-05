      INSERT INTO [TABLEOWNER].[stage_category_traders_north]
      ( category_name
      , categoryid
      , description
      , dss_record_source
      , dss_load_date
      , dss_create_time
      , hk_h_category
      , dss_change_hash_category_lroc_traders_north)
      SELECT  load_categories_traders_north.categoryname AS category_name 
           , load_categories_traders_north.categoryid AS categoryid 
           , load_categories_traders_north.description AS description 
           , load_categories_traders_north.dss_record_source AS dss_record_source 
           , load_categories_traders_north.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_categories_traders_north.categoryname AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS hk_h_category 
           , CAST(HASHBYTES('md5',
               COALESCE(CAST(load_categories_traders_north.categoryid AS VARCHAR(MAX)),'null') +'||'+
               COALESCE(CAST(load_categories_traders_north.description AS VARCHAR(MAX)),'null')
               ) AS CHAR(32)) AS dss_change_hash_category_lroc_traders_north 
      FROM [TABLEOWNER].[load_categories_traders_north] load_categories_traders_north
      ;
