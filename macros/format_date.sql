{% macro format_date(date_column, format) %}
    to_char({{ date_column }}, '{{ format }}')
{% endmacro %}
