class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :update, :destroy, :show_messages]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    puts "--- inde index with params: #{params.inspect}"
    if params[:category].present?
      @items = Item.where(category: params[:category])
    elsif params[:search]
       @items = Item.search(params[:search]).order("created_at DESC")

    else
      @items = Item.all
    end

    session[:conversations] ||= []

    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])

    @search = Item.search(params[:q])
    @items = @search.result

  #   s3 = Aws::S3::Resource.new(region: 'us-east-1')
  #  @bucket = s3.bucket('sakshi-bucket')

  end

  def show_messages
    @items = Item.all

    session[:conversations] ||= []

    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
  end



  def manage_items
    @my_items = Item.where(user_id: current_user.id)
  end

  # GET /items/1
  # GET /items/1.json
  def show
    if !@booking.present?
      @booking = @item.bookings.new
    end
    @reviews = @item.reviews.includes(:user).all
    @review  = @item.reviews.build(user_id: current_user.id) if current_user
    @review.user = current_user
    @review.user_id = current_user.id
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.user = current_user
    @item.user_id = current_user.id
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    @item.user = current_user
    @item.user_id = current_user.id
    respond_to do |format|
       if is_liking?
         # Toggle whether this photo is liked by the current user
         @item.toggle_liked_by(current_user)
         format.html { redirect_to @item }
         format.json { render :show, status: :ok, location: @item }
       elsif @item.update(item_params)
         format.html { redirect_to @item, notice: 'Item was successfully updated.' }
         format.json { render :show, status: :ok, location: @item }
       else
         format.html { render :edit }
         format.json { render json: @item.errors, status: :unprocessable_entity }
       end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :price, :description, :category, :image, :user_id)
    end

    def is_liking?
       # Is there a `liked` field in the form?
      params.require(:item)[:liked].present?
    end
end
