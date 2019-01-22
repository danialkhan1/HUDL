require "test/unit/assertions"
include Test::Unit::Assertions
require 'selenium-webdriver'
require 'yaml'

class Hudl_Login_Page

  ##locators##

  # textfields
  @@email = "email"
  @@password = "password"

  #buttons
  @@login = "logIn"

  #links
  @@passwordresetlink = "Get a password reset link"
  @@NeedHelp = "forgot-password-link"

  #error messages
  @@passwordemailerrormessage = "login-error-container"

  #containers
  @@passwordresetpagevalidation ="reset-container"

  ##config file##
  @@config = YAML.load_file '../Config/config.yml'
  @@hudlloginpage = 'hudlLoginPage'


  @chromedriver

  def initialize(driver)

    @chromedriver = driver


  end

  def LogIn(username, password)


    VerifyPage()

    #Enters the text 'search' into the wikipedia home page search field
    @chromedriver.find_element(:id, @@email).send_keys(username)

    #Selects the 'language', from the language drop down
    @chromedriver.find_element(:id, @@password).send_keys(password)

    #Clicks the search button
    @chromedriver.find_element(:id, @@login).click

    sleep 5

  end


  #Validate that the log in page has loaded correctly
  def VerifyPage()


    actualURL = @chromedriver.current_url
    validation = Assert.new

    result = validation.ValidateURL @chromedriver, @@config[@@hudlloginpage]
    assert_equal(true, result, "Incorrect URL loaded, URL opened was #{@chromedriver.current_url}")

  end

  def VerifyUnrecognisedEmailPasswordErrorMessage

    IsElementVisible(@@passwordemailerrormessage)
  end

  def ClickPasswordResetLink

    @chromedriver.find_element(:link_text, @@passwordresetlink).click

    sleep 5

    LoginHelp()

  end

  def ClickNeedHelp

    @chromedriver.find_element(:id, @@NeedHelp).click

    IsElementVisible(@@passwordresetpagevalidation)
  end

  def LoginHelp

    IsElementVisible(@@passwordresetpagevalidation)

  end

  #Generic Element Verify Function
  def IsElementVisible(element)
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    element = @chromedriver.find_element(:class, element)
    wait.until { element.displayed? }

  end

end