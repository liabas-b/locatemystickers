class Tag < ActiveRecord::Base
  attr_accessible :color, :forbidden, :key, :popularity, :scope, :times_used, :taggable_id, :taggable_type

  belongs_to :taggable, polymorphic: true
 
  has_many :histories

  validates :key, presence: true, length: { maximum: 140 }

  # Callbacks
  after_create :after_create_callback
  after_update :after_update_callback
  before_destroy :before_destroy_callback

  private

    def after_create_callback
      # self.histories.create!(subject: "tag", operation: "created", user_id: self.id)
    end

    def after_update_callback
      # self.histories.create!(subject: "tag", operation: "updated", user_id: self.id)
    end

    def before_destroy_callback
      # self.histories.create!(subject: "tag", operation: "deleted", user_id: self.id)
    end

end
