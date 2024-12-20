package librarymanagementsystem;

import javax.swing.JFrame;
import javax.swing.SwingUtilities;
import java.awt.Window;
import jframe.AboutPage;
import jframe.DefaultersList;
import jframe.HomePage;
import jframe.IssueBook;
import jframe.IssueBookDetails;
import jframe.LoginPage;
import jframe.ManageBooks;
import jframe.ManageStudents;
import jframe.ReturnBook;
import jframe.SignUpPage;
import jframe.ViewAllRecord;

public class LibraryManagementSystem {

    public static void main(String[] args) {
        // Ensure UI is created and updated on the Event Dispatch Thread (EDT)
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                // Launch the SignUpPage first
                showSignUpPage();
            }
        });
    }

    // Show Sign Up Page
    private static void showSignUpPage() {
        SignUpPage signUpPage = new SignUpPage();
        signUpPage.setVisible(true);  // Make sure the sign-up page is visible
        setupFrame(signUpPage, "Library Management System - Sign Up");
    }

    // Show the Login Page after successful sign up
    public static void showLoginPage() {
        JFrame currentFrame = getCurrentFrame();
        if (currentFrame != null) {
            currentFrame.dispose(); // Close the current frame
        }

        LoginPage loginPage = new LoginPage();
        setupFrame(loginPage, "Library Management System - Login");
    }

    // After successful login, transition to HomePage
    public static void showHomePage(int userId, String username, String userType) {
        JFrame currentFrame = getCurrentFrame();
        if (currentFrame != null) {
            currentFrame.dispose(); // Close the current frame
        }

        HomePage homePage = new HomePage(userId, username, userType);
        setupFrame(homePage, "Library Management System - Home");
    }

    // Method to show other pages (like Defaulters List, Manage Books, etc.)
    public static void showDefaultersList(int userId, String username, String userType) {
        JFrame currentFrame = getCurrentFrame();
        if (currentFrame != null) {
            currentFrame.dispose();
        }

        DefaultersList defaultersList = new DefaultersList(userId, username, userType);
        setupFrame(defaultersList, "Defaulters List");
    }

    public static void showManageBooksPage(int userId, String username, String userType) {
        JFrame currentFrame = getCurrentFrame();
        if (currentFrame != null) {
            currentFrame.dispose();
        }

        ManageBooks manageBooks = new ManageBooks(userId, username, userType);
        setupFrame(manageBooks, "Manage Books");
    }

    // Utility method to get the current frame
    private static JFrame getCurrentFrame() {
        // Loops through all open frames
        for (Window window : JFrame.getWindows()) {
            if (window instanceof JFrame) {
                JFrame frame = (JFrame) window;
                if (frame.isVisible()) {
                    return frame; // Return the current visible JFrame
                }
            }
        }
        return null;
    }

    // Utility method to set up the frame properties (maximized, centered, etc.)
    private static void setupFrame(JFrame frame, String title) {
        frame.setTitle(title);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setExtendedState(JFrame.MAXIMIZED_BOTH);  // Make it fullscreen
        frame.setResizable(true); // Allow resizing
        frame.setLocationRelativeTo(null); // Center the window
        frame.setVisible(true);
    }
}
