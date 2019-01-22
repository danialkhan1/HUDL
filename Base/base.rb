require 'selenium-webdriver'
require 'yaml'
require 'test/unit'


class Base < Test::Unit::TestCase

  def setup

    puts "test started"

    config = YAML.load_file '../Config/config.yml'
    @@browser = config['browser']

    if @@browser == "chrome"
      Selenium::WebDriver::Chrome.driver_path="../Drivers/chromedriver.exe"
      @@driver = Selenium::WebDriver.for :chrome

    elsif @@browser == "firefox"
      Selenium::WebDriver::Firefox.driver_path="../Drivers/geckodriver.exe"
      @@driver = Selenium::WebDriver.for :firefox
    else
      Selenium::WebDriver::Chrome.driver_path="../Drivers/chromedriver.exe"
      @@driver = Selenium::WebDriver.for :chrome

    end

    @@driver.get(config['hudlLoginPage'])
    @@driver.manage.window.maximize
    @@driver.manage.timeouts.implicit_wait = 10

  end


  def teardown

    @@driver.quit
    puts "test complete"

  end



end