class Signature < ApplicationRecord
  belongs_to :attest

  # Validações dos atributos da assinatura
  validates :title, :cpf, :email, :name, presence: true
  validates :attest, presence: true
  validates :signature_token, presence: true, uniqueness: true

  before_validation :generate_token, on: :create
  after_create :send_new_signature_email


  private

  # Gera um token único para a assinatura
  def generate_token
    self.signature_token ||= SecureRandom.hex(10)
  end

  # Envia o email de notificação após a criação da assinatura
  def send_new_signature_email
    SignatureMailer.new_signature_email(self, attest).deliver_later
  end
end
