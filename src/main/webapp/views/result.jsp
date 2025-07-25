<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- JSTL 라이브러리의 URI를 최신 jakarta.tags.core로 변경 --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대출 상품 검색 결과</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Fonts (Inter) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        /* Inter 폰트 적용 */
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">
    <!-- Header Section -->
    <header class="bg-blue-600 text-white p-4 shadow-md rounded-b-lg">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-3xl font-bold">대출 금리 비교 시스템</h1>
            <nav>
                <ul class="flex space-x-4">
                    <%-- 컨텍스트 경로를 포함한 절대 경로로 수정 --%>
                    <li><a href="${pageContext.request.contextPath}/loan/list" class="hover:text-blue-200 transition duration-300">홈</a></li>
                    <li><a href="#" class="hover:text-blue-200 transition duration-300">상품 추가</a></li>
                    <li><a href="#" class="hover:text-blue-200 transition duration-300">문의</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <!-- Main Content Area -->
    <main class="container mx-auto mt-8 p-6 bg-white rounded-lg shadow-xl flex-grow">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-gray-800">대출 상품 검색 결과</h2>
            <a href="${pageContext.request.contextPath}/loan/list" class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded-lg transition duration-300">
                &larr; 전체 목록으로 돌아가기
            </a>
        </div>
        
        <!-- 검색 조건 표시 (선택 사항) -->
        <div class="mb-8 p-4 bg-gray-50 rounded-lg shadow-inner text-gray-700">
            <h3 class="font-bold text-lg mb-2">검색 조건</h3>
            <p><strong>은행명:</strong> ${not empty param.bankName ? param.bankName : '전체'}</p>
            <p><strong>대출 종류:</strong> ${not empty param.loanType ? param.loanType : '전체'}</p>
            <p><strong>최대 금리:</strong> ${not empty param.interestRate ? param.interestRate : '제한 없음'}%</p>
        </div>


        <!-- Loan Products Table -->
        <div class="overflow-x-auto">
            <table class="min-w-full bg-white border border-gray-200 rounded-lg shadow-md">
                <thead>
                    <tr class="bg-gray-200 text-gray-700 uppercase text-sm leading-normal">
                        <th class="py-3 px-6 text-left rounded-tl-lg">ID</th>
                        <th class="py-3 px-6 text-left">상품명</th>
                        <th class="py-3 px-6 text-left">은행명</th>
                        <th class="py-3 px-6 text-left">대출 종류</th>
                        <th class="py-3 px-6 text-left">적용 금리 (%)</th>
                        <th class="py-3 px-6 text-left">최대 한도 (만원)</th>
                        <th class="py-3 px-6 text-left rounded-tr-lg">대출 기간 (개월)</th>
                    </tr>
                </thead>
                <tbody class="text-gray-600 text-sm font-light">
                    <%-- 
                        Controller에서 'searchResultList'라는 이름으로 전달된 검색 결과 데이터를
                        JSTL의 c:forEach 태그를 사용하여 반복 출력합니다.
                        만약 리스트가 비어있다면, "검색 결과가 없습니다." 라는 메시지를 표시합니다.
                    --%>
                    <c:choose>
                        <c:when test="${not empty searchResultList}">
                            <c:forEach var="loan" items="${searchResultList}">
                                <tr class="border-b border-gray-200 hover:bg-gray-100">
                                    <td class="py-3 px-6 text-left whitespace-nowrap">${loan.id}</td>
                                    <td class="py-3 px-6 text-left">${loan.productName}</td>
                                    <td class="py-3 px-6 text-left">${loan.bankName}</td>
                                    <td class="py-3 px-6 text-left">${loan.loanType}</td>
                                    <td class="py-3 px-6 text-left">${loan.interestRate}%</td>
                                    <td class="py-3 px-6 text-left">${loan.maxAmount}</td>
                                    <td class="py-3 px-6 text-left">${loan.loanPeriod}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" class="py-4 px-6 text-center text-gray-500">검색된 대출 상품이 없습니다.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </main>

    <!-- Footer Section -->
    <footer class="bg-gray-800 text-white p-4 mt-8 rounded-t-lg">
        <div class="container mx-auto text-center text-sm">
            &copy; 2025 대출 금리 비교 시스템. 모든 권리 보유.
        </div>
    </footer>
</body>
</html>
