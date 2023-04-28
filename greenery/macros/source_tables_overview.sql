{% macro source_tables_overview(database_name) %}

   SELECT
      t.table_name, 
      COUNT(c.column_name) AS num_columns,
      t.row_count AS num_rows
   FROM information_schema.tables t
   LEFT JOIN information_schema.columns c 
      ON c.table_name = t.table_name
   WHERE t.table_catalog = '{{database_name}}'
   AND t.table_schema NOT IN ('INFORMATION_SCHEMA', 'SYS')
   GROUP BY t.table_name, t.row_count
   ORDER BY t.table_name

{% endmacro %}