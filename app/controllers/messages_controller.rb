class MessagesController < ApplicationController
  include ApplicationHelper
  before_filter :column_names
  #before_filter :login_or_oauth_required, except: :create
  helper_method :sort_column, :sort_direction
  before_filter :get_user

  # GET /messages
  # GET /messages.json
  def index
    if (params.has_key?(:user_id) && !params[:user_id].nil?)
      @messages = (User.sent_messages(@user) + @user.messages)
    else
      @messages = Message.all
    end
    @messages = @messages.sort_by { |m| m.created_at }.reverse
    @conversations = @messages.group_by { |message| message.subject }
    if (params.has_key?(:user_id) && !params[:user_id].nil?)
      @title = User.find(params[:user_id]).name + "'s messages"
    else
      @title = "Messages"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @conversations }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    redirect_to user_messages_path(params[:user_id])
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])

    # Set the message subject to recover conversations
    if (@message.from_user_id > 0)
      set_message_subject
    end

    respond_to do |format|
      if @message.save
        format.html { 
          if (@message.from_user_id > 0)
            flash[:success] = 'Message was successfully sent.'
            path = user_messages_path(current_user) + "#message-#{@message.id}"
            redirect_to path
          else # Message comes from the 'contact us' form
            message_from_contact_form
          end
        }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  private

    def column_names
      @column_names = Message.column_names
    end

    def get_user
      if (params.has_key?(:user_id) && !params[:user_id].nil?)
        @user = User.find(params[:user_id])
      else
        @user = current_user
      end
    end

    def set_message_subject
      if (@message.from_user_id == 0)
        @message.subject = "Through contact form"
      else
        other_message = Message.find_by_subject(User.find(@message.user_id).name + " " + User.find(@message.from_user_id).name)
        if (other_message.nil?)
          other_message = Message.find_by_subject(User.find(@message.from_user_id).name + " " + User.find(@message.user_id).name)
        end
        if (other_message.nil?)
          @subject = User.find(@message.from_user_id).name + " " + User.find(@message.user_id).name
        else
          @subject = other_message.subject
        end
        @message.subject = @subject
      end
    end

    def message_from_contact_form
      password = Digest::MD5::hexdigest(@message.subject)
      unknown_sender = User.create!(first_name: @message.subject,
                                   last_name: "(contact form)",
                                   email: @message.subject,
                                   password: password,
                                   password_confirmation: password,
                                   compteur: 0)
      if @message.update_attributes(from_user_id: unknown_sender.id)
        Emailer.welcome_email(User.first).deliver
        flash[:success] = 'Message was successfully sent. Thank you for your interest.'
        redirect_to root_path
      end
    end
end
