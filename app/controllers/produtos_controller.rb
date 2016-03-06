class ProdutosController < ApplicationController

	def index
		@produtos_nome = Produto.order(:nome).limit 5
		@produtos_descricao = Produto.order(:descricao).limit 5
	end	
end
