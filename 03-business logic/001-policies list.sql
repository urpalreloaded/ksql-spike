select 
    policies.policy_id, 
    customer.id as customer_id,
    customer.name as customer_name,
    products.name as product_name,
    policies.expiration_date as policy_expiration_date,
    sum(policies_details.option_value) as total_policies_options_value
from policies 
    inner join customers on (policies.customer_id=customer.id)
    inner join policies_details on (
        policies.id=policies_details.policy_id and
        policies_details.options_code in ('OPT1','OPT2')
    )
    ...
where customer.id=xxxxx
group by
    policies.policy_id, 
    customer.id as customer_id,
    customer.name as customer_name,
    products.name as product_name,
    policies.expiration_date as policy_expiration_date,

select policies_details.option_code
from policies_details
where policy_id in (
    select 
        policies.policy_id
    from policies 
        inner join customers on (policies.customer_id=customer.id)
        ...
    where customer.id=xxxxx
)