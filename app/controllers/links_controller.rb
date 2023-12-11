class LinksController < ApplicationController
  before_action :authenticate_user!, except: [:redirect_to_url, :validate_password]
  before_action :set_link, only: %i[show edit update destroy]

  # GET /links or /links.json
  def index
    @pagy, @links = pagy(Link.all.where(user_id: current_user).order(created_at: :desc), items: 5)
  end

  # GET /links/1 or /links/1.json
  def show
    @link = Link.find(params[:id])
    @visit_infos = @link.visit_infos
    filter_visit_infos_by_parameters
    
    @pagy, @visit_infos = pagy(@visit_infos.order(visited_at: :desc), items: 5)
    calculate_visit_info_statistics
    render "show"
  end

  def new
    @link = Link.new
  end

  def edit
  end

  def redirect_to_url
    handle_link_redirect(@link)
  end

  def validate_password
    handle_password_validation(@link)
  end

  def create
    @link = current_user.links.build(link_params)
    
    handle_link_password

    respond_to do |format|
      if @link.save
        format.html { redirect_to link_url(@link), notice: "El link fue creado correctamente." }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        if link_params[:link_password].present? && @link.private_link?
          @link.update(link_password: BCrypt::Password.create(link_params[:link_password]))
        end
        format.html { redirect_to link_url(@link), notice: "El link fue actualizado correctamente." }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @link.destroy!

    respond_to do |format|
      format.html { redirect_to links_url, notice: "El link fue eliminado correctamente." }
      format.json { heaad :no_content }
    end
  end

  private

    def set_link
      @link = Link.find(params[:id])
    end

    def filter_visit_infos_by_parameters
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
    end
  
    def calculate_visit_info_statistics
      @average_visits_per_day = @days.zero? ? @total_visits : (@total_visits.to_f / @days)
    end

    def handle_link_redirect(link)
      link = Link.find_by_unique_token(params[:unique_token])

      if !link 
        render 'errors/400', status: :bad_request, layout: false
      elsif link.private_link?
        render "private", layout: false
        return
      elsif link.access_link()
        link.create_visit_info(request.remote_ip, Time.current)
        redirect_to link.url, allow_other_host: true
      else 
        if link.temporal_link?
          render 'errors/404', status: :not_found, layout: false
          return
        end
        if link.ephemeral_link?
          render 'errors/403', status: :forbidden, layout: false
          return
        end
        flash[:alert] = "El enlace no existe"
        redirect_to root_path
      end
    end

    def handle_password_validation(link)
      link = Link.find_by_unique_token(params[:unique_token])

      if link
        if link.private_link? && BCrypt::Password.new(link.link_password) == params[:password]
          link.create_visit_info(request.remote_ip, Time.current)
          redirect_to link.url, allow_other_host: true
        else
          flash[:notice] = 'la contraseña es incorrecta'
          render "private", layout: false
        end
      else
        flash[:alert] = "El enlace no existe"
        redirect_to root_path 
      end
    end

    def handle_link_password
      @link.link_password = BCrypt::Password.create(link_params[:link_password]) if link_params[:link_password].present?
    end

    def link_params
      params.require(:link).permit(:link_name, :url, :link_type, :expires_at, :link_password, :unique_token, :access_count)
    end
end