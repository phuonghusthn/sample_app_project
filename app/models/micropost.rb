class Micropost < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :content, presence: true,
    length: {maximum: Settings.maximum_micropost_length}
  validates :image,
            content_type: {in: Settings.content_type_image,
                           message: I18n.t("must_be_a_valid_image_format")},
            size: {less_than: Settings.size_image.megabyte,
                   message: I18n.t("should_be_less_than_5MB")}

  scope :order_by_created_at, ->{order created_at: :desc}
  scope :feed, ->(id){where user_id: id}

  def display_image
    image.variant(resize_to_limit: [Settings.size_limit, Settings.size_limit])
  end
end
