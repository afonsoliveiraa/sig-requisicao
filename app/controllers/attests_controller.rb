class AttestsController < ApplicationController
    protect_from_forgery with: :null_session

    def create
        # Cria um novo registro de atestado com os parâmetros fornecidos
        attest = Attest.new(attest_params)

        # Verifica se o atestado é válido e salva no banco de dados
        if attest.save
            # Retorna uma resposta JSON com o token do atestado criado
            render json: { status: true, token: attest.token }, status: :created
        else
            # Em caso de erro, retorna uma resposta JSON com os erros de validação
            render json: { status: false, token: attest.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def response_attest
        # Busca o atestado pelo token fornecido nos parâmetros
        token = params[:token]
        attest = Attest.find_by(token: token)

        if attest
            signatures_status = attest.signatures.map do |signature|
                { name: signature.name, title: signature.title, status: signature.status, signed_at: signature.signed_at }
            end

            all_confirmed = attest.signatures.all? { |signature| signature.status == 'CONFIRMADO' }

            render json: {
            success: all_confirmed,
            message: all_confirmed ? 'Todas as assinaturas confirmadas' : 'Existem assinaturas pendentes',
            attest_token: attest.token,
            signatures: signatures_status,
            }, status: all_confirmed ? :ok : :unprocessable_entity

        else
            render json: {
            success: false,
            message: 'Attest não encontrado',
            signatures: []
            }, status: :not_found
        end
    end

    # Views 
    def index
        # Quebra os tokens combinados dos parâmetros da URL
        combined_tokens = params[:combined_tokens]
        attest_token, signature_token = combined_tokens.split('+')

        # Localize os registros com base nos tokens separados e passa para index
        @attest = Attest.find_by(token: attest_token)
        @signature = Signature.find_by(signature_token: signature_token)        
    end

    # Método para alterar o email de uma assinatura e reenviar o link de assinatura
    def attest_manage
        token = params[:token]
        @attest = Attest.find_by(token: token)
        @toast_message = params[:toast]

    end
    

    
    private

    # Para permitir apenas os parâmetros necessários para criar um atesto
    def attest_params
        params.require(:attest).permit(:entity, :system, :operation, :type_signature, :message, signatures_attributes: [:title, :cpf, :email, :name])
    end

end
