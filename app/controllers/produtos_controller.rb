class ProdutosController < ApplicationController

	def index
		@produtos_nome = Produto.order(:nome).limit 5
		@produtos_descricao = Produto.order(:preco).limit 2
	end	

	def busca
		@nome_buscar = params[:nome]
		@produtos = Produto.where "nome like ?", "%#{@nome_buscar}%"
	end

	def create
		valores = params.require(:produto).permit :nome, :descricao, :quantidade, :preco
		produto = Produto.create valores
		redirect_to root_url		
	end

	def destroy
		id = params[:id]
		Produto.destroy id
		redirect_to root_url
	end
end
