document.addEventListener('DOMContentLoaded', () => {
    const searchButton = document.getElementById('searchButton');
    const bankNameInput = document.getElementById('bankName');
    const loanTypeInput = document.getElementById('loanType');
    const interestRateInput = document.getElementById('interestRate');
    const loanTableBody = document.getElementById('loanTableBody');

    // 초기 로딩 시 모든 대출 상품을 가져와 표시
    fetchLoans();

    // 검색 버튼 클릭 이벤트 리스너
    searchButton.addEventListener('click', fetchLoans);

    async function fetchLoans() {
        // 입력 필드에서 검색 조건 가져오기
        const bankName = bankNameInput.value;
        const loanType = loanTypeInput.value;
        const interestRate = interestRateInput.value; // string 형태

        // 쿼리 파라미터 구성
        const queryParams = new URLSearchParams();
        if (bankName) {
            queryParams.append('bankName', bankName);
        }
        if (loanType) {
            queryParams.append('loanType', loanType);
        }
        if (interestRate) {
            queryParams.append('maxInterestRate', interestRate); // 백엔드에서 최대 금리 필터링
        }

        // 백엔드 API 엔드포인트 URL
        // 서블릿 매핑 경로와 일치해야 합니다.
        // WAR 파일 이름이 'loan-project.war'이고 Tomcat에 배포했다면
        // 컨텍스트 경로가 '/loan-project'가 되므로, URL은 '/loan-project/api/loans'가 됩니다.
        const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
        const apiUrl = `${contextPath}/api/loans?${queryParams.toString()}`;


        try {
            const response = await fetch(apiUrl);
            if (!response.ok) {
                // HTTP 상태 코드가 200-299 범위가 아닐 경우 에러 처리
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            const loans = await response.json(); // JSON 응답 파싱
            displayLoans(loans); // 테이블에 데이터 표시
        } catch (error) {
            console.error('대출 상품 데이터를 가져오는 중 오류 발생:', error);
            // 사용자에게 오류 메시지 표시 (예: alert 또는 특정 div에 메시지 출력)
            alert('데이터를 불러오는 데 실패했습니다. 다시 시도해주세요.');
        }
    }

    function displayLoans(loans) {
        loanTableBody.innerHTML = ''; // 기존 테이블 내용 비우기

        if (loans.length === 0) {
            const noDataRow = document.createElement('tr');
            noDataRow.innerHTML = `<td colspan="7" class="py-3 px-6 text-center text-gray-500">검색 결과가 없습니다.</td>`;
            loanTableBody.appendChild(noDataRow);
            return;
        }

        loans.forEach(loan => {
            const row = document.createElement('tr');
            row.classList.add('border-b', 'border-gray-200', 'hover:bg-gray-100'); // Tailwind CSS 클래스 추가

            row.innerHTML = `
                <td class="py-3 px-6 text-left whitespace-nowrap">${loan.id}</td>
                <td class="py-3 px-6 text-left">${loan.productName}</td>
                <td class="py-3 px-6 text-left">${loan.bankName}</td>
                <td class="py-3 px-6 text-left">${loan.loanType}</td>
                <td class="py-3 px-6 text-left">${loan.interestRate}%</td>
                <td class="py-3 px-6 text-left">${loan.maxLimit.toLocaleString()}</td>
                <td class="py-3 px-6 text-left">${loan.loanTermMonth}</td>
            `;
            loanTableBody.appendChild(row);
        });
    }
});
