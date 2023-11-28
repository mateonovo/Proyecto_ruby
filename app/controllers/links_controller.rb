class LinksController < ApplicationController
  before_action :set_link, only: %i[show edit update destroy]

  # GET /links or /links.json
  def index
    @links = Link.all
  end

  # GET /links/1 or /links/1.json
  def show
    @link = Link.find(params[:id])
    url_extention = @link.unique_url
    @short = "http://localhost:3000/#{url_extention}"
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
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy!

    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


def send_to_original_url
  @link = Link.find_by(slug: params[:slug])
  
  puts ("aaaaaaaaaaaaaaaaaaaaaaaaaa , #{@link.unique_url}")
  puts ("aaaaaaaaaaaaaaaaaaaaaaaaaa , #{params}")

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
    redirect_to @link.url, allow_other_host: true
  else
    flash[:alert] = 'Invalid password'
    render 'send_to_url_with_password'
  end
end


private


  def redirect_temporary_link
    if @link.expires_at > Time.now
      redirect_to @link.url, allow_other_host: true
    else
      flash[:alert] = 'Link expired'
      redirect_to root_path
    end
  end
  
  def redirect_ephemeral_link
    if @link.created_at + 5.minutes > Time.now
      redirect_to @link.url, allow_other_host: true
    else
      flash[:alert] = 'Link expired'
      redirect_to root_path
    end
  end
  
  def redirect_default_link
    redirect_to @link.url, allow_other_host: true
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    if params[:link].present?
      permitted_params = case params[:link][:link_category]
                         when 'regular'
                           [:url,:name, :link_category]
                         when 'temporary'
                           [:url,:name, :link_category, :expires_at]
                         when 'private_link'
                           [:url,:name, :link_category, :password]
                         when 'ephemeral'
                           [:url,:name, :link_category]
                         else
                           [:url,:name, :link_category]
                         end
      params.require(:link).permit(permitted_params)
    end
  end  
end