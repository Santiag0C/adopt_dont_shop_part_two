class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets
  validates_presence_of :image,
                        :name,
                        :age,
                        :sex,
                        :shelter

  def self.pets_with_applications
    Pet.joins(:applications)
  end
end
