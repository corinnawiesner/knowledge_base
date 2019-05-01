require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:article) { FactoryBot.create(:article, :with_question) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "redirects if article was not found" do
      get :show, params: { id: "not-existing-id" }
      expect(response).to have_http_status(:redirect)
    end

    it "returns http success" do
      get :show, params: { id: article }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "renders the new template if article was not created" do
      post :create, params: {
        article: {
          title: "",
          abstract: "This is a new article",
          question_title: "Question 1",
          question_abstract: "Question 1 abstract",
          question_answer: "Question 1 answer",
        },
      }
      expect(request).to render_template "articles/new"
    end

    it "returns http success" do
      post :create, params: {
        article: {
          title: "New article",
          abstract: "This is a new article",
          question_title: "Question 1",
          question_abstract: "Question 1 abstract",
          question_answer: "Question 1 answer",
        },
      }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #edit" do
    it "redirects if article was not found" do
      get :edit, params: { id: "not-existing-id" }
      expect(response).to have_http_status(:redirect)
    end

    it "returns http success" do
      get :edit, params: { id: article }
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    it "redirects if article was not found" do
      put :update, params: {
        id: "not-existing-id",
        article: {
          title: "Edit article",
          abstract: "Edited article",
        },
      }
      expect(response).to have_http_status(:redirect)
    end

    it "renders the edit template if article was not updated" do
      put :update, params: {
        id: article,
        article: {
          title: "",
          abstract: "Edited article",
        },
      }
      expect(request).to render_template "articles/edit"
    end

    it "redirects if article was updated" do
      put :update, params: {
        id: article,
        article: {
          title: "Edit article",
          abstract: "Edited article",
        },
      }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "DELETE #destroy" do
    it "redirects if article was not found" do
      delete :destroy, params: { id: "not-existing-id" }
      expect(response).to have_http_status(:redirect)
    end

    it "redirects if article was destroyed" do
      delete :destroy, params: { id: article }
      expect(response).to have_http_status(:redirect)
    end
  end
end
