class CallersController < ApplicationController
  before_action :set_caller, only: [:show, :edit, :update, :destroy]

  # GET /callers
  # GET /callers.json
  def index
    @callers = Caller.all
  end

  # GET /callers/1
  # GET /callers/1.json
  def show
  end

  # GET /callers/new
  def new
    @caller = Caller.new
  end

  # GET /callers/1/edit
  def edit
  end

  # POST /callers
  # POST /callers.json
  def create
    @caller = Caller.new(caller_params)

    respond_to do |format|
      if @caller.save
        format.html { redirect_to @caller, notice: 'Caller was successfully created.' }
        format.json { render action: 'show', status: :created, location: @caller }
      else
        format.html { render action: 'new' }
        format.json { render json: @caller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /callers/1
  # PATCH/PUT /callers/1.json
  def update
    respond_to do |format|
      if @caller.update(caller_params)
        format.html { redirect_to @caller, notice: 'Caller was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @caller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /callers/1
  # DELETE /callers/1.json
  def destroy
    @caller.destroy
    respond_to do |format|
      format.html { redirect_to callers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caller
      @caller = Caller.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def caller_params
      params.require(:caller).permit(:name, :number, :activation)
    end
end
