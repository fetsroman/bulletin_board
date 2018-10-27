class AdvertsController < ApplicationController
	load_and_authorize_resource
	before_action :authenticate_user!, except:[:index, :show]

	def index
		@adverts = Advert.text_search(params[:query])
	end

	def new
	end

	def create
		@advert.user_id = current_user.id
		if @advert.save
			redirect_to @advert, success: 'Advert was saved'
		else
			render 'new', danger: 'Advert was not saved'
		end
	end

	def show
		@comments = Comment.where(advert_id: @advert).order("created_at DESC")
	end

	def edit
	end

	def update
		if @advert.update advert_params
			redirect_to @advert, success: 'Advert was updated'
		else
			render 'edit', danger: 'Advert was not updated'
		end
	end

	def destroy
		@advert.destroy
		redirect_to adverts_path, success: 'Advert was deleted'
	end

	private

	def advert_params
		params.require(:advert).permit(:description, :image, :user_id)
	end
end
