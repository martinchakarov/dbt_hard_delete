{% macro hard_delete(source_name, condition, dry_run = true) %}
  
  {% set query = 'DELETE FROM ' ~ source_name ~ ' WHERE ' ~ condition ~ ';' %}

  {% if not (dry_run | as_bool) %}

        {% do log('Deleting records from ' ~ source_name ~ '...', info = True) %}
        {{ run_query(query) }}

  {% else %}

    {% do log("Generated query: " ~ query, info = True) %}

  {% endif %}

{% endmacro %}