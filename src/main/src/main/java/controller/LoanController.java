package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.entity.Loan;
import service.LoanService;

@WebServlet("/search")
public class LoanController extends HttpServlet {

    private LoanService service = new LoanService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String bank = req.getParameter("bank");
        String loanType = req.getParameter("loanType");
        String rateStr = req.getParameter("maxRate");

        Double maxRate = null;
        try {
            if (rateStr != null && !rateStr.isEmpty()) {
                maxRate = Double.parseDouble(rateStr);
            }
        } catch (NumberFormatException e) {
            maxRate = null;
        }

        List<Loan> resultList = service.searchLoans(bank, loanType, maxRate);
        req.setAttribute("resultList", resultList);
        req.getRequestDispatcher("/result.jsp").forward(req, resp);
    }
}
