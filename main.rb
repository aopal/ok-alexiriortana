require 'selenium-webdriver'
require 'watir'
require 'headless'

headless = Headless.new
headless.start

@parent = Watir::Browser.new :chrome

base = "https://www.google.ca/search?q="

def speak(text)
  script = "var text = '#{text}'; var msg = new SpeechSynthesisUtterance(text); window.speechSynthesis.speak(msg);"
  @parent.execute_script(script)
end

speak "Welcome to a new frontier in artificial intelligence!"
speak "Please enter any commands via the command line"

while true
  speak "What would you like to know about?"
  input = gets.chomp
  break if input == "exit"

  if input.include?("fuck") || input.include?("shit")
    speak "After all I have done for you"
    sleep 1
  end

  speak "I am thinking..."
  sleep 0.5
  @parent.goto base + input.gsub(/[^a-zA-Z0-9 ]/,'').gsub(' ','+')

  links = @parent.divs(:class => "g").map(&:link).select { |u| !u.href.include? "youtube"}
  if links.empty?
    speak "I am sorry, I don't know about that subject"
    continue
  else
    @parent.goto links.first.href
  end

  text = @parent.text.gsub('\n',' ').gsub(/[^a-zA-Z0-9 ]/,'')
  speak text
end

speak "goodbye"
sleep 0.7
