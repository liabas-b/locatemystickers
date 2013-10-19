class StickerConfiguration < ActiveRecord::Base
	include ApplicationHelper
  attr_accessible :activate, :frequency_update, :sticker_code

  after_save :after_save_callback
  belongs_to :sticker

  def self.search(search, column = 'code')
    if search
      where("#{column} LIKE ?", "%#{search}%")
    else
      scoped
    end
  end

  private

    def after_save_callback
    	post_ss_sticker_configuration(self)
    end
  end
