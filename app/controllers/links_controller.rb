class LinksController < ApplicationController
  
  before_action :authenticate_user!, except: [:redirect_to_url, :validate_password]

  before_action :set_link, only: %i[ show edit update destroy ]

  # GET /links or /links.json
  def index
    @links = current_user.links
  end

  # GET /links/1 or /links/1.json
  def show
    @link = Link.find(params[:id])
    @visit_infos = @link.visit_infos

    if params[:ip_address].present?
      @visit_infos = @visit_infos.where(ip_address: params[:ip_address])
    end

    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @visit_infos = @visit_infos.where(visited_at: start_date.beginning_of_day..end_date.end_of_day)
      @days = (end_date - start_date).to_i
      @total_visits = @visit_infos.where(visited_at: start_date.beginning_of_day..end_date.end_of_day).count
    else
      @days = (Time.zone.now.to_date - @link.created_at.to_date).to_i
      @total_visits = @visit_infos.count
    end
    @average_visits_per_day = @days.zero? ? @total_visits : (@total_visits.to_f / @days)
    render "show"
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  def redirect_to_url
    link = Link.find_by_unique_token(params[:unique_token])

    if !link 
      flash[:alert] = "El enlace no existe"
      redirect_to root_path
    elsif link.private?
      render "private", layout: false
      return
    elsif link.access_link()
      link.create_visit_info(request.remote_ip, Time.current)
      redirect_to link.url, allow_other_host: true
    else 
      flash[:alert] = "El enlace no existe"
      redirect_to root_path
    end
  end

  def validate_password
    link = Link.find_by_unique_token(params[:unique_token])

    if link
      if link.link_type == 'private' && params[:password] == link.link_password
        link.create_visit_info(request.remote_ip, Time.current)
        redirect_to link.url, allow_other_host: true
      else
        flash[:alert] = 'la contraseña es incorrecta'
        redirect_to "/private"
      end
    else
      flash[:alert] = "El enlace no existe"
      redirect_to root_path 
    end
  end

  # POST /links or /links.json
  def create
    @link = current_user.links.build(link_params)
    
    respond_to do |format|
      if @link.save
        format.html { redirect_to link_url(@link), notice: "Link was successfully created." }
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
        format.html { redirect_to link_url(@link), notice: "Link was successfully updated." }
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
      format.html { redirect_to links_url, notice: "Link was successfully destroyed." }
      format.json { heaad :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def link_params
      params.require(:link).permit(:link_name, :url, :link_type, :expires_at, :link_password, :unique_token, :access_count)
    end
end