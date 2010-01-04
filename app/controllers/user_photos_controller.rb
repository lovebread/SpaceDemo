class UserPhotosController < ApplicationController
  before_filter :login_required, :except => [:index, :index_all, :show]

  # GET
  def index
    @user = User.find(params[:user_id])
    @photo_pages = Paginator.new(self, @user.photos.count, 9, params[:page])
    @photos = @user.photos.find(:all, :order => 'created_at DESC',
                                :limit => @photo_pages.items_per_page,
                                :offset => @photo_pages.current.offset)
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @photos.to_xml }
    end
  end

  # GET
  def show
    @photo = Photo.find_by_user_id_and_id(params[:user_id], 
                                          params[:id], 
                                          :include => :user)
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @photo.to_xml }
    end
  end

  # GET
  def new
    @photo = Photo.new
  end

  # GET
  def edit
    @photo = @logged_in_user.photos.find(params[:id])    
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'    
  end

  # POST
  def create
    @photo = Photo.new(params[:photo])

    respond_to do |format|      
    if @logged_in_user.photos << @photo
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to(user_photos_path(:user_id=>@logged_in_user.id)) }
        format.xml  { head :created, 
          :location => user_photo_path(:user_id => @photo.user_id, :id => @photo)}
      else
        format.html { render :action => 'new' }
        format.xml  { render :xml => @photo.errors.to_xml }
      end
    end    
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  # PUT
  def update
    @photo = @logged_in_user.photos.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to user_photo_path(:user_id => @logged_in_user, 
                                                  :id => @photo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors.to_xml }
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'  
  end

  # DELETE
  def destroy
    @photo = @logged_in_user.photos.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to user_photos_path }
      format.xml  { head :ok }
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'    
  end
  
  def add_tag
    @photo = @logged_in_user.photos.find(params[:id])
    
    # Exception: can't convert string to array
    temp = @photo.tag_list.join(',')
    #puts 'before add : ',temp
    temp += "," + params[:tag][:name]
    #puts 'end add : ',temp
    
    @photo.tag_list = temp
    @photo.save
    @new_tag = @photo.reload.tags.last
  end
  
  def remove_tag
    @photo = @logged_in_user.photos.find(params[:id])
    @tag_to_delete = @photo.tags.find(params[:tag_id])
    if @tag_to_delete
      @photo.tags.delete(@tag_to_delete)
    else
      render :nothing => true
    end
  end
end
