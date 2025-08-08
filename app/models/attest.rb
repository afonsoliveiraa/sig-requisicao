class Attest < ApplicationRecord
  has_many :signatures, dependent: :destroy
  accepts_nested_attributes_for :signatures

  validates :entity, :system, :operation, :type_signature, :message, presence: true
  validates :token, presence: true, uniqueness: true

  before_validation :generate_token, on: :create

  private

  def generate_token
    self.token ||= SecureRandom.hex(10)
  end
end
