require 'rails_helper'

RSpec.describe CharCombatsController, type: :controller do
  include_context "user logs in"

  before do
    @char_combat = double(CharCombat)
    @first_char = double(CharType)
    @second_char = double(CharType)
  end

  describe "POST create" do
    before do
      allow(@user).to receive_message_chain(:char_types, :find_by_id).and_return(@first_char, @second_char)
      allow(CharCombat).to receive(:create!).and_return(@char_combat)
      allow(controller).to receive(:who_won)
      allow(controller).to receive(:combat)

      post :create, :char_combat => { :first_char => 32,
                                      :second_char => 12 }
    end

    it "should assign first character" do
      expect(assigns(:first_char)).to eql(@first_char)
    end

    it "should assign second character" do
      expect(assigns(:second_char)).to eql(@second_char)
    end

    it "should assign the combat" do
      expect(assigns(:char_combat)).to eql(@char_combat)
    end

    it "should redirect to combat result page" do
      expect(response).to redirect_to(char_combat_path(@char_combat))
    end

    it "should have http status redirect" do
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET index" do
    before do
      allow(controller).to receive(:combats).with(false).and_return(@char_combats)
      allow(controller).to receive(:combats).with(true).and_return(@combat_challenges)

      get :index
    end

    it "should assign character combats" do
      expect(assigns(:char_combats)).to eql(@char_combats)
    end

    it "should assign challenges" do
      expect(assigns(:combat_challenges)).to eql(@combat_challenges)
    end

    it "should render index template" do
      expect(response).to render_template("index")
    end

    it "should have successful response" do
      expect(response).to be_success
    end
  end

  describe "GET new" do
    before do
      get :new
    end

    it "should render new template" do
      expect(response).to render_template("new")
    end

    it "should have successful response" do
      expect(response).to be_success
    end
  end

  describe "GET show" do
    before do
      allow(CharCombat).to receive(:find_by_id).and_return(@char_combat)

      get :show, :id => 46
    end

    it "should assign character combat" do
      expect(assigns(:char_combat)).to eql(@char_combat)
    end

    it "shold render show template" do
      expect(response).to render_template("show")
    end

    it "should have successful response" do
      expect(response).to be_success
    end
  end

  describe "DELETE destroy" do
    before do
      allow(CharCombat).to receive(:find_by_id).and_return(@char_combat)
      allow(@char_combat).to receive(:destroy)

      delete :destroy, :id => 46
    end

    it "should assign character combat" do
      expect(assigns(:char_combat)).to eql(@char_combat)
    end

    it "should destroy a character combat" do
      expect(@char_combat).to receive(:destroy)

      delete :destroy, :id => 46
    end

    it "should redirect to combat history page" do
      expect(response).to redirect_to(char_combats_path)
    end

    it "should have http status redirect" do
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "PATCH update" do
    before do
      @char_type = double(CharType)
      allow(@user).to receive_message_chain(:char_types, :find_by_id).and_return(@char_type)
      allow(CharCombat).to receive(:find_by_id).and_return(@char_combat)

      allow(@char_combat).to receive(:first_combatant).and_return(true)
      allow(@char_combat).to receive(:second_combatant=).with(@char_type)

      allow(@char_combat).to receive(:save)

      patch :update, :id => 46, :char_type => 1
    end

    it "should assign character type" do
      expect(assigns(:char_type)).to eql(@char_type)
    end

    it "should assign character combat" do
      expect(assigns(:char_combat)).to eql(@char_combat)
    end

    it "should receive save" do
      expect(@char_combat).to receive(:save)

      patch :update, :id => 46, :char_type => 1
    end

    it "should redirect to combat page" do
      expect(response).to redirect_to(char_combat_path(@char_combat))
    end

    it "should have http status redirect" do
      expect(response).to have_http_status(:redirect)
    end
  end
end
