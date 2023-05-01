# frozen_string_literal: true

require 'selenium-webdriver'
# @param none
class Sltest
  def main
    driver = Selenium::WebDriver.for(:chrome)
    driver.get('https://www.google.co.jp/')
    loop do
      sleep 10
    end
  end
end

Sltest.new.main
