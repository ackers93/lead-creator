class LeadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lead, only: [:show, :edit, :update, :destroy]

  # GET /leads
  def index
    @leads = current_user.leads
                         .search(params[:query])
                         .by_status(params[:status])
                         .by_interest_level(params[:interest_level])
                         .recent
  end

  # GET /leads/:id
  def show
  end

  # GET /leads/new
  def new
    @lead = current_user.leads.build
  end

  # GET /leads/:id/edit
  def edit
  end

  # POST /leads
  def create
    @lead = current_user.leads.build(lead_params)

    respond_to do |format|
      if @lead.save
        format.html { redirect_to leads_path, notice: "Lead was successfully created." }
        format.turbo_stream { redirect_to leads_path, notice: "Lead was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leads/:id
  def update
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to leads_path, notice: "Lead was successfully updated." }
        format.turbo_stream { redirect_to leads_path, notice: "Lead was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/:id
  def destroy
    @lead.destroy

    respond_to do |format|
      format.html { redirect_to leads_path, notice: "Lead was successfully deleted." }
      format.turbo_stream { redirect_to leads_path, notice: "Lead was successfully deleted." }
    end
  end

  private

  def set_lead
    @lead = current_user.leads.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to leads_path, alert: "Lead not found."
  end

  def lead_params
    params.require(:lead).permit(
      :business_name,
      :contact_name,
      :phone,
      :email,
      :twitter,
      :instagram,
      :facebook,
      :tiktok,
      :website,
      :location,
      :interest_level,
      :status,
      :notes
    )
  end
end
