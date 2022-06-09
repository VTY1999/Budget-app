class CategoryEntitiesController < ApplicationController
  before_action :set_category_entity, only: %i[show edit update destroy]

  def index
    @category_entities = CategoryEntity.all
  end

  def show; end

  def new
    @category_entity = CategoryEntity.new
  end

  def edit; end

  def create
    @category_entity = CategoryEntity.new(category_entity_params)
    redirect_to category_entity_path(@category_entity), notice: 'Category entity was successfully created.'

    respond_to do |format|
      if @category_entity.save
        format.html { redirect_to @category_entity, notice: 'Category entity was successfully created.' }
        format.json { render :show, status: :created, location: @category_entity }
      else
        format.html { render :new }
        format.json { render json: @category_entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @category_entity.update(category_entity_params)
    redirect_to category_entity_path(@category_entity.category)

    respond_to do |format|
      if @category_entity.save
        format.html { redirect_to @category_entity, notice: 'Category entity was successfully updated.' }
        format.json { render :show, status: :ok, location: @category_entity }
      else
        format.html { render :edit }
        format.json { render json: @category_entity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category_entity.destroy
    redirect_to category_entity_path(@category_entity.category)
  end

  private

  def set_category_entity
    @category_entity = CategoryEntity.find(params[:id])
  end

  def category_entity_params
    params.require(:category_entity).permit(:category_id, :entity_id)
  end
end
