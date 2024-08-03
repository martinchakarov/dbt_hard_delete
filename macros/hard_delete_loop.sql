{% macro hard_delete_loop(dry_run = true) %}
  
{% set sources = [
    {
        "name": source('raw_data', 'customers'),
        "condition": '_FIVETRAN_DELETED'
    },
    {
        "name": source('raw_data', 'orders'),
        "condition": 'NOT _FIVETRAN_ACTIVE'
    }
] %}

{% for source_name in sources %}

    {{ hard_delete(source_name["name"], source_name["condition"], dry_run = dry_run) }}

{% endfor %}

{% endmacro %}