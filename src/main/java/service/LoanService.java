package service;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;

import model.entity.Loan;
import repository.LoanRepository;
import util.DBUtil;

public class LoanService {
	private static LoanService instance;
	
	private LoanService() {}
	
	public final static LoanService getService() {
		return instance;
	}

	private LoanRepository repo = new LoanRepository();

	public List<Loan> findAllLoansSortedByRate() {
		return repo.findAll().stream().sorted(Comparator.comparing(Loan::getInterestRate)) // 금리 낮은 순
				.collect(Collectors.toList());
	}

	public List<Loan> searchLoans(String bank, String loanType, Float interestRate) {
		Float interestRateFloat = interestRate != null ? interestRate.floatValue() : null;

		return repo.findByConditions(bank, loanType, interestRateFloat).stream()
				.sorted(Comparator.comparing(Loan::getInterestRate)) // 금리순 정렬
				.collect(Collectors.toList());
	}

	public void updateLoan(int id, String productName, String bankName, String loanType, Float interestRate, Integer maxLimit, Integer loanTermMonth) throws RuntimeException{
		EntityManager em = DBUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();

		try {
			tx.begin();

			Loan loan = em.find(Loan.class, id);
			
			if (loan == null) {
				throw new IllegalArgumentException("해당 ID의 대출 상품을 찾을 수 없습니다: " + id);
			}
			
			loan.setProductName(productName);
			loan.setBankName(bankName);
			loan.setLoanType(loanType);
			loan.setInterestRate(interestRate);
			loan.setMaxLimit(maxLimit);
			loan.setLoanTermMonth(loanTermMonth);

			tx.commit();

		} catch (Exception e) {
			if (tx.isActive()) {
				tx.rollback();
			}
			throw new RuntimeException("대출 상품 수정 중 오류 발생", e);
		} finally {
			em.close();
		}
	}

	public Loan findById(int id) {
		return repo.findById(id);
	}

	public void deleteLoan(Integer id) {
		repo.delete(id);
	}

	public void addLoan(String productName, String bankName, String loanType, Float interestRate, Integer maxLimit,
			Integer loanTermMonth) {
		repo.add(productName, bankName, loanType, interestRate, maxLimit, loanTermMonth);
	}

}
