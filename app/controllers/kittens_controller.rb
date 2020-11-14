class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.invalid?
      flash.now.alert = 'Kitten failed to save!'
      render 'new'
    end

    redirect_to kitten_path(@kitten), notice: 'Kitten Created!' and return if @kitten.save
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kittens_params)
      flash[:alert] = 'Update successful.'
      redirect_to @kitten
    else
      flash[:alert] = 'Update unsuccessful.'
      render 'edit'
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
   
    redirect_to kittens_path
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
