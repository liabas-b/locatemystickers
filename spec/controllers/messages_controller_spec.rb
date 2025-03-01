require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe MessagesController do

  # This should return the minimal set of attributes required to create a valid
  # Message. As you add validations to Message, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      subject: 'Hi',
      content: 'Hi there!'
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MessagesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all messages as @messages" do
      message = Message.create! valid_attributes
      get :index, {}, valid_session
      assigns(:messages).should eq([message])
    end
  end

  describe "GET show" do
    it "assigns the requested message as @message" do
      message = Message.create! valid_attributes
      get :show, {:id => message.to_param}, valid_session
      assigns(:message).should eq(message)
    end
  end

  describe "GET new" do
    it "assigns a new message as @message" do
      get :new, {}, valid_session
      assigns(:message).should be_a_new(Message)
    end
  end

  describe "GET edit" do
    it "assigns the requested message as @message" do
      message = Message.create! valid_attributes
      get :edit, {:id => message.to_param}, valid_session
      assigns(:message).should eq(message)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Message" do
        expect {
          post :create, {:message => valid_attributes}, valid_session
        }.to change(Message, :count).by(1)
      end

      it "assigns a newly created message as @message" do
        post :create, {:message => valid_attributes}, valid_session
        assigns(:message).should be_a(Message)
        assigns(:message).should be_persisted
      end

      it "redirects to the created message" do
        post :create, {:message => valid_attributes}, valid_session
        response.should redirect_to(Message.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved message as @message" do
        # Trigger the behavior that occurs when invalid params are submitted
        Message.any_instance.stub(:save).and_return(false)
        post :create, {:message => {}}, valid_session
        assigns(:message).should be_a_new(Message)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Message.any_instance.stub(:save).and_return(false)
        post :create, {:message => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested message" do
        message = Message.create! valid_attributes
        # Assuming there are no other messages in the database, this
        # specifies that the Message created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Message.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => message.to_param, :message => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested message as @message" do
        message = Message.create! valid_attributes
        put :update, {:id => message.to_param, :message => valid_attributes}, valid_session
        assigns(:message).should eq(message)
      end

      it "redirects to the message" do
        message = Message.create! valid_attributes
        put :update, {:id => message.to_param, :message => valid_attributes}, valid_session
        response.should redirect_to(message)
      end
    end

    describe "with invalid params" do
      it "assigns the message as @message" do
        message = Message.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Message.any_instance.stub(:save).and_return(false)
        put :update, {:id => message.to_param, :message => {}}, valid_session
        assigns(:message).should eq(message)
      end

      it "re-renders the 'edit' template" do
        message = Message.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Message.any_instance.stub(:save).and_return(false)
        put :update, {:id => message.to_param, :message => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested message" do
      message = Message.create! valid_attributes
      expect {
        delete :destroy, {:id => message.to_param}, valid_session
      }.to change(Message, :count).by(-1)
    end

    it "redirects to the messages list" do
      message = Message.create! valid_attributes
      delete :destroy, {:id => message.to_param}, valid_session
      response.should redirect_to(messages_url)
    end
  end

end
