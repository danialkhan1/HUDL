require "test/unit/assertions"
include Test::Unit::Assertions
require 'selenium-webdriver'
require 'yaml'


class HUDL_home_page

  ##locators##

  #navigation bar

  @@downarrow = 'hui-globaluseritem__arrow'
  @@logout = "[data-qa-id='webnav-usermenu-logout']"

  ##config file##
  @@config = YAML.load_file '../Config/config.yml'
  @@hudlhomepage = 'hudlHomePage'

  @chromedriver

  def initialize(driver)

    @chromedriver = driver


  end

  def VerifyPage()

    actualURL = @chromedriver.current_url
    validation = Assert.new

    result = validation.ValidateURL @chromedriver, @@config[@@hudlhomepage]
    assert_equal(true, result, "Incorrect URL loaded, URL opened was #{@chromedriver.current_url}")

  end

 def LogOut()

   @chromedriver.find_element(:class, @@downarrow).click

   @chromedriver.find_element(:css, @@logout).click

   sleep 5

 end


end