<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대출 금리 비교 시스템</title>
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
                    <li><a href="#" class="hover:text-blue-200 transition duration-300">홈</a></li>
                    <li><a href="#" class="hover:text-blue-200 transition duration-300">상품 추가</a></li>
                    <li><a href="#" class="hover:text-blue-200 transition duration-300">문의</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <!-- Main Content Area -->
    <main class="container mx-auto mt-8 p-6 bg-white rounded-lg shadow-xl flex-grow">
        <h2 class="text-2xl font-semibold text-gray-800 mb-6">대출 상품 검색 및 필터링</h2>

        <!-- Search/Filter Section -->
        <!-- 검색 기능은 Controller와 연동하여 구현해야 합니다. -->
        <form action="<c:url value='/loan/search' />" method="get">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8 p-4 bg-blue-50 rounded-lg shadow-inner">
                <div>
                    <label for="bankName" class="block text-gray-700 text-sm font-bold mb-2">은행명:</label>
                    <input type="text" id="bankName" name="bankName" placeholder="예: 국민은행" class="shadow appearance-none border rounded-lg w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label for="loanType" class="block text-gray-700 text-sm font-bold mb-2">대출 종류:</label>
                    <input type="text" id="loanType" name="loanType" placeholder="예: 신용대출" class="shadow appearance-none border rounded-lg w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label for="interestRate" class="block text-gray-700 text-sm font-bold mb-2">최대 금리 (%):</label>
                    <input type="number" id="interestRate" name="interestRate" placeholder="예: 5.0" step="0.1" class="shadow appearance-none border rounded-lg w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div class="md:col-span-3 text-center mt-4">
                    <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded-lg focus:outline-none focus:shadow-outline transition duration-300">
                        검색하기
                    </button>
                </div>
            </div>
        </form>

        <h2 class="text-2xl font-semibold text-gray-800 mb-6">대출 상품 목록</h2>

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
                    <!-- 
                        Controller에서 'loanList'라는 이름으로 전달된 ArrayList<Loan> 데이터를
                        JSTL의 c:forEach 태그를 사용하여 반복 출력합니다.
                        만약 리스트가 비어있다면, "등록된 상품이 없습니다." 라는 메시지를 표시합니다.
                    -->
                    <c:choose>
                        <c:when test="${not empty loanList}">
                            <c:forEach var="loan" items="${loanList}" varStatus="status">
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
                                <td colspan="7" class="py-4 px-6 text-center text-gray-500">등록된 대출 상품이 없습니다.</td>
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