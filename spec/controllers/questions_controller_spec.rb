require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:article) { FactoryBot.create(:article, :with_question) }
  let(:question) { article.questions.first }

  describe "GET #show" do
    it "redirects if article was not found" do
      get :show, params: { article_id: "not-existing-id", id: question }
      expect(response).to have_http_status(:redirect)
    end

    it "redirects if question was not found" do
      get :show, params: { article_id: article, id: "not-existing-id" }
      expect(response).to have_http_status(:redirect)
    end

    it "returns http success" do
      get :show, params: { article_id: article, id: question }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "redirects if article was not found" do
      get :new, params: { article_id: "not-existing-id" }
      expect(response).to have_http_status(:redirect)
    end

    it "returns http success" do
      get :new, params: { article_id: article }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "redirects if article was not found" do
      post :create, params: {
        article_id: "not-existing-id",
        question: {
          title: "Question 1",
          abstract: "Question 1 abstract",
          answer: "Question 1 answer",
        },
      }
      expect(response).to have_http_status(:redirect)
    end

    it "renders the new template if question was not created" do
      post :create, params: {
        article_id: article,
        question: {
          title: "",
          abstract: "Question 1 abstract",
          answer: "Question 1 answer",
        },
      }
      expect(request).to render_template "questions/new"
    end

    it "returns http success" do
      post :create, params: {
        article_id: article,
        question: {
          title: "Question 1",
          abstract: "Question 1 abstract",
          answer: "Question 1 answer",
        },
      }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #edit" do
    it "redirects if article was not found" do
      get :edit, params: { article_id: "not-existing-id", id: question }
      expect(response).to have_http_status(:redirect)
    end

    it "redirects if question was not found" do
      get :edit, params: { article_id: article, id: "not-existing-id" }
      expect(response).to have_http_status(:redirect)
    end

    it "returns http success" do
      get :edit, params: { article_id: article, id: question }
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    it "redirects if article was not found" do
      put :update, params: {
        article_id: "not-existing-id",
        id: question,
        question: {
          title: "Edit article",
          abstract: "Edited article",
          answer: "Edited answer",
        },
      }
      expect(response).to have_http_status(:redirect)
    end

    it "redirects if question was not found" do
      put :update, params: {
        article_id: article,
        id: "not-existing-id",
        question: {
          title: "Edit article",
          abstract: "Edited article",
          answer: "Edited answer",
        },
      }
      expect(response).to have_http_status(:redirect)
    end

    it "renders the edit template if question was not updated" do
      put :update, params: {
        article_id: article,
        id: question,
        question: {
          title: "",
          abstract: "Edited question",
          answer: "Edited answer"
        },
      }
      expect(request).to render_template "questions/edit"
    end

    it "redirects if question was updated" do
      put :update, params: {
        article_id: article,
        id: question,
        question: {
          title: "Edit question",
          abstract: "Edited question",
          answer: "Edited question",
        },
      }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "DELETE #destroy" do
    it "redirects if article was not found" do
      delete :destroy, params: { article_id: "not-existing-id", id: question }
      expect(response).to have_http_status(:redirect)
    end

    it "redirects if question was not found" do
      delete :destroy, params: { article_id: article, id: "not-existing-id" }
      expect(response).to have_http_status(:redirect)
    end

    it "redirects if question was destroyed" do
      delete :destroy, params: { article_id: article, id: question }
      expect(response).to have_http_status(:redirect)
    end
  end
end
