class MemberDivisionsController < ApplicationController
  def create
    division = MemberDivision.new(member_division_params)
    if division.save
      render :json => {:response => division}
    else
      render :status => 400
    end
  end

  private

  def member_division_params
    params.require(:member_division).permit(:name)
  end
end
