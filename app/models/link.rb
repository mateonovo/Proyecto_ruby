class Link < ApplicationRecord
  belongs_to :user
  has_many :link_accesses
  validates :name, presence: false
  validates :slug, uniqueness: true
  validates :link_category, presence: true
  validates :expires_at, presence: true , if: :temporary?
  validates :password, presence: true , if: :private_link?
  validates :url, format: { with: URI.regexp }
  has_secure_password validations: false

  enum link_category: { regular: 'regular', temporary: 'temporary', private_link: 'private_link', ephemeral: 'ephemeral' }

  before_validation :generate_slug_and_unique_url, on: :create
  
  #attr_accessor :expires_at
  private
  def generate_slug_and_unique_url
    self.slug ||= SecureRandom.hex(1)
  end
  def temporary?
    link_category == 'temporary'
  end

  def private_link?
    link_category == 'private_link'
  end



end


  