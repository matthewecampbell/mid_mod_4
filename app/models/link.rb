require 'uri'

class Link < ActiveRecord::Base
  before_validation :valid_link?

  belongs_to :user

  validates :url, presence: true
  validates :title, presence: true

  # validates :url, :url => true

  def valid_link?
    uri = URI.parse(self.url)
    if !%w( http https ).include?(uri.scheme)
      self.url = nil
    end
  end
end
