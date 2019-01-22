require 'test/unit'
require 'selenium-webdriver'
require '../Base/base'
require '../Pages/hudl_login_page'
require '../Assertions/assert'
require '../Pages/hudl_home_page'
require '../Pages/hudl_en_gb_page'



class HappyPath < Base


 @@validusername = "danial.khan@ucl.ac.uk"
 @@validpassword = "H@lc10n!"
 @@invalidusername = "dan.khan@email"
 @@invalidpassword = "password123"


#Test to verify that valid credentials can be successfully used to login
 def test_LogIn_ValidCredentials

   loginpage = Hudl_Login_Page.new @@driver

   loginpage.LogIn(@@validusername, @@validpassword)

   homepage = HUDL_home_page.new @@driver
   homepage.VerifyPage()

 end

#Test to verify that invalid credentials will not allow users to login
 def test_LogIn_InvalidCredentials

   loginpage = Hudl_Login_Page.new @@driver

   loginpage.LogIn(@@invalidusername, @@invalidpassword)

   loginpage.VerifyPage()

 end

#Test to verify that a user can login and then log out
 def test_LogIn_LogOut

   loginpage = Hudl_Login_Page.new @@driver

   loginpage.LogIn(@@validusername, @@validpassword)

   #verify that the hudl home page loads after logging in
   homepage = HUDL_home_page.new @@driver
   homepage.VerifyPage()

   homepage.LogOut()

   #verify that the en_gb hudl page loads after logging out
   engbpage = HUDL_en_gb_page.new @@driver
   engbpage.VerifyPage()

 end

#Test to verify that the need help link navigates to the password reset container page
 def test_NeedHelpLink

   loginpage = Hudl_Login_Page.new @@driver

   loginpage.ClickNeedHelp()

 end


end