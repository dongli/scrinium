require 'test_helper'

class ResearchRecordsControllerTest < ActionController::TestCase
  setup do
    @research_record = research_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:research_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create research_record" do
    assert_difference('ResearchRecord.count') do
      post :create, research_record: {  }
    end

    assert_redirected_to research_record_path(assigns(:research_record))
  end

  test "should show research_record" do
    get :show, id: @research_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @research_record
    assert_response :success
  end

  test "should update research_record" do
    patch :update, id: @research_record, research_record: {  }
    assert_redirected_to research_record_path(assigns(:research_record))
  end

  test "should destroy research_record" do
    assert_difference('ResearchRecord.count', -1) do
      delete :destroy, id: @research_record
    end

    assert_redirected_to research_records_path
  end
end
