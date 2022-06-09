class EntitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entity, only: %i[show edit update destroy]

  def index
    @entities = Entity.all
  end

  def show
    @category = Category.find(params[:category_id])
    @entity = Entity.find(params[:id])
  end

  def new
    @category = Category.find(params[:category_id])
    @entity = Entity.new
  end

  def edit; end

  def create
    @category = Category.find(params[:category_id])
    @entity = Entity.new(entity_params)
    @entity.user_id = current_user.id
    @entity = CategoryEntity.create!(category: @category, entity: @entity)
    respond_to do |format|
      if @entity.save
        format.html { redirect_to @category, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @entity }
      else
        format.html { render :new }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @entity.update(entity_params)
        format.html { redirect_to @entity, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @entity }
      else
        format.html { render :edit }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entity = set_entity
    @entity.destroy
    redirect_to category_path(params[:category_id])
  end

  private

  def set_entity
    @entity = Entity.find(params[:id])
  end

  def entity_params
    params.require(:entity).permit(:name, :amount)
  end
end
