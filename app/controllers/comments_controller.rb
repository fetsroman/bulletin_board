class CommentsController < ApplicationController
	before_action :find_advert
	before_action :find_comment, only: [:edit, :update, :destroy]

	def create
		@comment = @advert.comments.create(params[:comment].permit(:content))
		@comment.user_id = current_user.id
		
		respond_to do |format|
			if @comment.save
				format.html { redirect_to @advert }
				format.js
			else
				format.html { render 'new' }
				format.js
			end
		end
	end

	def edit
	end

	def update
		if @comment.update(params[:comment].permit(:content))
			redirect_to advert_path(@advert), success: 'Comment was updated'
		else
			render 'edit', danger: 'Comment was not updated'
		end
	end

	def destroy
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to @advert }
			format.js
		end
	end

	private

	def find_advert
		@advert = Advert.find(params[:advert_id])
	end

	def find_comment
		@comment = @advert.comments.find(params[:id])
	end
end
