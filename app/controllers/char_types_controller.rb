class CharTypesController < ApplicationController
	def index
		@char_types = current_user.char_types.by_title.page(params[:page]).per(4)
	end

	def show
		@char_type = current_user.char_types.find(params[:id])
	end
	
	def new
		@char_type = current_user.char_types.new
	end
	
	def edit
		@char_type = current_user.char_types.find(params[:id])
	end
	
	def create
		@char_type = current_user.char_types.new(char_type_params)
		
		# render text: params[:char_type].inspect
		
		if @char_type.save
			redirect_to char_type_path(@char_type)
		else
			render 'new'
		end
	end
	
	def update
		@char_type = current_user.char_types.find(params[:id])
		
		if @char_type.update(char_type_params)
			redirect_to char_type_path(@char_type)
		else
			render 'edit'
		end
	end
	
	def destroy
		@char_type = current_user.char_types.find(params[:id])
		
		@char_type.destroy
		
		redirect_to users_char_types_path
	end
	
	private
		def char_type_params
			params.require(:char_type).permit(:title, :avatar)
		end
end
