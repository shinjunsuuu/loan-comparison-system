// DOM 컨텐츠가 모두 로드되면 스크립트를 실행합니다.
document.addEventListener('DOMContentLoaded', function() {
    // HTML 요소들을 변수에 할당합니다.
    var searchButton = document.getElementById('searchButton');
    var bankNameInput = document.getElementById('bankName');
    var loanTypeInput = document.getElementById('loanType');
    var interestRateInput = document.getElementById('interestRate');
    var loanTableBody = document.getElementById('loanTableBody');

    // 페이지가 처음 로드될 때 모든 대출 상품 목록을 가져옵니다.
    fetchLoans();

    // '검색하기' 버튼에 클릭 이벤트 리스너를 추가합니다.
    // 참고: form 태그를 사용하신다면 버튼 클릭 시 자동으로 form이 제출될 수 있습니다.
    // 이 스크립트는 form 제출이 아닌, 버튼 클릭으로 API를 호출하는 방식입니다.
    // HTML의 검색 버튼 타입을 'button'으로 지정하는 것이 좋습니다. <button type="button" id="searchButton">
    if (searchButton) {
        searchButton.addEventListener('click', function(event) {
            // form 태그 안의 button은 기본적으로 submit 동작을 하므로 이를 방지합니다.
            event.preventDefault(); 
            fetchLoans();
        });
    }


    // 서버로부터 대출 상품 데이터를 가져오는 함수입니다.
    function fetchLoans() {
        // 입력 필드에서 검색 조건을 가져옵니다.
        var bankName = bankNameInput.value;
        var loanType = loanTypeInput.value;
        var interestRate = interestRateInput.value;

        // URL 쿼리 파라미터를 생성합니다.
        var queryParams = new URLSearchParams();
        if (bankName) {
            queryParams.append('bankName', bankName);
        }
        if (loanType) {
            queryParams.append('loanType', loanType);
        }
        if (interestRate) {
            // 백엔드와 파라미터 이름을 일치시켜야 합니다. (예: maxInterestRate)
            queryParams.append('interestRate', interestRate);
        }

        // 백엔드 API 엔드포인트 URL을 생성합니다.
        // 현재 페이지를 기준으로 상대 경로를 사용하는 것이 더 안정적입니다.
        var apiUrl = 'loan/search?' + queryParams.toString();
        
        // fetch API를 사용하여 서버에 데이터를 요청합니다.
        fetch(apiUrl)
            .then(function(response) {
                // 응답이 성공적이지 않으면 에러를 발생시킵니다.
                if (!response.ok) {
                    throw new Error('HTTP error! status: ' + response.status);
                }
                // 응답 본문을 JSON 형태로 파싱하여 반환합니다.
                return response.json();
            })
            .then(function(loans) {
                // 파싱된 데이터를 테이블에 표시합니다.
                displayLoans(loans);
            })
            .catch(function(error) {
                // 데이터 요청 중 에러가 발생하면 콘솔에 로그를 남기고 사용자에게 알립니다.
                console.error('대출 상품 데이터를 가져오는 중 오류 발생:', error);
                loanTableBody.innerHTML = ''; // 오류 발생 시 테이블 비우기
                var errorRow = document.createElement('tr');
                errorRow.innerHTML = '<td colspan="7" class="py-3 px-6 text-center text-red-500">데이터를 불러오는 데 실패했습니다. 서버 로그를 확인해주세요.</td>';
                loanTableBody.appendChild(errorRow);
            });
    }

    // 가져온 대출 상품 목록을 HTML 테이블에 표시하는 함수입니다.
    function displayLoans(loans) {
        // 테이블의 기존 내용을 모두 비웁니다.
        loanTableBody.innerHTML = '';

        // 검색 결과가 없을 경우 메시지를 표시합니다.
        if (!loans || loans.length === 0) {
            var noDataRow = document.createElement('tr');
            noDataRow.innerHTML = '<td colspan="7" class="py-3 px-6 text-center text-gray-500">검색 결과가 없습니다.</td>';
            loanTableBody.appendChild(noDataRow);
            return;
        }

        // 각 대출 상품에 대해 테이블 행(row)을 생성합니다.
        loans.forEach(function(loan) {
            var row = document.createElement('tr');
            row.className = 'border-b border-gray-200 hover:bg-gray-100'; // className으로 클래스 설정

            // 각 행에 들어갈 셀(cell)들의 HTML을 생성합니다.
            // ES5 호환을 위해 문자열을 + 연산자로 연결합니다.
            row.innerHTML =
                '<td class="py-3 px-6 text-left whitespace-nowrap">' + (loan.id || '') + '</td>' +
                '<td class="py-3 px-6 text-left">' + (loan.productName || '') + '</td>' +
                '<td class="py-3 px-6 text-left">' + (loan.bankName || '') + '</td>' +
                '<td class="py-3 px-6 text-left">' + (loan.loanType || '') + '</td>' +
                '<td class="py-3 px-6 text-left">' + (loan.interestRate !== undefined ? loan.interestRate + '%' : '') + '</td>' +
                '<td class="py-3 px-6 text-left">' + (loan.maxLimit !== undefined ? loan.maxLimit.toLocaleString() + '만원' : '') + '</td>' +
                '<td class="py-3 px-6 text-left">' + (loan.loanTermMonth || '') + '</td>';
            
            // 완성된 행을 테이블 본문에 추가합니다.
            loanTableBody.appendChild(row);
        });
    }
});
