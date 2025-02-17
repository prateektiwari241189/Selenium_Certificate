require 'selenium-webdriver'
require 'rspec'

# Method to initialize a browser
def initialize_browser(browser)
  if browser == :chrome
     $options = Selenium::WebDriver::Options.chrome
    $options.browser_version = "108.0"
    $options.platform_name = "Windows 10"
    lt_options = {};
    lt_options[:username] = "prateektiwari241189";
    lt_options[:accessKey] = "LT_YyhB9S6FacoOJ5WjRUWav5tWxilQEuMMaTAxkeQ4zgDWpRP";
    lt_options[:project] = "Untitled";
    lt_options[:sessionName] = "Ruby Test";
    lt_options[:build] = "Ruby Job";
    lt_options[:w3c] = true;
    lt_options[:plugin] = "ruby-ruby";
    $options.add_option('LT:Options', lt_options);

    $driver = Selenium::WebDriver.for(:remote,
    :url => "https://hub.lambdatest.com/wd/hub",
    :capabilities => $options)
  elsif browser == :safari
    $options = Selenium::WebDriver::Options.safari
    $options.browser_version = "latest"
    $options.platform_name = "macOS Catalina"
    lt_options = {};
    lt_options[:username] = "prateektiwari241189";
    lt_options[:accessKey] = "LT_YyhB9S6FacoOJ5WjRUWav5tWxilQEuMMaTAxkeQ4zgDWpRP";
    lt_options[:project] = "Untitled";
    lt_options[:sessionName] = "Ruby Test";
    lt_options[:build] = "Ruby Job";
    lt_options[:w3c] = true;
    lt_options[:plugin] = "ruby-ruby";
    $options.add_option('LT:Options', lt_options);

    $driver = Selenium::WebDriver.for(:remote,
    :url => "https://hub.lambdatest.com/wd/hub",
    :capabilities => $options)
  else
    raise "Browser not supported"
  end
end

# Define a test block to run for both browsers
def run_browser_test(browser)
  driver = initialize_browser(browser)

  begin
    driver.navigate.to "https://www.lambdatest.com/selenium-playground/"
    sleep(10)
    link_text = driver.find_element(:xpath, "//a[text()='Simple Form Demo']")
    link_text.click
    sleep(10)
    url = driver.current_url 
    url_contains = url[47,60]
    expected_url = "simple-form-demo"
    url_contains == expected_url ? status = "passed" : status = "failed"
    enter_text = driver.find_element(:xpath, "//p[text()='Enter Message']/../..//input")
    enter_text.send_keys("test it")
    click_button = driver.find_element(:xpath,"//button[text()='Get Checked Value']")
    click_button.click
    entered_text_value = driver.find_element(:xpath,"//label[text()='Your Message: ']/../..//p").text
    puts entered_text_value
    expected_text = "test it"
    entered_text_value == expected_text ? status = "passed" : status = "failed"
    driver.execute_script('lambda-status='+ status)
    print("Execution Successful\n")
  ensure
    print("Execution Successful\n")
    driver.quit
  end
end

def run_browser_test1(browser)
  driver = initialize_browser(browser)
  begin
    driver.navigate.to "https://www.lambdatest.com/selenium-playground/"
    sleep(10)
    link_text = driver.find_element(:xpath, "//a[text()='Input Form Submit']")
    link_text.click
    sleep(10)
    click_button = driver.find_element(:xpath,"//button[text()='Submit']")
    click_button.click
    puts "Please fill this field"
    enter_text = driver.find_element(:xpath, "//label[text()='Name*']/../..//input")
    enter_text.send_keys("test it")
    enter_email = driver.find_element(:xpath, "//input[@id='inputEmail4']")
    enter_email.send_keys("pt@gmail.com")
    enter_password = driver.find_element(:xpath, "//input[@id='inputPassword4']")
    enter_password.send_keys("1234")
    enter_company = driver.find_element(:xpath, "//input[@id='company']")
    enter_company.send_keys("test")
    enter_website = driver.find_element(:xpath, "//input[@id='websitename']")
    enter_website.send_keys("www.test.com")
    enter_country = driver.find_element(:xpath, "//select[@name='country']//option[text()='United States']")
    enter_country.click
    enter_city = driver.find_element(:xpath, "//input[@id='inputCity']")
    enter_city.send_keys("Denver")
    enter_address1 = driver.find_element(:xpath, "//input[@id='inputAddress1']")
    enter_address1.send_keys("Denver")
    enter_address2 = driver.find_element(:xpath, "//input[@id='inputAddress2']")
    enter_address2.send_keys("Denver")
    enter_state = driver.find_element(:xpath, "//input[@id='inputState']")
    enter_state.send_keys("Denver")
    enter_zip = driver.find_element(:xpath, "//input[@id='inputZip']")
    enter_zip.send_keys("12345")
    click_button = driver.find_element(:xpath,"//button[text()='Submit']")
    click_button.click
    sucess_text = "Thanks for contacting us, we will get back to you shortly."
    actual_successs_text = driver.find_element(:xpath, "//p[text()='Thanks for contacting us, we will get back to you shortly.']").text
    puts actual_successs_text
    sucess_text == actual_successs_text ? status = "passed" : status = "failed"
    driver.execute_script('lambda-status='+ status)

  ensure
    print("Execution Successful\n")
    driver.quit
  end
end

def run_browser_test2(browser)
  driver = initialize_browser(browser)
  begin
    driver.navigate.to "https://www.lambdatest.com/selenium-playground/"
    sleep(10)
    link_text = driver.find_element(:xpath,"//a[text()='Drag & Drop Sliders']")
    link_text.click
    sleep(10)
    slider_path_tobe = driver.find_element(:xpath,"(//h4[text()=' Default value 15']/../..//input)[1]")
    driver.action.drag_and_drop_by(slider_path_tobe, 212, 120).perform
    expected_range = "95"
    actual_range = driver.find_element(:xpath,"(//h4[text()=' Default value 15']/../..//output)[1]").text
    puts actual_range
    expected_range == actual_range ? status = "passed" : status = "failed"
    driver.execute_script('lambda-status='+ status)
    print("Execution Successful\n")
  ensure
    print("Execution Successful\n")
    driver.quit
  end
end

# Run tests in parallel using threads
RSpec.describe "Parallel Browser Tests" do
  it "Enter Message in simple demo form and verify it is correct" do
    threads = []
    browsers = [:chrome, :safari]  # List of browsers to run tests on

    browsers.each do |browser|
      threads << Thread.new do
        run_browser_test(browser)
      end
    end

    threads.each(&:join)  # Wait for all threads to finish
  end
end

RSpec.describe "Parallel Browser Tests 1" do
  it "Submit the form with all the mandatory details" do
    threads = []
    browsers = [:chrome, :safari]  # List of browsers to run tests on

    browsers.each do |browser|
      threads << Thread.new do
        run_browser_test1(browser)
      end
    end

    threads.each(&:join)  # Wait for all threads to finish
  end
end

RSpec.describe "Parallel Browser Tests 2" do
  it "Use slider to select the correct value" do
    threads = []
    browsers = [:chrome, :safari]  # List of browsers to run tests on

    browsers.each do |browser|
      threads << Thread.new do
        run_browser_test2(browser)
      end
    end

    threads.each(&:join)  # Wait for all threads to finish
  end
end
