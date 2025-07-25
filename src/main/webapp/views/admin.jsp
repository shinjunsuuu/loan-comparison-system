<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리 페이지 - 대출 상품 관리</title>

<script src="https://cdn.tailwindcss.com"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">

<style>
body {
	font-family: 'Inter', sans-serif;
}
</style>

</head>
<body class="bg-gray-100 min-h-screen flex flex-col">

	<!-- Header Section -->
	<header class="bg-blue-600 text-white p-4 shadow-md rounded-b-lg">
		<div class="container mx-auto flex justify-between items-center">
			<h1 class="text-3xl font-bold">관리 페이지</h1>
		</div>
	</header>

	<!-- Main Content -->
	<main
		class="container mx-auto mt-8 p-6 bg-white rounded-lg shadow-xl flex-grow">
		<div class="flex justify-between items-center mb-6">
			<h2 class="text-2xl font-semibold text-gray-800">대출 상품 관리</h2>
			<a href="../index.html"
				class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded-lg transition duration-300">
				&larr; 사용자 화면으로 돌아가기 </a>
		</div>

		<!-- 관리 테이블 -->
		<form id="manageForm" method="post">
			<div class="overflow-x-auto">
				<table
					class="min-w-full bg-white border border-gray-200 rounded-lg shadow-md">
					<thead>
						<tr
							class="bg-gray-200 text-gray-700 uppercase text-sm leading-normal">
							<th class="py-3 px-6 text-center">선택</th>
							<th class="py-3 px-6 text-left">상품명</th>
							<th class="py-3 px-6 text-left">은행명</th>
							<th class="py-3 px-6 text-left">대출 종류</th>
							<th class="py-3 px-6 text-left">금리 (%)</th>
							<th class="py-3 px-6 text-left">최대 한도 (만원)</th>
							<th class="py-3 px-6 text-left rounded-tr-lg">대출 기간 (개월)</th>
						</tr>
					</thead>
					
					<tbody class="text-gray-600 text-sm font-light">
						<c:choose>
							<c:when test="${not empty loanList}">
								<c:forEach var="loan" items="${loanList}">
									<tr class="border-b border-gray-200 hover:bg-gray-100">
										<td class="py-3 px-6 text-center">
											<input type="radio" name="selectedId" value="${loan.id}" />
										</td>
										<td class="py-3 px-6 text-left">${loan.productName}</td>
										<td class="py-3 px-6 text-left">${loan.bankName}</td>
										<td class="py-3 px-6 text-left">${loan.loanType}</td>
										<td class="py-3 px-6 text-left">${loan.interestRate}</td>
										<td class="py-3 px-6 text-left">${loan.maxLimit}</td>
										<td class="py-3 px-6 text-left">${loan.loanTermMonth}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="7" class="py-4 px-6 text-center text-gray-500">
										등록된 대출 상품이 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>

			<!-- 버튼 영역 -->
			<div class="flex justify-end mt-6 space-x-4">
				<button type="submit"
					formaction="${pageContext.request.contextPath}/loan/add"
					class="bg-green-600 hover:bg-green-800 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
					추가</button>
				<button type="submit"
					formaction="${pageContext.request.contextPath}/loan/edit"
					class="bg-blue-600 hover:bg-blue-800 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
					수정</button>

				<button type="submit"
					formaction="${pageContext.request.contextPath}/loan/delete"
					class="bg-red-600 hover:bg-red-800 text-white font-bold py-2 px-6 rounded-lg transition duration-300">
					삭제</button>
			</div>
		</form>

	</main>

	<!-- Footer -->
	<footer class="bg-gray-800 text-white p-4 mt-8 rounded-t-lg">
		<div class="container mx-auto text-center text-sm">&copy; 2025
			대출 금리 비교 시스템. 모든 권리 보유.</div>
	</footer>
</body>
</html>
