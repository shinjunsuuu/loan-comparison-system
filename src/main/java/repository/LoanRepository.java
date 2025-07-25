package repository;

import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;

import model.entity.Loan;
import util.DBUtil;

public class LoanRepository {
	
	//????? 예외 처리 필수 
	public List<Loan> findAll() {
		
		EntityManager em = DBUtil.getEntityManager();
		try {
			
			return em.createQuery("SELECT l FROM Loan l", Loan.class).getResultList();
		} finally {
			
			if (em != null) {
				em.close();
			}
		}
	}

	public List<Loan> findByConditions(String bank, String loanType, Float maxRate) {
		
		return findAll().stream().filter(l -> bank == null || bank.isEmpty() || l.getBankName().equals(bank))
				.filter(l -> loanType == null || loanType.isEmpty() || l.getLoanType().equals(loanType))
				.filter(l -> maxRate == null || l.getInterestRate() <= maxRate).collect(Collectors.toList());
	}

	public Loan findById(int id) {
		
		EntityManager em = DBUtil.getEntityManager();
		Loan loan = null;

		try {
			loan = em.find(Loan.class, id);
		} finally {
			em.close();
		}

		return loan;
	}

	public void delete(Integer id) {
		
		EntityManager em = DBUtil.getEntityManager();
		try {
			em.getTransaction().begin();
			Loan loan = em.find(Loan.class, id);
			if (loan != null) {
				em.remove(loan);
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			throw e;
		} finally {
			em.close();
		}
	}

	public void add(String productName, String bankName, String loanType, Float interestRate, Integer maxLimit,
			Integer loanTermMonth) {

		EntityManager em = DBUtil.getEntityManager();

		try {
			em.getTransaction().begin();

			Loan loan = new Loan();
			loan.setProductName(productName);
			loan.setBankName(bankName);
			loan.setLoanType(loanType);
			loan.setInterestRate(interestRate);
			loan.setMaxLimit(maxLimit);
			loan.setLoanTermMonth(loanTermMonth);

			em.persist(loan);
			em.getTransaction().commit();

		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			throw e;
		} finally {
			em.close();
		}
	}
}