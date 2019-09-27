package org.sdk.serializers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.common.serialization.Serializer;
import org.sdk.domain.Customer;

public class CustomerSerializer implements Serializer<Customer> {
    
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public byte[] serialize(String topic, Customer customer) {
        try {
            return objectMapper.writeValueAsBytes(customer);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        
        return new byte[0];
    }
}