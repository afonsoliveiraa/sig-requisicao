class Attest < ApplicationRecord
    has_many :signatures, dependent: :destroy

    # Validações para garantir que os campos necessários estejam preenchidos
    validates :entity, presence: true
    validates :system, presence: true
    validates :operation, presence: true
    validates :token, presence: true, uniqueness: true
    validates :type_signature, presence: true
    validates :message, presence: true

    before_create :generate_token

    # Método para criar assinaturas associadas ao attest
    def create_signatures!(signatures_data)
        return unless signatures_data.present?

        signatures_data.each do |signature_data|
            signatures.create!(title: signature_data[:title], cpf: signature_data[:cpf], email: signature_data[:email], name: signature_data[:name], status: 'PENDENTE')
        end
    end


    private

    # Gera um token único para o attest antes de ser salvo no banco de dados
    def generate_token
        self.token = SecureRandom.hex(10)
    end
end
