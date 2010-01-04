class PagesController < ApplicationController
  before_filter :check_administrator_role, :except => :show
  
  # get a set of resources
  def index
    @pages = Page.find(:all)
  end
  
  # get a specific resource
  def show
    @page = Page.find(params[:id].to_i)
  end

  # get a form to create a new resource
  def new
    @page = Page.new
  end

  # post to db to save new resource
  def create
    @page = Page.new(params[:page])
    @page.save!
    flash[:notice] = 'Page has been created !'
    redirect_to :action => 'index'
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  # get a form to edit the resource
  def edit
    @page = Page.find(params[:id].to_i)
  end

  # put to db to update a resource
  def update
    @page = Page.find(params[:id].to_i)
    @page.attributes = params[:page]
    @page.save!
    flash[:notice] = "Page updated"
    redirect_to :action => 'index'
  rescue #???
    render :action => 'edit'
  end

  # delete a resource
  def destroy
    @page = Page.find(params[:id].to_i)
    if @page.destroy
      flash[:notice] = "Page deleted"
    else
      flash[:error] = "There was a problem deleting the page"
    end
    redirect_to :action => 'index'
  end

end
