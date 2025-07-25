package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.entity.Loan;
import service.LoanService;

@WebServlet("/loan/search")
public class LoanSearchController extends HttpServlet {

	LoanService service = LoanService.getService();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String bank = req.getParameter("bankName");
        String loanType = req.getParameter("loanType");
        String rateStr = req.getParameter("interestRate");

        Float interestRate = null;
        try {
            if (rateStr != null && !rateStr.isEmpty()) {
            	interestRate = Float.parseFloat(rateStr);
            }
        } catch (NumberFormatException e) {
        	resp.setContentType("text/html; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<script>alert('숫자를 입력해주세요!'); history.back();</script>");
            out.close();
        }

        List<Loan> resultList = service.searchLoans(bank, loanType, interestRate);
        req.setAttribute("resultList", resultList);
        req.getRequestDispatcher("/views/result.jsp").forward(req, resp);
    }
}