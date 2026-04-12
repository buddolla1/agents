Feature: User Login

Business Objective:
Allow users to securely access the application.

Description:
This feature enables registered users to log into the system using valid credentials.

Actors:
- Registered User

Preconditions:
- User must be registered
- Login page is accessible

Postconditions:
- User is redirected to dashboard on success

---

Background:
Given the user is on the login page

---

Scenario: Successful login

Given the user enters valid username and password
When the user clicks the login button
Then the user should be redirected to the dashboard

---

Scenario: Invalid login attempt

Given the user enters invalid credentials
When the user clicks the login button
Then an error message should be displayed

---

Edge Cases:
- Empty username/password
- Locked account

---

Non-Functional Requirements:
- Response time < 2 seconds
- Must support 1000 concurrent users
- Secure authentication (OAuth2/JWT)