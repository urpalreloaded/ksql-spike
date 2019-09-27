package org.sdk.serializers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.common.serialization.Serializer;
import org.sdk.domain.Policy;

public class PolicySerializer implements Serializer<Policy> {
    
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public byte[] serialize(String topic, Policy policy) {
        try {
            return objectMapper.writeValueAsBytes(policy);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        
        return new byte[0];
    }
}