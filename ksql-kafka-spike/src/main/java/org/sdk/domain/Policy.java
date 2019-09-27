package org.sdk.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@AllArgsConstructor
public class Policy {
    private String id;
    private String customer_id;
    private String policy_id;
    private LocalDate expiry_date;
}
