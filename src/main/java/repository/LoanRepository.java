package repository;

import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;

import model.entity.Loan;
import util.DBUtil;

public class LoanRepository {
    public List<Loan> findAll() {
    	EntityManager em = DBUtil.getEntityManager();
        return em.createQuery("SELECT l FROM Loan l", Loan.class)
                 .getResultList();
    }

    public List<Loan> findByConditions(String bank, String loanType, Float maxRate) {
        return findAll().stream()
            .filter(l -> bank == null || bank.isEmpty() || l.getBankName().equals(bank))
            .filter(l -> loanType == null || loanType.isEmpty() || l.getLoanType().equals(loanType))
            .filter(l -> maxRate == null || l.getInterestRate() <= maxRate)
            .collect(Collectors.toList());
    }
}