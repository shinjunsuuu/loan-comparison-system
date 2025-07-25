package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.Loan;
import service.LoanService;

@WebServlet("/loan/admin")
public class LoanAdminController extends HttpServlet {
	
	LoanService service = LoanService.getService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
        List<Loan> loanList = service.findAllLoansSortedByRate();
        req.setAttribute("loanList", loanList);
        req.getRequestDispatcher("/views/admin.jsp").forward(req, resp);
        
    }
    
}
