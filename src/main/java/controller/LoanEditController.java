package controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.entity.Loan;
import service.LoanService;

@WebServlet("/loan/edit")
public class LoanEditController extends HttpServlet {

    private LoanService service = new LoanService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(req.getParameter("id"));
            String productName = req.getParameter("productName");
            String bankName = req.getParameter("bankName");
            String loanType = req.getParameter("loanType");
            Double interestRate = Double.parseDouble(req.getParameter("interestRate"));
            Integer maxLimit = Integer.parseInt(req.getParameter("maxLimit"));
            Integer loanTermMonth = Integer.parseInt(req.getParameter("loanTermMonth"));

            // 서비스 로직 수행
            service.updateLoan(id, productName, bankName, loanType, interestRate, maxLimit, loanTermMonth);

            // 성공 시 목록으로 이동
            resp.sendRedirect(req.getContextPath() + "/search");

        } catch (Exception e) {
            // alert 창 띄우고 목록으로 이동
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('상품 수정 중 오류가 발생했습니다.\\n다시 시도해 주세요.');");
            out.println("location.href='" + req.getContextPath() + "/search';");
            out.println("</script>");
        }
    }
}
