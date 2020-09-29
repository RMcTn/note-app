class EntriesController < ApplicationController
  before_action :authenticate_user!
  around_action :entry_not_found_check, only: [:show, :update, :edit]

=begin  
    tags
    !!! nav bar
    in index, preload without body attachments (action text https://edgeguides.rubyonrails.org/action_text_overview.html#avoid-n-1-queries)
    validate dates
    !!! lower friction for adding entry
    pdf render
    remove border from attachment in index
=end
  def index
    @entries = Entry.where(user_id: current_user.id).order(created_at: :desc)
  end

  def search
    return unless params.has_key?(:start_date) and params.has_key?(:end_date) 
    start_date = params[:start_date]
    start_date = DateTime.new(start_date[:year].to_i, start_date[:month].to_i, start_date[:day].to_i).end_of_day
    end_date = params[:end_date]
    end_date = DateTime.new(end_date[:year].to_i, end_date[:month].to_i, end_date[:day].to_i)
    @entries = Entry.where(user_id: current_user.id, created_at: end_date..start_date).order(created_at: :desc)
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
      flash[:notice] = "Created post #{@entry.title}!"
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    render 'unauthorized' and return if not belongs_to_user 
    @entry.destroy
    flash[:notice] = "Deleted post #{@entry.title}!"
    redirect_to entries_path
  end

  private
  def entry_params
    params.require(:entry).permit(:title, :content, :start_date, :end_date)
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
