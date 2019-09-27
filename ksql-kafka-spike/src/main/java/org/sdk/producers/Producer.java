package org.sdk.producers;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.sdk.domain.Customer;
import org.sdk.domain.Policy;

import java.time.LocalDate;
import java.util.Properties;
import java.util.stream.IntStream;

public class Producer {
    
    static Properties getProperties(String valueSerializer) {
        Properties properties = new Properties();
        properties.setProperty("bootstrap.servers", "localhost:9092");
        properties.setProperty("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
//        properties.setProperty("value.serializer", "org.apache.kafka.connect.json.JsonSerializer");
        properties.setProperty("value.serializer", valueSerializer);
        //properties.setProperty(CommonClientConfigs.SECURITY_PROTOCOL_CONFIG, "SASL_PLAINTEXT");
        return properties;
    }
    
    static KafkaProducer getProducer(Properties properties) {
        return new KafkaProducer(properties);
    }
    
    public static void main(String args[]) {
//        produce("products");
        producePolicy("policies");
    }
    
    public static void produce(String topicName) {
        Properties properties = getProperties("org.sdk.serializers.CustomerSerializer");
        KafkaProducer producer = getProducer(properties);

        try {
            IntStream.range(5, 1000000).forEach(i -> {
                Customer customer = new Customer(Integer.toString(i), String.format("product-%d", i));
                ProducerRecord rec = new ProducerRecord(topicName, customer.getId(), customer);
                producer.send(rec); 
            });

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            producer.close();
        }
    }

    public static void producePolicy(String topicName) {
        KafkaProducer producer = getProducer(getProperties("org.sdk.serializers.PolicySerializer"));

        try {
            IntStream.range(5, 10).forEach(i -> {
                Policy policy = new Policy(Integer.toString(i), Integer.toString(i), Integer.toString(i), LocalDate.now());
                ProducerRecord rec = new ProducerRecord(topicName, policy.getId(), policy);
                producer.send(rec);
            });

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            producer.close();
        }
    }
}
