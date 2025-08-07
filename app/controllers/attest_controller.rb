class AttestController < ApplicationController
    protect_from_forgery with: :null_session

    def create
        puts "PARAMS RECEBIDOS: #{params.inspect}"

        # Cria uma nova instância de Attest com os parâmetros permitidos
        attest = Attest.new(attest_params)

        # Verifica se o attest foi salvo com sucesso e cria as assinaturas associadas
        if attest.save
            # O email será enviado automaticamente após a criação da assinatura, mediante o callback after_create no modelo Signature
            attest.create_signatures!(params[:signatures])
            # Responde com o token do attest criado
            render json: { message: 'attest created', token: attest.token }, status: :created
        else
            render json: { errors: attest.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def index
        # Quebra os tokens combinados dos parâmetros da URL
        combined_tokens = params[:combined_tokens]
        attest_token, signature_token = combined_tokens.split('+')

        # Localize os registros com base nos tokens separados e passa para index
        @attest = Attest.find_by(token: attest_token)
        @signature = Signature.find_by(signature_token: signature_token)        
    end


    private

    # Define os parâmetros permitidos para o attest
    def attest_params
        params.require(:attest).permit(:entity, :system, :operation, :token, :type_signature, :message)
    end
end
