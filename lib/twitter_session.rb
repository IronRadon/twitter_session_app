require 'launchy'
require 'oauth'
require 'addressible/uri'
require 'singleton'
require 'yaml'

$consumer_key = "WVqDSFGErMtolYXHtpgU3g"
$consumer_secret = "lyv6tPmAkii6JBrqGaHEAjynepSjWuQCZYTVsXFwTY"

$consumer = OAuth::Consumer.new(
    $consumer_key, $consumer_secret, :site => "https://twitter.com")

class TwitterSession
  include Singleton

  attr_reader :access_token

  def request_access_token
    request_token = $consumer.get_request_token
    authorize_url = request_token.authorize_url
    puts "Go Here: #{authorize_url}"
    Launchy.open(authorize_url)
    puts "Login, Enter Verification Code:"
    oauth_verifier = gets.chomp

    @access_token = request_token.get_access_token(
    :oauth_verifier => oauth_verifier)
  end

  def initialize
    request_access_token
  end

  Addressible::URI.new(
                :scheme => "https",
                :host => "api.twitter.com",
                :path => "1.1/statuses/user_timeline.json",
                :query_values => {})

end