class RolesController < ApplicationController
  before_filter :check_administrator_role
  
  # GET /roles
  # GET /roles.xml
  def index
    @user = User.find(params[:user_id])
    @all_roles = Role.all
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @user = User.find(params[:user_id])
    @role = Role.find(params[:id])
    unless @user.has_role?(@role.name)
      @user.roles << @role
    end
    #redirect_to :action => 'index'
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy

    @user = User.find(params[:user_id])
    @role = Role.find(params[:id])
    if @user.has_role?(@role.name)
      @user.roles.delete(@role)
    end
    
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
