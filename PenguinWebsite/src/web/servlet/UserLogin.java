package web.servlet;

import web.dal.UsersDao;
import web.model.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/userlogin")
public class UserLogin extends HttpServlet {
    protected UsersDao usersDao;

    @Override
    public void init() throws ServletException {
        usersDao = UsersDao.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Map for storing messages.
        Map<String, String> messages = new HashMap<String, String>();
        req.setAttribute("messages", messages);
        //Just render the JSP.
        req.getRequestDispatcher("/Login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Map for storing messages.
        Map<String, String> messages = new HashMap<String, String>();
        req.setAttribute("messages", messages);

        String userName = req.getParameter("username");
        String password = req.getParameter("password");
        String status = req.getParameter("status");
        if(userName == null || userName.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                status == null || status.trim().isEmpty()){
            messages.put("login", "Invalid UserName Or Password Or Status");
        }else {
            try {
                Users user = new Users(userName,password,Users.Status.valueOf(status));
                Users resultUser = usersDao.getUserByUserNamePasswordStatus(user);
                if (resultUser != null){
                    messages.put("login", "Login Successful");
                    //req.getRequestDispatcher("/index.jsp").forward(req,resp);
                }else {
                    messages.put("login", "Incorrect UserName Or Password Or Status");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        req.getRequestDispatcher("/Login.jsp").forward(req,resp);
    }
}
