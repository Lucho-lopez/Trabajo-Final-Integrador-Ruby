class VisitInfosController < ApplicationController
  
  before_action :set_visit_info, only: %i[ show edit update destroy ]

  before_action :authenticate_user!
  # GET /visit_infos or /visit_infos.json
  def index
    @visit_infos = VisitInfo.all
  end

  # GET /visit_infos/1 or /visit_infos/1.json
  def show
  end

  # GET /visit_infos/new
  def new
    @visit_info = VisitInfo.new
  end

  # GET /visit_infos/1/edit
  def edit
  end

  # POST /visit_infos or /visit_infos.json
  def create
    @link = Link.find(params[:link_id])
    @visit_info = @link.visit_infos.build(visit_info_params)

    respond_to do |format|
      if @visit_info.save
        format.html { redirect_to visit_info_url(@visit_info), notice: "Visit info was successfully created." }
        format.json { render :show, status: :created, location: @visit_info }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @visit_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visit_infos/1 or /visit_infos/1.json
  def update
    respond_to do |format|
      if @visit_info.update(visit_info_params)
        format.html { redirect_to visit_info_url(@visit_info), notice: "Visit info was successfully updated." }
        format.json { render :show, status: :ok, location: @visit_info }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @visit_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visit_infos/1 or /visit_infos/1.json
  def destroy
    @visit_info.destroy!

    respond_to do |format|
      format.html { redirect_to visit_infos_url, notice: "Visit info was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit_info
      @visit_info = VisitInfo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def visit_info_params
      params.require(:visit_info).permit(:ip_address, :visited_at)
    end
end
