class PostsController < ApplicationController

  def index
    @posts = Post.all
    # @posts = Post.find_with_reputation(:votes, :all, order: "votes desc")
  end

  def show
  end

  def new
    @post = Post.new
    @user = current_user
    # redirect_to new_user_post_path(current_user.id)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    # @post.username = @user.name
    if @post.save
      redirect_to  user_posts_path
    end
  end

  def update
    respond_to do |format|
      @post = Post.find_by_id(params[:id])
      if @post.update_attributes(post_params)
        format.html { redirect_to user_posts_path, notice: 'Post was successfully updated.' }
        format.json { render :index, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_posts_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:body, :title)
  end
end
