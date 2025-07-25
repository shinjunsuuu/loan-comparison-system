<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대출 상품 수정</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">
    <!-- Header Section -->
    <header class="bg-blue-600 text-white p-4 shadow-md rounded-b-lg">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-3xl font-bold">대출 금리 비교 시스템</h1>
            <nav>
                <ul class="flex space-x-4">
                    <li><a href="../index.html" class="hover:text-blue-200 transition duration-300">홈</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <!-- Main Content Area -->
    <main class="container mx-auto mt-8 p-6 bg-white rounded-lg shadow-xl flex-grow">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-gray-800">대출 상품 수정</h2>
            <a href="${pageContext.request.contextPath}/loan/admin" class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded-lg transition duration-300">
                &larr; 관리 페이지로 돌아가기
            </a>
        </div>

        <!-- 수정 폼 -->
        <form action="${pageContext.request.contextPath}/loan/edit" method="post" class="space-y-6">
            <!-- 숨겨진 ID -->
            <input type="hidden" name="id" value="${loan.id}" />

            <div>
                <label class="block text-gray-700 font-semibold mb-2">상품명</label>
                <input type="text" name="productName" value="${loan.productName}"
                       class="w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required />
            </div>

            <div>
                <label class="block text-gray-700 font-semibold mb-2">은행명</label>
                <input type="text" name="bankName" value="${loan.bankName}"
                       class="w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required />
            </div>

            <div>
                <label class="block text-gray-700 font-semibold mb-2">대출 종류</label>
                <input type="text" name="loanType" value="${loan.loanType}"
                       class="w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required />
            </div>

            <div>
                <label class="block text-gray-700 font-semibold mb-2">적용 금리 (%)</label>
                <input type="number" step="0.01" name="interestRate" value="${loan.interestRate}"
                       class="w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required />
            </div>

            <div>
                <label class="block text-gray-700 font-semibold mb-2">최대 한도 (만원)</label>
                <input type="number" name="maxLimit" value="${loan.maxLimit}"
                       class="w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required />
            </div>

            <div>
                <label class="block text-gray-700 font-semibold mb-2">대출 기간 (개월)</label>
                <input type="number" name="loanTermMonth" value="${loan.loanTermMonth}"
                       class="w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required />
            </div>

            <div class="flex justify-end">
                <button type="submit" class="bg-blue-600 hover:bg-blue-800 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
                    수정 완료
                </button>
            </div>
        </form>
    </main>

    <!-- Footer Section -->
    <footer class="bg-gray-800 text-white p-4 mt-8 rounded-t-lg">
        <div class="container mx-auto text-center text-sm">
            &copy; 2025 대출 금리 비교 시스템. 모든 권리 보유.
        </div>
    </footer>
</body>
</html>
