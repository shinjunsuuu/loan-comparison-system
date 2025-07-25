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

	LoanService service = LoanService.getService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("selectedId") != null
                ? req.getParameter("selectedId")
                : req.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/loan/admin");
            return;
        }

        String productName = req.getParameter("productName");
        if (productName == null) {
            Loan loan = service.findById(Integer.parseInt(idParam));
            req.setAttribute("loan", loan);
            req.getRequestDispatcher("/views/edit.jsp").forward(req, resp);
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            String bankName = req.getParameter("bankName");
            String loanType = req.getParameter("loanType");
            Float interestRate = Float.parseFloat(req.getParameter("interestRate"));
            Integer maxLimit = Integer.parseInt(req.getParameter("maxLimit"));
            Integer loanTermMonth = Integer.parseInt(req.getParameter("loanTermMonth"));

            service.updateLoan(id, productName, bankName, loanType, interestRate, maxLimit, loanTermMonth);
            
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            
            out.println("<script>");
            out.println("alert('대출 상품 수정이 완료되었습니다.');");
            out.println("location.href='" + req.getContextPath() + "/loan/admin';");
            out.println("</script>");

            resp.sendRedirect(req.getContextPath() + "/loan/admin");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/loan/admin");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/loan/admin");
    }
}
