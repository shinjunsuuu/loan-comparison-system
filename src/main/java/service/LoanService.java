package service;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import model.entity.Loan;
import repository.LoanRepository;

public class LoanService {

	private LoanRepository repo = new LoanRepository();

    /**
     * 전체 대출 상품 조회 (금리 오름차순 정렬)
     */
    public List<Loan> findAllLoansSortedByRate() {
        return repo.findAll().stream()
                .sorted(Comparator.comparing(Loan::getInterestRate)) // 금리 낮은 순
                .collect(Collectors.toList());
    }

    /**
     * 조건 검색 (은행명, 대출유형, 최대금리)
     * Repository의 조건 필터링 로직 활용 + Stream 정렬
     */
    public List<Loan> searchLoans(String bank, String loanType, Double maxRate) {
        // repository에 Float 타입이므로 변환
        Float maxRateFloat = maxRate != null ? maxRate.floatValue() : null;

        return repo.findByConditions(bank, loanType, maxRateFloat).stream()
                .sorted(Comparator.comparing(Loan::getInterestRate)) // 금리순 정렬
                .collect(Collectors.toList());
    }

	public void updateLoan(Long id, String productName, String bankName, String loanType, Double interestRate,
			Integer maxLimit, Integer loanTermMonth) {
		// TODO Auto-generated method stub
		
	}

}
