class RecordsController < ApplicationController
  before_action :must_sign_in # 请求前执行 (私有方法除外)

  def index
    render_resources Record.page(params[:page])
  end

  def show
    render_resource Record.find_by_id params[:id]
  end

  def create
    #record = Record.create create_params.merge
    # record.user = current_user
    # record.save
    render_resource Record.create create_params.merge user: current_user
  end

  def update
    record = Record.find_by_id params[:id]
    record.update create_params
    render_resource record
  end

  def destroy
    record = Record.find_by_id params[:id]
    head record.destroy ? :ok : :bad_request
  end

  private

  def create_params
    params.permit(:amount, :category, :notes)
  end
end
