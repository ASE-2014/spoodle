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

  def destroy
    @event_data = EventData.find(params[:event_data_id])
    @event = @event_data.event
    @document = Document.find(params[:id])
    if @document.destroy
      flash[:success] = "Successfully deleted File #{@document.filename}."
    else
      flash[:error] = "The File #{@document.filename} could not be deleted!"
    end
    redirect_to edit_event_event_data_path(@event, @event_data)
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

  def document_params
    params.require(:document).permit(:file)
  end
end
