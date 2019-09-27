ksql http://ksql-server:8088

create table customers (id VARCHAR, name VARCHAR) WITH (kafka_topic='customers',value_format='JSON',key='id',partitions=1, replicas=1);

./kafka-topics.sh --bootstrap-server localhost:9092 --list

./kafka-console-producer.sh --broker-list localhost:9092 --topic customers --property "parse.key=true" --property "key.separator=:"
"1":{"id":"1","name":"dinesh"}
"2":{"id":"2","name":"ronaldo"}
"3":{"id":"3","name":"rooney"}
"4":{"id":"4","name":"roma"}
"4":{"id":"4","name":"roma_edited"}

SET 'auto.offset.reset'='earliest';

create table products (id VARCHAR, name VARCHAR) WITH (kafka_topic='products',value_format='JSON',key='id',partitions=1, replicas=1);

./kafka-console-producer.sh --broker-list localhost:9092 --topic products --property "parse.key=true" --property "key.separator=:"
"1":{"id":"1","name":"motor_vehicle"}
"2":{"id":"2","name":"life"}
"3":{"id":"3","name":"accidental"}
"4":{"id":"4","name":"house"}
"4":{"id":"4","name":"house_edited"}
"4":{"id":"4","name":"house_edited_again"}

create table policies (id VARCHAR, customer_id VARCHAR, product_id VARCHAR, expiry_date VARCHAR) WITH (kafka_topic='policies',value_format='JSON',key='id',partitions=1, replicas=1);

./kafka-console-producer.sh --broker-list localhost:9092 --topic policies --property "parse.key=true" --property "key.separator=:"
"1":{"id":"1","customer_id":"1","product_id":"1", "expiry_date":"2019-09-25"}
"2":{"id":"2","customer_id":"1","product_id":"2", "expiry_date":"2019-09-24"}
"3":{"id":"3","customer_id":"2","product_id":"2", "expiry_date":"2019-09-24"}
"4":{"id":"4","customer_id":"4","product_id":"4", "expiry_date":"2019-09-24"}
"40000":{"id":"40000","customer_id":"40000","product_id":"4", "expiry_date":"2019-09-24"}
"5":{"id":"5","customer_id":"5","product_id":"4", "expiry_date":"2019-09-24"}
"6":{"id":"6","customer_id":"6","product_id":"4", "expiry_date":"2019-09-24"}
40000:{"id":"40000","customer_id":"40000","product_id":"4", "expiry_date":"2019-09-24"}
400000:{"id":"400000","customer_id":"400000","product_id":"4", "expiry_date":"2019-09-24"}
500000:{"id":"500000","customer_id":"500000","product_id":"4", "expiry_date":"2019-09-24"}
600000:{"id":"600000","customer_id":"600000","product_id":"6", "expiry_date":"2019-09-24"}
645566:{"id":"645566","customer_id":"645566","product_id":"6", "expiry_date":"2019-09-24"}
745566:{"id":"745566","customer_id":"745566","product_id":"745566", "expiry_date":"2019-09-24"}
845566:{"id":"845566","customer_id":"845566","product_id":"845566", "expiry_date":"2019-09-24"}
945566:{"id":"945566","customer_id":"945566","product_id":"945566", "expiry_date":"2019-09-24"}
345566:{"id":"345566","customer_id":"345566","product_id":"345566", "expiry_date":"2019-09-24"}
335566:{"id":"335566","customer_id":"335566","product_id":"335566", "expiry_date":"2019-09-24"}
335544:{"id":"335544","customer_id":"335544","product_id":"335544", "expiry_date":"2019-09-24"}
335545:{"id":"335545","customer_id":"335545","product_id":"335545", "expiry_date":"2019-09-24"}
"335546":{"id":"335546","customer_id":"335546","product_id":"335546", "expiry_date":"2019-09-24"}
335547:{"id":"335547","customer_id":"335547","product_id":"335547", "expiry_date":"2019-09-24"}

Statement: select * from policies inner join customers on customers.id = policies.customer_id;
Caused by: Source table (POLICIES) key column (POLICIES.ID) is not the column
	used in the join criteria (POLICIES.CUSTOMER_ID). Only the table's key column or
	'ROWKEY' is supported in the join criteria.

select * from policies inner join customers on customers.id = policies.id;

select * from customers inner join policies on customers.id = policies.id inner join products on products.id = policies.id;

create table policies (id VARCHAR, customer_id VARCHAR, product_id VARCHAR, expiry_date VARCHAR) WITH (kafka_topic='policies',value_format='JSON',key='id',partitions=1, replicas=1);

create stream employees (id VARCHAR, name VARCHAR) WITH (kafka_topic='employees',value_format='JSON',key='id',partitions=1, replicas=1);

./kafka-configs.sh --zookeeper localhost:32181  --entity-type topics --entity-name employees --alter --add-config retention.ms=60000
./kafka-configs.sh --zookeeper localhost:32181  --entity-type topics --entity-name employees --alter --add-config retention.bytes=100

./kafka-topics.sh --describe --zookeeper localhost:32181 --topic employees

./kafka-console-producer.sh --broker-list localhost:9092 --topic employees --property "parse.key=true" --property "key.separator=:"
"1":{"id":"1","name":"e1"}
"2":{"id":"2","name":"e2"}
"3":{"id":"3","name":"e3"}

./kafka-topics.sh --zookeeper localhost:32181 --describe --topics-with-overrides

create table employees_table (id VARCHAR, name VARCHAR) WITH (kafka_topic='employees_table',value_format='JSON',key='id',partitions=1, replicas=1);

./kafka-configs.sh --zookeeper localhost:32181  --entity-type topics --entity-name employees_table --alter --add-config retention.ms=60000
./kafka-configs.sh --zookeeper localhost:32181  --entity-type topics --entity-name employees_table --alter --add-config retention.bytes=100

./kafka-console-producer.sh --broker-list localhost:9092 --topic employees_table --property "parse.key=true" --property "key.separator=:"
"1":{"id":"1","name":"e1"}
"2":{"id":"2","name":"e2"}
"3":{"id":"3","name":"e3"}
"4":{"id":"4","name":"e4"}
"5":{"id":"5","name":"e5"}
"6":{"id":"6","name":"e6"}
"7":{"id":"7","name":"e7"}
"8":{"id":"8","name":"e8"}
"9":{"id":"9","name":"e9"}
"10":{"id":"10","name":"e10"}
"11":{"id":"11","name":"e11"}
"12":{"id":"12","name":"e12"}
"13":{"id":"13","name":"e13"}
"14":{"id":"14","name":"e14"}
"15":{"id":"15","name":"e15"}
"16":{"id":"16","name":"e16"}

create stream employees_with_huge_log (id VARCHAR, name VARCHAR) WITH (kafka_topic='employees_with_huge_log',value_format='JSON',key='id',partitions=1, replicas=1);

./kafka-configs.sh --zookeeper localhost:32181  --entity-type topics --entity-name employees_with_huge_log --alter --add-config retention.ms=60000
./kafka-configs.sh --zookeeper localhost:32181  --entity-type topics --entity-name employees_with_huge_log --alter --add-config retention.bytes=200000000

./kafka-console-producer.sh --broker-list localhost:9092 --topic employees_with_huge_log --property "parse.key=true" --property "key.separator=:"
"1":{"id":"1","name":"e1"}
"2":{"id":"2","name":"e2"}
"3":{"id":"3","name":"e3"}
"4":{"id":"4","name":"e4"}
"5":{"id":"5","name":"e5"}
"6":{"id":"6","name":"e6"}
"7":{"id":"7","name":"e7"}
"8":{"id":"8","name":"e8"}
"9":{"id":"9","name":"e9"}
"10":{"id":"10","name":"e10"}
"11":{"id":"11","name":"e11"}
"12":{"id":"12","name":"e12"}
"13":{"id":"13","name":"e13"}
"14":{"id":"14","name":"e14"}
"15":{"id":"15","name":"e15"}
"16":{"id":"16","name":"e16"}

create table customers_partitioned (id VARCHAR, name VARCHAR) WITH (kafka_topic='customers_partitioned',value_format='JSON',key='id',partitions=20, replicas=1);


create table customers_partitioned_100 (id VARCHAR, name VARCHAR) WITH (kafka_topic='customers_partitioned_100',value_format='JSON',key='id',partitions=100, replicas=1);

CREATE STREAM POLICY_CUSTOMERS WITH (REPLICAS = 1, PARTITIONS = 1, KAFKA_TOPIC = 'POLICY_CUSTOMERS') AS SELECT
  POLICIES_STREAM.ID "ID"
, POLICIES_STREAM.CUSTOMER_ID "CUSTOMER_ID"
, POLICIES_STREAM.PRODUCT_ID "PRODUCT_ID"
, POLICIES_STREAM.EXPIRY_DATE "EXPIRY_DATE"
FROM POLICIES_STREAM POLICIES_STREAM
PARTITION BY CUSTOMER_ID;

create stream policy_customers with (replicas=1, partitions=1, kafka_topic = 'policy_customers') as select id as policy_id, customer_id from policies_stream partition by customer_id;

create stream policy_products with (replicas=1, partitions=1, kafka_topic = 'policy_products') as select id as policy_id, product_id from policies_stream partition by product_id;

create stream policy_customers_joined as select policy_id, customer_id, name as 'customer_name' from policy_customers join customers on customers.id = policy_customers.customer_id partition by policy_id;
select policy_id, customer_id from policy_customers join customers on customers.id = policy_customers.customer_id;

create stream policy_products_joined as select * from policy_products join products on products.id = policy_products.product_id partition by policy_id;

