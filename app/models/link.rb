require 'uri'

class Link < ActiveRecord::Base
  before_validation :valid_link?

  belongs_to :user

  validates :url, presence: true
  validates :title, presence: true

  # validates :url, :url => true

  def valid_link?
    uri = URI.parse(self.url.split(" ")[0])
    self.url = uri
    if !%w( http https ).include?(uri.scheme)
      self.url = nil
    end
  end

  def self.send_link_email(link_params)
    if link_params['url'].include?('cc')
      UserNotifier.send_link_email(link_params['url'].split(' ')[2], link_params['url'].split(' ')[0]).deliver_now
    end
  end
end
