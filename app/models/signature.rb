class Signature < ApplicationRecord
  belongs_to :attest

  # Validações dos atributos da assinatura
  validates :title, :cpf, :email, :name, presence: true
  validates :attest, presence: true
  validates :signature_token, presence: true, uniqueness: true
  validates :status, presence: true  # validador para garantir que status exista

  before_validation :generate_token, on: :create
  before_validation :set_default_status, on: :create  # novo callback
  after_create :send_new_signature_email

  # Envia o email de notificação após a criação da assinatura
  def send_new_signature_email
    SignatureMailer.new_signature_email(self, attest).deliver_later
  end

  private

  # Gera um token único para a assinatura
  def generate_token
    self.signature_token ||= SecureRandom.hex(10)
  end

  # Define status padrão como "PENDENTE" se não estiver setado
  def set_default_status
    self.status ||= 'PENDENTE'
  end

end
