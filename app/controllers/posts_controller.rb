class PostsController < ApplicationController

  def index
    @posts = Post.find_with_reputation(:votes, :all, order: "votes desc")
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @user = current_user
    @post.user_name = @user.name
    if @post.save
      redirect_to posts_path
    end
  end

  # def vote
  #   value = params[:type] == "up" ? 1 : -1
  #   @post = Post.find(params[:id])
  #   # @post.add_or_update_evaluation(:votes, value, current_user)
  #   redirect_to :back, notice: "Thank you for voting"
  # end

  def update
    respond_to do |format|
    @post = Post.find_by_id(params[:id])
      if @post.update_attributes(post_params)
        format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
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
      format.html { redirect_to posts_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:post).permit(:body, :title, :username)
    end
end
