class PacksController < ApplicationController
  before_action :get_item
  before_action :set_pack, only: %i[ show edit update destroy ]

  # GET /packs or /packs.json
  def index
    # @packs = Pack.all
    @packs = @item.packs
  end

  # GET /packs/1 or /packs/1.json
  def show
  end

  # GET /packs/new
  def new
    # @pack = Pack.new
    @pack = @item.packs.build
  end

  # GET /packs/1/edit
  def edit
  end

  # POST /packs or /packs.json
  def create
    @pack = @item.packs.build(pack_params)

    respond_to do |format|
      if @pack.save
        format.html { redirect_to item_packs_path(@item), notice: "Pack was successfully created." }
        format.json { render :show, status: :created, location: @pack }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packs/1 or /packs/1.json
  def update
    respond_to do |format|
      if @pack.update(pack_params)
        format.html { redirect_to item_packs_path(@item), notice: "Pack was successfully updated." }
        format.json { render :show, status: :ok, location: @pack }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packs/1 or /packs/1.json
  def destroy
    @pack.destroy
    respond_to do |format|
      format.html { redirect_to item_packs_path, notice: "Pack was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_item
    @item = Item.find(params[:item_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pack
      @pack = Pack.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pack_params
      params.require(:pack).permit(:quantity, :price)
      # params.fetch(:pack, {})
    end
end
