package model.entity;

import javax.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Entity
public class Loan {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "product_name", length = 50)
    private String productName;

    @Column(name = "bank_name", length = 50)
    private String bankName;

    @Column(name = "loan_type", length = 50)
    private String loanType;

    @Column(name = "interest_rate")
    private Float interestRate;

    @Column(name = "max_limit")
    private Integer maxLimit;

    @Column(name = "loan_term_month")
    private Integer loanTermMonth;
}
