class LinkAccess < ApplicationRecord
    belongs_to :link
    scope :by_day, -> { group_by_day(:access_time).count }

    def self.ransackable_attributes(auth_object = nil)
        ["access_time", "created_at", "id", "id_value", "ip_address", "link_id", "updated_at"]
      end

    def self.create_access(link, current_time, ip_address)
      create(link: link, access_time: current_time, ip_address: ip_address)
    end


end
  