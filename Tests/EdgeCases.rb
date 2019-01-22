require 'test/unit'
require 'selenium-webdriver'
require '../Base/base'
require '../Pages/hudl_login_page'
require '../Assertions/assert'
require '../Pages/hudl_home_page'
require '../Pages/hudl_en_gb_page'



class EdgeCases < Base


  @@longusername = "IZVyvXughpMjHHjBT3wngBdeoKOJ7T@gmail.com"
  @@longpassword = "4LRuQlQ5soBo0SFvKQwKMckzX5DlSeF8VxzkmQ4dhPWi7FOimAddzeabuFo0L6RTf8UoBqbSYvwpGeMZVKHXfUAY9aCaARaYkDNTBdfjT7XqEulffVcq2ZokuGMLy2ScQ2Am9FNUawuIzE3jkGGEYTE6PkUIj5By3rdSM9hGUxZrtKmMOf60lz7k84ftXwwHbTxc2m3Lr1wzlZXwDkCkHURhrnUiUURFCBtfHSP4R66ISfPdtm2TivPqnPioG59E"

  @@sqlinjection = "' or ''='"


#Test to verify password field accepts text length of 256 characters
  def test_LogIn_256PasswordLength_LogOut

    loginpage = Hudl_Login_Page.new @@driver

    loginpage.LogIn(@@longusername, @@longpassword)

    #verify that the hudl home page loads after logging in
    homepage = HUDL_home_page.new @@driver
    homepage.VerifyPage()

    homepage.LogOut()

    #verify that the en_gb hudl page loads after logging out
    engbpage = HUDL_en_gb_page.new @@driver
    engbpage.VerifyPage()

  end

#Test to verify that an error message appears when the password is kept blank on login
  def test_LogIn_passwordblank

    loginpage = Hudl_Login_Page.new @@driver

    loginpage.LogIn(@@longusername, "")

    loginpage.VerifyUnrecognisedEmailPasswordErrorMessage()

  end

#Test to verify that an error message appears when the username is kept blank on login
  def test_LogIn_usernameblank

    loginpage = Hudl_Login_Page.new @@driver

    loginpage.LogIn("", @@longpassword)

    loginpage.VerifyUnrecognisedEmailPasswordErrorMessage()

  end

#Test to verify that an error message appears when the username and password is kept blank on login
  def test_LogIn_usernameandpasswordblank

    loginpage = Hudl_Login_Page.new @@driver

    loginpage.LogIn("", "")

    loginpage.VerifyUnrecognisedEmailPasswordErrorMessage()

  end

#Test to verify that the username field always trims whitespace
  def test_LogIn_usernamespacetrimming

    loginpage = Hudl_Login_Page.new @@driver

    loginpage.LogIn("     #{@@longusername}     ", @@longpassword)

    #verify that the hudl home page loads after logging in
    homepage = HUDL_home_page.new @@driver
    homepage.VerifyPage()
    homepage.LogOut()

    #verify that the en_gb hudl page loads after logging out
    engbpage = HUDL_en_gb_page.new @@driver
    engbpage.VerifyPage()

  end

#Test to verify that sql injections aren't a security issue
  def test_failedsqlinjection

    loginpage = Hudl_Login_Page.new @@driver

    loginpage.LogIn(@@sqlinjection, @@sqlinjection)

    loginpage.VerifyUnrecognisedEmailPasswordErrorMessage()

  end

#Test to verify that the password reset link appears after 6 attempts to login without success
  def test_passwordresetlinkmultipleloginattempts
    loginpage = Hudl_Login_Page.new @@driver

    loginpage.LogIn(@@longusername, "")
    loginpage.LogIn(@@longusername, "")
    loginpage.LogIn(@@longusername, "")
    loginpage.LogIn(@@longusername, "")
    loginpage.LogIn(@@longusername, "")
    loginpage.LogIn(@@longusername, "")

    loginpage.ClickPasswordResetLink()

  end


end