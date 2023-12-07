class LinksController < ApplicationController
  before_action :set_link, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[send_to_original_url authenticate_private_link]


  # GET /links or /links.json
  def index
    """
    Listado de links paginados , usando gema will_paginate
    """
    @links = current_user.links.paginate(page: params[:page], per_page: 4)
  end
  
  

  # GET /links/1 or /links/1.json
  def show
    @link = Link.find(params[:id])
    @short = send_to_original_url_url(@link.slug) 
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links or /links.json
  def create
    @link = current_user.links.build(link_params)
    respond_to do |format|
      if @link.save
        format.html { redirect_to link_url(@link), notice: 'Link was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), notice: 'Link was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy!

    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
    end
  end


def send_to_original_url
  @link = Link.find_by(slug: params[:slug])
  if @link.present?
    case @link.link_category
    when 'private_link'
      render 'send_to_url_with_password'
    when 'temporary'
      redirect_temporary_link
    when 'ephemeral'
      redirect_ephemeral_link
    else
      redirect_default_link
    end
  else
    flash[:alert] = 'Link not found'
    redirect_to root_path
  end
end

def authenticate_private_link
  @link = Link.find_by(slug: params[:slug])

  if @link.present? && @link.authenticate(params[:password])
    LinkAccess.create_access(@link, current_time, request.remote_ip)
    redirect_to @link.url, allow_other_host: true
  else
    flash[:alert] = 'Invalid password'
    render 'send_to_url_with_password'
  end
end


def access_detail_report
  """ 
  Detalle de accesos por link usando gema ransack para filtrar
  """
    @link = Link.find(params[:id]) 
    @q = @link.link_accesses.ransack(params[:q])
    @acces = @q.result.paginate(page: params[:page], per_page: 6)
end
  

def daily_access_count_report
  """ 
  Lógica para mostrar el listado de accesos por día
  """
  @link = Link.find(params[:id]) 
  if @link.link_accesses.present?
    @access_counts_by_day = @link.link_accesses.by_day
    @access_counts_by_day.reject! { |day, count| count.zero? }
  else
    @access_counts_by_day = {}
  end
end




private

  def authorize_user!
    unless current_user == @link.user
      forbidden
    end
  end

  def current_time
    DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
  end  


  def redirect_temporary_link
    if @link.expires_at > current_time
      LinkAccess.create_access(@link, current_time, request.remote_ip)
      redirect_to @link.url, allow_other_host: true
    else
      not_found
    end
  end
  
  
  def redirect_ephemeral_link
    if !@link.single_use?
      Link.update_single_use
      LinkAccess.create_access(@link, current_time, request.remote_ip)
      redirect_to @link.url, allow_other_host: true
    else
      forbidden
    end
  end
  
  
  def redirect_default_link
    LinkAccess.create_access(@link, current_time, request.remote_ip)
    redirect_to @link.url, allow_other_host: true
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    if params[:link].present?
      permitted_params =  [:url,:name, :link_category, :expires_at,:password]
      params.require(:link).permit(permitted_params)
    end
  end 
  
  
  
end