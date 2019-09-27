package org.sdk.producers;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.common.serialization.Deserializer;
import org.sdk.domain.Customer;

import java.io.IOException;

public class CustomerDeserializer implements Deserializer<Customer> {
    
    private ObjectMapper objectMapper = new ObjectMapper();


    @Override
    public Customer deserialize(String topic, byte[] data) {
        try {
            return objectMapper.readValue(data, Customer.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return new Customer();
    }
}