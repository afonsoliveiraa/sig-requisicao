class SignatureMailer < ApplicationMailer
  default from: 'sigrequisicao@gmail.com'

  # Método para enviar o email de notificação de nova assinatura, passa o atesto e a assitura para o template de email
  # O template de email é renderizado em app/views/signature_mailer/new_signature_email
  def new_signature_email(signature, attest)
    @signature = signature
    @attest = signature.attest
    mail(to: @signature.email, subject: 'Você recebeu uma nova assinatura para validar')
  end
end
a