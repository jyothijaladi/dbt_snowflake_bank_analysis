{% macro generate_surrogate_key(columns) %}
    md5(concat(
        {% for column in columns %}
            coalesce({{ column }}, ''){% if not loop.last %}, {% endif %}
        {% endfor %}
    )) as surrogate_key
{% endmacro %}
