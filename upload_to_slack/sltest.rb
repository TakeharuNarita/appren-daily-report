require 'selenium-webdriver'
 
# Firefoxを起動
driver = Selenium::WebDriver.for(:chrome)
# 指定したURLに遷移
driver.get('https://www.google.co.jp/')

loop do
  # 1秒待機
  sleep 10
end
