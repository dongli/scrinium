class ResearchTeamsController < ApplicationController
  before_action :set_research_team, only: [:show, :edit, :update, :destroy]

  # GET /research_teams
  # GET /research_teams.json
  def index
    @research_teams = ResearchTeam.all
  end

  # GET /research_teams/1
  # GET /research_teams/1.json
  def show
  end

  # GET /research_teams/new
  def new
    @research_team = ResearchTeam.new
  end

  # GET /research_teams/1/edit
  def edit
  end

  # POST /research_teams
  # POST /research_teams.json
  def create
    @research_team = ResearchTeam.new(research_team_params)
    # TODO: How to set 'organization_id' elegantly?
    @research_team.organization_id = OrganizationsHelper.current_organization.id

    respond_to do |format|
      if @research_team.save
        format.html { redirect_to @research_team, notice: 'Research team was successfully created.' }
        format.json { render :show, status: :created, location: @research_team }
      else
        format.html { render :new }
        format.json { render json: @research_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /research_teams/1
  # PATCH/PUT /research_teams/1.json
  def update
    respond_to do |format|
      if @research_team.update(research_team_params)
        format.html { redirect_to @research_team, notice: 'Research team was successfully updated.' }
        format.json { render :show, status: :ok, location: @research_team }
      else
        format.html { render :edit }
        format.json { render json: @research_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /research_teams/1
  # DELETE /research_teams/1.json
  def destroy
    @research_team.destroy
    respond_to do |format|
      format.html { redirect_to research_teams_url, notice: 'Research team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_research_team
    @research_team = ResearchTeam.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def research_team_params
    params.require(:research_team).permit(:name,
                                          :short_name,
                                          :description,
                                          :organization_id)
  end
end
