   TRUNCATE TABLE [TABLEOWNER].[agg_product_group_sales];

   INSERT INTO [TABLEOWNER].[agg_product_group_sales]
   (
     dim_order_date_key
   , product_group
   , quantity
   , dss_update_time
   )
   SELECT
     fact_order_detail.dim_order_date_key
   , dim_product.product_group_description
   , SUM(fact_order_detail.quantity)
   , GETDATE()
   FROM
     [TABLEOWNER].[fact_order_detail] fact_order_detail
   , [TABLEOWNER].[dim_product] dim_product
   WHERE fact_order_detail.dim_product_key = dim_product.dim_product_key
   GROUP BY
     fact_order_detail.dim_order_date_key
   , dim_product.product_group_description