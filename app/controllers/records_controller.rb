class RecordsController < ApplicationController
  before_action :must_sign_in # 请求前执行 (私有方法除外)

  def index
    render_resources Record.page(params[:page])
  end

  def show
    render_resource Record.find_by_id params[:id]
  end
  def create
    render_resource Record.create create_params
  end

  def destroy
    record = Record.find_by_id params[:id]
    head record.destroy ? :ok : :bad_request
  end

  private #在此以下的方法都是私有的

  def render_resources(resources)
    render json: { resources: resources }
  end

  def create_params
    params.permit(:amount, :category, :notes)
  end
end
