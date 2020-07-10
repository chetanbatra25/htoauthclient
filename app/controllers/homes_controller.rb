class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]

  # GET /homes
  # GET /homes.json
  def index
    client = OAuth2::Client.new(
      'aGSETwbeKgbUMGq_KCPOssPF6G8S4Ty9N3Je1rCezVg',
      'xznRf_rzZSLxTenplmbMTGbrbQdBYRkcAnokKY6VGXs',
      :site   => 'http://localhost:3002',
      :logger => Logger.new('example.log', 'weekly')
    )

    @auth_url = client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3007/oauth/callback')
    @homes = Home.all
  end

  def callback
    client = OAuth2::Client.new("aGSETwbeKgbUMGq_KCPOssPF6G8S4Ty9N3Je1rCezVg",
      'xznRf_rzZSLxTenplmbMTGbrbQdBYRkcAnokKY6VGXs',
      :site   => 'http://localhost:3002',
      :logger => Logger.new('example.log', 'weekly')
    )
    @token = client.auth_code.get_token(params[:code], :redirect_uri => 'http://localhost:3007/oauth/callback')

    @response = @token.get('http://localhost:3002/api/v2/labs')
    
  end

  # GET /homes/1
  # GET /homes/1.json
  def show
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Home was successfully created.' }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1
  # PATCH/PUT /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to @home, notice: 'Home was successfully updated.' }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @home.destroy
    respond_to do |format|
      format.html { redirect_to homes_url, notice: 'Home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def home_params
      params.fetch(:home, {})
    end
end
