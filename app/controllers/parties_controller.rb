class PartiesController < ApplicationController
  before_action :set_party, only: [:show, :edit, :update, :destroy,:invitetoparty]
  before_action :authenticate_user!, only: [:create, :edit, :new, :update, :destroy]
  protect_from_forgery :except => :destroy 

  # GET /parties
  # GET /parties.json
  def index
    @parties = Party.order(:time)
    @parties = @parties.paginate(:page => params[:page], :per_page => 20)
  end

  def close_parties
    # @parties = Party.all
    @parties = Party.order(:time)
    @myloc = request.location
    p 'this is close parties'
    gon.parties=@parties
  end

  def myparties
      @parties = Party.order(:time)
      
  end



  # GET /parties/1
  # GET /parties/1.json
  def show
    @users= User.all
    
  end

  def invitetoparty
  
  end


  def upcoming
    current = DateTime.now
    @parties = Party.where("time >= ?", current)
    @parties = @parties.order(:time)
    @parties = @parties.paginate(:page => params[:page], :per_page => 20)
  end

  def past
    current = DateTime.now
    @parties = Party.where("time < ?", current)
    @parties = @parties.order(:time)
    @parties = @parties.paginate(:page => params[:page], :per_page => 20)
  end

  # GET /parties/new
  def new
    @party = Party.new
  end

  # GET /parties/1/edit
  def edit
  end

  def partyrequest
     # @parties = Party.order(:time)
     # @jm = JoinMember.all
     # @user = User.all
  end

  def partyinvites
     # @parties = Party.order(:time)
     # @jm = JoinMember.all
     # @user = User.all
  end

  # POST /parties
  # POST /parties.json
  def create
    @party = Party.new(party_params)
    @party.time = DateTime.new(@party.date.year, @party.date.month, @party.date.day, @party.time.hour, @party.time.min, @party.time.sec, @party.date.zone)

    respond_to do |format|
      if @party.save
        format.html { redirect_to @party, notice: 'Party was successfully created.' }
        format.json { render :show, status: :created, location: @party }
      else
        format.html { render :new }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parties/1
  # PATCH/PUT /parties/1.json
  def update
    respond_to do |format|
      if @party.update(party_params)
        format.html { redirect_to @party, notice: 'Party was successfully updated.' }
        format.json { render :show, status: :ok, location: @party }
      else
        format.html { render :edit }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.json
  def destroy
    @party.destroy
    respond_to do |format|
      format.html { redirect_to parties_url, notice: 'Party was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def party_params
      params.require(:party).permit(:name, :owner, :date, :time, :location, :description, :participants)
    end
end
