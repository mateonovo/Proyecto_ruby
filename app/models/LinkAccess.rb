class LinkAccess < ApplicationRecord
    belongs_to :link
    scope :by_day, -> { group_by_day(:access_time).count }

    def self.ransackable_attributes(auth_object = nil)
        ["access_time", "created_at", "id", "id_value", "ip_address", "link_id", "updated_at"]
      end
    
  end
  