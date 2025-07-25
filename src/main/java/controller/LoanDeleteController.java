package controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import service.LoanService;

@WebServlet("/loan/delete")
public class LoanDeleteController extends HttpServlet {

	LoanService service = LoanService.getService();
	
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("selectedId");

        if (idParam == null || idParam.isEmpty()) {
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('삭제할 상품을 선택하세요.');");
            out.println("location.href='" + req.getContextPath() + "/loan/admin';");
            out.println("</script>");
            return;
        }

        try {
            Integer id = Integer.parseInt(idParam);

            service.deleteLoan(id);

            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('대출 상품이 삭제되었습니다.');");
            out.println("location.href='" + req.getContextPath() + "/loan/admin';");
            out.println("</script>");

        } catch (Exception e) {
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('삭제 중 오류가 발생했습니다. 다시 시도해주세요.');");
            out.println("location.href='" + req.getContextPath() + "/loan/admin';");
            out.println("</script>");
        }
    }
}
