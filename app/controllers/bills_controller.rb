class BillsController < ApplicationController
  before_action :set_bill, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  def index
  end

  def new
    @bill = Bill.new
  end

  def search
    @bills = Bill.where(user: current_user)
    @bills = @bills.where("notes LIKE ?", "%#{params[:notes]}%") if params[:notes].present?
    @bills = @bills.where("DATE(created_at) = ?", params[:created_at]) if params[:created_at].present?
  end

  def create
    @bill = Bill.new(bill_params)
    @bill.user = current_user

    respond_to do |format|
      if @bill.save
        format.html { redirect_to bills_url, notice: "Bill was successfully created." }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to bill_url(@bill), notice: "Bill was successfully updated." }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bill.destroy!

    respond_to do |format|
      format.html { redirect_to bills_url, notice: "Bill was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_bill
      @bill = Bill.find(params[:id])
    end

    def bill_params
      params.require(:bill).permit(:filename, :notes, :image)
    end
end
