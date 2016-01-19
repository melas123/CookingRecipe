require 'rails_helper'

RSpec.describe IngredientController, type: :controller do
  render_views

  describe "GET #new" do
    
    it "add the ingredient" do
      post :new ,format: :json,name: "Ing"
      expect(response).to have_http_status(:success)
      expect(Ingredient.find_by_name("Ing")).to_not be_nil
    end

    it "didn't get no params" do
      post :new, format: :json
      expect(response).to have_http_status(500)
    end

    it "give a dupplicate name" do
      post :new ,format: :json,name: "Ing"
      post :new ,format: :json,name: "Ing"
      expect(response).to have_http_status(500)
    end

  end

  describe "GET #index" do

    it "returns added ingredients" do
      i = Ingredient.new(:name => "Ing")
      i.save
      get :index,format: :json
      expect(assigns[:ingredients]).to include(i)
    end

    it "returns all ingredients in json format" do
      Ingredient.create!(:name => "Ing1")
      Ingredient.create!(:name => "Ing2")
      get :index,format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(2)
    end

  end

  describe "GET #update" do

    it "change the ingredient name" do
      i = Ingredient.new(:name => "Ing")
      i.save
      json = { :format => 'json', :name => "Ing2", :id => i.id }
      put :update,json
      expect(Ingredient.find(i.id).name).to eq("Ing2")
    end

    it "gets no id" do 
      json = { :format => 'json', :name => "Ing2", :id => nil }
      put :update,json
      expect(response).to have_http_status(500)
    end

    it "gets no name" do 
      json = { :format => 'json', :name => nil, :id => 1 }
      put :update,json
      expect(response).to have_http_status(500)
    end

    it "no existant id" do
      #we know that there's no record with an id = 1324
      json = { :format => 'json', :name => "Ing2", :id => 1324 }
      put :update,json
      expect(response).to have_http_status(500)
    end
  end

  describe "GET #delete" do

    it "deletes when a record is found" do
      i = Ingredient.new(:name => "Ing")
      i.save
      json = { :format => 'json', :id => i.id }
      delete :delete,json
      expect(response).to have_http_status(:success)
      expect(Ingredient.exists?(i.id)).to be false
    end

    it "no existant id" do
      #we know that there's no record with an id = 1324
      json = { :format => 'json', :id => 1324 }
      delete :delete,json
      expect(response).to have_http_status(500)
    end


  end


end
