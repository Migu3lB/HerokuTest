require "rails_helper"

RSpec.describe UsersController, :type => :controller do

  before do
    stub_user
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the users in the @users" do
      user = User.create!(name: "Andy")
      get :index
      expect(assigns(:users)).to match_array([user])
    end
  end

  describe "GET #show" do

    before do
      @user = User.create!(name: "Andy")
    end

    it "responds successfully with an HTTP 200 status code" do
      get :show, id: @user
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :show, id: @user
      expect(response).to render_template("show")
    end

    it "loads all of the posts into @posts" do
      get :show, id: @user
      expect(assigns(:user)).to match(@user)
    end
  end

  describe "POST #cte" do

    it "responds successfully with an HTTP 302 status code" do
      post :create, user: { name: 'michel' }
      expect(response).to redirect_to users_path
      expect(response).to have_http_status(302) #200 ?
      expect(User.last.name).to eq 'michel'
    end

    it "responds with errors" do
      post :create, user: {}
      expect(response).to render_template('new')
    end

  end

  describe "PUT #update" do

    before do
      @user = User.create!(name: "Andy")
    end

    it "changes the andy name" do
      post :update, id: @user, user: { name: 'michel' }
      expect(response).to redirect_to users_path
      expect(response).to have_http_status(302) #200 ?
      expect(User.last.name).to eq 'michel'
    end

  end

  describe "delete #destroy" do

    before do
      @user = User.create!(name: "Andy")
    end

    it "deletes andy" do
      delete :destroy, id: @user
      expect(response).to redirect_to users_path
      expect(response).to have_http_status(302) #200 ?
      expect(User.count).to eq 0
    end

  end

end