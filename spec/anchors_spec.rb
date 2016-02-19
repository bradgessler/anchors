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
            <h2>I am fine</h2>
          </body>
          </html>"
        ]]
      }
    end
  end

  it "adds anchors to h1-h6 tags" do
    get "/"
    expect(last_response.body).to include('<a href="#how_are_you"><h1 id="how_are_you">How are you?</h1></a>')
  end
end
