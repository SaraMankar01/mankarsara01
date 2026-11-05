    INSERT INTO [TABLEOWNER].[stage_country]
      ( name
      , alpha_2
      , alpha_3
      , country_code
      , iso_3166_2
      , region
      , sub_region
      , region_code
      , sub_region_code
      , dss_record_source
      , dss_load_date
      , dss_create_time)
    SELECT load_countrycodes_file_sources.name AS name 
           , load_countrycodes_file_sources.alpha_2 AS alpha_2 
           , load_countrycodes_file_sources.alpha_3 AS alpha_3 
           , load_countrycodes_file_sources.country_code AS country_code 
           , load_countrycodes_file_sources.iso_3166_2 AS iso_3166_2 
           , load_countrycodes_file_sources.region AS region 
           , load_countrycodes_file_sources.sub_region AS sub_region 
           , load_countrycodes_file_sources.region_code AS region_code 
           , load_countrycodes_file_sources.sub_region_code AS sub_region_code 
           , load_countrycodes_file_sources.dss_record_source AS dss_record_source 
           , load_countrycodes_file_sources.dss_load_date AS dss_load_date 
           , @v_current_datetime AS dss_create_time 
    FROM [TABLEOWNER].[load_countrycodes_file_sources] load_countrycodes_file_sources
    ;