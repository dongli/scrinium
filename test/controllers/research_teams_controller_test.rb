require 'test_helper'

class ResearchTeamsControllerTest < ActionController::TestCase
  setup do
    @research_team = research_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:research_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create research_team" do
    assert_difference('ResearchTeam.count') do
      post :create, research_team: {  }
    end

    assert_redirected_to research_team_path(assigns(:research_team))
  end

  test "should show research_team" do
    get :show, id: @research_team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @research_team
    assert_response :success
  end

  test "should update research_team" do
    patch :update, id: @research_team, research_team: {  }
    assert_redirected_to research_team_path(assigns(:research_team))
  end

  test "should destroy research_team" do
    assert_difference('ResearchTeam.count', -1) do
      delete :destroy, id: @research_team
    end

    assert_redirected_to research_teams_path
  end
end
