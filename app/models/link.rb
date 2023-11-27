class Link < ApplicationRecord
  belongs_to :user
  validates :name, presence: false
  validates :slug, uniqueness: true
  validates :link_category, presence: true
  validates :expires_at, presence: false
  validates :unique_url, uniqueness: true
  has_secure_password validations: true

  enum link_category: { regular: 'regular', temporary: 'temporary', private_link: 'private_link', ephemeral: 'ephemeral' }

  before_validation :generate_slug_and_unique_url, on: :create
  
  
  #attr_accessor :expires_at
  private
  def generate_slug_and_unique_url
    self.slug ||= SecureRandom.hex(5)
    self.unique_url = "/l/#{slug}"
  end
end
