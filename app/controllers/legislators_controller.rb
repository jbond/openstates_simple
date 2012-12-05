class LegislatorsController < ApplicationController

  # GET /legislator/IAL000999
  # GET /legislator/IAL000999.json
  def lookup
    @legislator = Legislator.lookup(params[:leg_id])
    if @legislator
  	  render :json => @legislator
	else
      render :json => { :error => "Legislator ID #{params[:leg_id]} not found" }, :status => :not_found
	end
  end

end
