{% macro grant_role(role) %}

      GRANT USAGE ON SCHEMA {{ schema }} TO ROLE {{ role }};
      GRANT SELECT ON {{ this }} TO ROLE {{ role }};

{% endmacro %}