class Advert < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	mount_uploader :image, ImageUploader
	validates :description, presence: true
	validates_presence_of :image

	include PgSearch
	pg_search_scope :search, against: :description,
		using: {
			tsearch: {
				dictionary: "english",
				any_word: true }
		},
		associated_against: { user: [:first_name, :last_name], comments: :content }

	def self.text_search(query)
		if query.present?
			search(query)
		else
			unscoped
		end
	end
end
