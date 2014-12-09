class DocumentsController < ApplicationController
  before_filter :authenticate_user!, except: :show
  before_action :set_document, only: [:show, :destroy]
  before_filter :owns_event!, except: :show
  before_filter :event_is_passed!

  def show
    send_data(@document.file_contents,
              type: @document.content_type,
              filename: @document.filename)
  end

  def new
    @document = Document.new
    @event = Event.find(params[:event_id])
    @event_data = @event.event_data
    render :new
  end

  def create
    @event = Event.find(params[:event_id])
    @document = Document.new(document_params)
    @event_data = @event.event_data
    @event_data.document = @document
    if @document.save
      flash[:success] = "Successfully uploaded File."
      redirect_to @event
    else
      flash[:error] = "Oops, something went wrong!"
      redirect_to new_event_document_path
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @document = Document.find(params[:id])
    if @document.destroy
      flash[:success] = "Successfully deleted File #{@document.filename}."
    else
      flash[:error] = "The File #{@document.filename} could not be deleted!"
    end
    redirect_to @event
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

  def document_params
    params.require(:document).permit(:file)
  end
end
