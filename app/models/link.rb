class Link < ApplicationRecord
  belongs_to :user
  has_many :link_accesses, dependent: :destroy
  validates :name, presence: false
  validates :slug, uniqueness: true
  validates :link_category, presence: true
  validates :expires_at, presence: true , if: :temporary?
  validates :password, presence: true , if: :private_link?
  validates :url, presence: true ,format: { with: URI.regexp }
  has_secure_password validations: false

  enum link_category: { regular: 'regular', temporary: 'temporary', private_link: 'private_link', ephemeral: 'ephemeral' }

  before_validation :generate_slug_and_unique_url, on: :create
  
  

  def self.update_single_use
    update(single_use: true)
  end  

  private
  def generate_slug_and_unique_url
    self.slug ||= SecureRandom.hex(3)
  end
  def temporary?
    link_category == 'temporary'
  end

  def private_link?
    link_category == 'private_link'
  end



end


  