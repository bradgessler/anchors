require 'spec_helper'

describe Anchors do
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      use Anchors::Middleware

      run lambda { |env|
        [200, {"Content-Type" => "text/html"}, [
          "<html>
          <head>
            <title>Hi</title>
          </head>
          <body>
            <h1>How are you?</h1>
            <h2>I am fine<img src='hi.gif'/></h2>
            <h3>How are you?</h3>
          </body>
          </html>"
        ]]
      }
    end
  end
  before { get "/" }
  it "adds anchors to h1-h6 tags" do
    expect(last_response.body).to include('<h1 id="how_are_you"><a href="#how_are_you">How are you?</a></h1>')
  end
  it "adds 1 to repeat anchor name" do
    expect(last_response.body).to include('<h3 id="how_are_you_2"><a href="#how_are_you_2">How are you?</a></h3>')
  end
  it "adds h children to link" do
    expect(last_response.body).to include('<h2 id="i_am_fine"><a href="#i_am_fine">I am fine<img src="hi.gif"></a></h2>')
  end
end
