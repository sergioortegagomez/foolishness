require 'selenium-webdriver'
require 'selenium-cucumber'

caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => [ "--disable-web-security", "--no-sandbox" ]})

$driver = Selenium::WebDriver.for :remote, desired_capabilities: caps
