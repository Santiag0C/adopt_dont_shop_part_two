 class Review < ApplicationRecord
   belongs_to :shelter
   validates_presence_of :title,
                        :rating,
                        :content
                        # :picture
  # some_value :picture
  # validates :picture, :presence => false, :allow_blank => true
  # validates :picture, :presence => true, :uniqueness => {:allow_blank => true}
 end
