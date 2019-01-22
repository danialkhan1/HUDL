require "test/unit/assertions"
include Test::Unit::Assertions
require 'selenium-webdriver'
require 'yaml'

class HUDL_en_gb_page

  ##config file##
  @@config = YAML.load_file '../Config/config.yml'
  @@hudlengbpage = 'hudlEngbPage'

  @chromedriver

  def initialize(driver)

    @chromedriver = driver

  end

  def VerifyPage()

    actualURL = @chromedriver.current_url
    validation = Assert.new

    result = validation.ValidateURL @chromedriver, @@config[@@hudlengbpage]
    assert_equal(true, result, "Incorrect URL loaded, URL opened was #{@chromedriver.current_url}")

  end


end