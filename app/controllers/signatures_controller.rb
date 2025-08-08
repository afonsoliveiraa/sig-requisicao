class SignaturesController < ApplicationController
  before_action :set_signature, only: [:update_status]

  def update_status
    if @signature.update(status: "CONFIRMADO")
      # Depois de atualizar o status, chama a rota index
      combined_tokens = "#{@signature.attest.token}+#{@signature.signature_token}"
      redirect_to attest_accept_path(combined_tokens: combined_tokens)    
    else  
      render json: { errors: @signature.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_signature
    @signature = Signature.find(params[:id])
  end
end
