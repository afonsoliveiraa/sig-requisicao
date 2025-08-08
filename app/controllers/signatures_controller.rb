class SignaturesController < ApplicationController
  before_action :set_signature, only: [:update_status, :update_email]

  def update_status
    if @signature.update(status: "CONFIRMADO", signed_at: Time.current)
      # Depois de atualizar o status, chama a rota index
      combined_tokens = "#{@signature.attest.token}+#{@signature.signature_token}"
      redirect_to attest_accept_path(combined_tokens: combined_tokens)    
    else  
      render json: { errors: @signature.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_email
    email_new = params.dig(:signature, :email) # pega só o email do hash signature

    if @signature.update(email: email_new)
      # Dispara o reenvio do email com o novo link de assinatura
      @signature.send_new_signature_email
      # Depois de atualizar o status, chama a rota index
      redirect_to attest_manage_path(token: @signature.attest.token)    
    else  
      logger.debug @signature.errors.full_messages.inspect  # <- aqui
      render json: { errors: @signature.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_signature
    @signature = Signature.find(params[:id])
  end
end
