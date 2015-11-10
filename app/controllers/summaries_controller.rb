class SummariesController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @summary = Summary.new
    authorize @summary
  end

  def create
    @post = Post.find(params[:post_id])
    @summary = Summary.new(params.require(:summary).permit(:description))
    @summary.post = @post
    authorize @summary
    if @summary.save
      flash[:notice] = "The summary was saved."
      redirect_to @summary
    else
      flash[:notice] = "The summary failed to save, try again"
      render :new
  end

  def update
    @post = Post.find(params[:post_id])
    @summary = topic.find(params[:id])
    authorize @summary
    if @summary.update_attributes(params.require(:summary).permit(:description))
      flash[:notice] = "The summary was updated"
      redirect_to @summary
    else
      flash[:notice] = "The summary failed to update"
      render :new
    end
  end

  def show
    @summary = Summary.find(params[:id])
    @post = Post.find([params[:post_id])
    authorize @summary
  end

  def edit
    @summary = Summary.find(params[:id])
    @post = Post.find(params[:post_id])
    authorize @post
  end
end
