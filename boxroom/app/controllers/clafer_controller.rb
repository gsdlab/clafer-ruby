class ClaferController < ApplicationController
  def view
    @clafer = Clafer.print
    render :text => @clafer, :content_type => Mime::TEXT
  end
end
