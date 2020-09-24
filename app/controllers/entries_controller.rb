class EntriesController < ApplicationController
  before_action :authenticate_user!
  around_action :entry_not_found_check, only: [:show, :update, :edit]

  """
    STUFF TO ADD: Date range picker 

  """
  def index
    @entries = Entry.where(user_id: current_user.id)
  end

  def new
    @entry = Entry.new
  end

  def show
    @entry = Entry.find(params[:id])
    render 'unauthorized' and return if not belongs_to_user
    render 'edit'
  end

  def update
    @entry = Entry.find(params[:id])
    render 'unauthorized' and return if not belongs_to_user
    if @entry.update(entry_params)
      render 'edit'
    else
      render 'edit'
    end
  end

  def edit
    @entry = Entry.find(params[:id])
    render 'unauthorized' and return if not belongs_to_user
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = current_user.id
    if @entry.save
      redirect_to @entry
    else
      render 'new'
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    render 'unauthorized' and return if not belongs_to_user 
    @entry.destroy
    redirect_to entries_path
  end

  private
  def entry_params
    params.require(:entry).permit(:title, :content)
  end

  def belongs_to_user
    @entry.user_id == current_user.id
  end

  def entry_not_found_check
    begin
      yield
    rescue
      render 'unauthorized'
    end
  end

end
