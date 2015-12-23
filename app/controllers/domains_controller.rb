class DomainsController < ApplicationController
	before_action :auth_user
	before_action :set_domain, only: [:show, :edit, :update, :destroy]

  # GET /domains
  def index
    @domains = current_user.domains
  end

  # GET /domains/1
  def show
  end

  # GET /domains/new
  def new
    @domain = Domain.new
  end

  # GET /domains/1/edit
  def edit
  end

  # POST /domains
  def create
    @domain = Domain.new(domain_params.merge(user: current_user))

    if @domain.save
      redirect_to domains_url, notice: t('domains.created')
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /domains/1
  def update
    if @domain.update(domain_params)
      redirect_to domains_url, notice: t('domains.updated')
    else
      render action: 'edit'
    end
  end

  # DELETE /domains/1
  def destroy
    @domain.destroy
    redirect_to domains_url, notice: t('domains.destroyed')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = current_user.domains.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def domain_params
      params.require(:domain).permit(:user_id, :name, :words, :requests)
    end
end
