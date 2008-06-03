class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    
    if params[:preview]
      respond_to do |format|
        format.html { render :action => 'show' }
        format.js { render :action => 'preview' }
      end
    else
      respond_to do |format|
        if @comment.save
          format.html { redirect_to post_path(@post, :anchor => 'comments') }
          format.js
        else
          format.html { render :template => 'posts/show' }
          format.js
        end
      end
    end
  end
end
