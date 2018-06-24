class UserLogsController < ApplicationController
  include UserLogsHelper

  def index
    @versions = PaperTrail::Version.all.order(:created_at => :desc)
  end
end
