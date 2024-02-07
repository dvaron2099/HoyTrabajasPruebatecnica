class ProvidersController < ApplicationController
  include Pagy::Backend
  include Pagy::Frontend

  before_action :set_provider, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_banks, only: [:new, :edit]

  def index
    @pagy, @providers = pagy(Provider.all, items: 10)
  end

  def show
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)
    if @provider.save
      flash[:success] = t('providers.create.success')
      redirect_to @provider
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @provider.update(provider_params)
      flash[:success] = t('providers.update.success')
      redirect_to @provider
    else
      render :edit
    end
  end

  def destroy
    @provider.destroy
    flash[:success] = t('providers.destroy.success')
    redirect_to providers_url
  end

  private

  def set_provider
    @provider = Provider.find(params[:id])
  end

  def set_banks
    @banks = Bank.all
  end

  def provider_params
    params.require(:provider).permit(:name, :nit, :contact_person, :contact_number, :bank_id, :account_number)
  end
end
