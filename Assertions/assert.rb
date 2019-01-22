class Assert

  def ValidateURL(driver, expectedURL)

    result = false

    if(driver.current_url().eql?(expectedURL))

      result = true

    end

    if result == false
      Dir.mkdir("C:\\Screenshots") unless Dir.exist?("C:\\Screenshots")
      time = Time.now.strftime('%Y-%m-%d %H-%M-%S')
      driver.save_screenshot("/Screenshots/InvalidURL#{time}.png")
    end

    return result

  end
end