class AttestController < ApplicationController
    protect_from_forgery with: :null_session

    def create
        # Cria um novo registro de atestado com os parâmetros fornecidos
        attest = Attest.new(attest_params)

        # Verifica se o atestado é válido e salva no banco de dados
        if attest.save
            # Retorna uma resposta JSON com o token do atestado criado
            render json: { message: 'attest created', token: attest.token }, status: :created
        else
            # Em caso de erro, retorna uma resposta JSON com os erros de validação
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

    # Para permitir apenas os parâmetros necessários para criar um atesto
    def attest_params
        params.require(:attest).permit(:entity, :system, :operation, :type_signature, :message, signatures_attributes: [:title, :cpf, :email, :name])
    end

end
