class ProdutosController < ApplicationController

	before_action :set_produto, only:[:edit, :update, :destroy]

	def index
		@produtos_nome = Produto.order(:nome).limit 5
		@produtos_preco = Produto.order(:preco).limit 2
	end	

	def busca
		@nome_buscar = params[:nome]
		@produtos = Produto.where "nome like ?", "%#{@nome_buscar}%"
	end

	def new
		@produto = Produto.new
		renderiza :new
	end

	def edit
		set_produto
		renderiza :edit
	end

	def update
		set_produto
		valores = produtos_params
		if @produto.update valores
			flash[:notice] = "Produto atualizado com sucesso"
			redirect_to root_url
		else
			renderiza :new
		end		
	end

	def create
		@produto = Produto.new produtos_params
		if @produto.save
			flash[:notice] = "Produto salvo com sucesso"
			redirect_to root_url
		else
			renderiza :new
		end	
	end

	def destroy
		set_produto
		@produto.destroy
		redirect_to root_url
	end

	private

	def renderiza(view)
		@departamentos = Departamento.all
		render view		
	end

	def set_produto
		id = params[:id]
		@produto = Produto.find(id)
	end

	def produtos_params
		params.require(:produto).permit :nome, :descricao, :quantidade, :preco, :departamento_id
	end
end
