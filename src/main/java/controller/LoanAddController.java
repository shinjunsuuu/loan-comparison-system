package controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import service.LoanService;

@WebServlet("/loan/add")
public class LoanAddController extends HttpServlet {
	
	LoanService service = LoanService.getService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String productName = req.getParameter("productName");

        if (productName == null) {
            req.getRequestDispatcher("/views/add.jsp").forward(req, resp);
            return;
        }

        try {
            String bankName = req.getParameter("bankName");
            String loanType = req.getParameter("loanType");
            Float interestRate = Float.parseFloat(req.getParameter("interestRate"));
            Integer maxLimit = Integer.parseInt(req.getParameter("maxLimit"));
            Integer loanTermMonth = Integer.parseInt(req.getParameter("loanTermMonth"));

            service.addLoan(productName, bankName, loanType, interestRate, maxLimit, loanTermMonth);

            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('대출 상품이 추가되었습니다.');");
            out.println("location.href='" + req.getContextPath() + "/loan/admin';");
            out.println("</script>");

        } catch (Exception e) {
            e.printStackTrace();
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('상품 추가 중 오류가 발생했습니다. 다시 시도해주세요.');");
            out.println("location.href='" + req.getContextPath() + "/loan/admin';");
            out.println("</script>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/loan/admin");
    }
}
