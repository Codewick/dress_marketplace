class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json

  # def preload
  #   room = Item.find(params[:item_id])
  #   today = Date.today
  #   bookings = room.booking.where("start_date >= ? OR end_date >= ?", today, today)
  #
  #   render json: bookings
  # end

  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
    if !@booking.present?
      @booking = @item.bookings.new
    end
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
    @item = Item.find(params[:item_id])
    @booking = @item.bookings.find params[:id]

    @booking.user = current_user
  end

  # POST /bookings
  # POST /bookings.json
  def create
    puts "------params create #{params.inspect}"
    # @booking = current_user.bookings.create(booking_params)
    # redirect_to @booking.item, notice: "Your booking has been created..."
    @item = Item.find(params[:item_id])
    @booking = @item.bookings.build(booking_params)

    @booking.user = current_user

    if params[:commit] == 'Book'
      puts @booking.start_date.strftime("%Y-%m-%d").inspect
      @start_date = @booking.start_date.strftime("%Y-%m-%d")
      @end_date = @booking.end_date.strftime("%Y-%m-%d")

      found = false
      @all_bookings = Booking.all

      @all_bookings.each do |booking|
        if booking.has_paid == TRUE
          start_date= booking.start_date.strftime("%Y-%m-%d")
          end_date = booking.end_date.strftime("%Y-%m-%d")
          if @start_date.between?(start_date, end_date) || @end_date.between?(start_date, end_date)
            if booking.item_id == @booking.item_id
              found = true
            end
          end
        end
      end

      if found == true
        redirect_to request.referrer, notice: "This dress is already booked for this period."
      else
        @booking.save!
        redirect_to edit_item_booking_url(@item,@booking), notice: "You have booked the dress successfully. Please contact owner to fix a time for trial or directly proceed with payment."
      end
    end

    if params[:commit] == 'Pay'
      respond_to do |format|
        if @booking.save && params[:commit] == 'Pay'
          format.html { redirect_to item_booking_url(@item,@booking), notice: 'Invoice' }
          format.json { render :show, status: :created, location: @booking }
          # f.json { render action: 'show', status: :created, location: @step }
        else
          format.html { render action: 'new' }
          format.json { render json: @booking.errors, status: :unprocessable_entity }
        end

      end
    end

  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    puts "------params update #{params.inspect}"
    @item = Item.find(params[:item_id])

    @booking.user = current_user

    respond_to do |format|
      if @booking.update(booking_params)
        @booking.has_paid = TRUE
        @booking.save()
        format.html { redirect_to item_booking_url(@item,@booking), notice: 'Invoice' }
        format.json { render :show, status: :created, location: @booking }
        # f.json { render action: 'show', status: :created, location: @step }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
    @item = Item.find(params[:item_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_params
    params.require(:booking).permit(:user_id, :item_id, :start_date, :end_date, :has_paid, :amount)
  end
end
